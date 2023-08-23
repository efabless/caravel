module ibex_tracer (
	clk_i,
	rst_ni,
	hart_id_i,
	rvfi_valid,
	rvfi_order,
	rvfi_insn,
	rvfi_trap,
	rvfi_halt,
	rvfi_intr,
	rvfi_mode,
	rvfi_ixl,
	rvfi_rs1_addr,
	rvfi_rs2_addr,
	rvfi_rs3_addr,
	rvfi_rs1_rdata,
	rvfi_rs2_rdata,
	rvfi_rs3_rdata,
	rvfi_rd_addr,
	rvfi_rd_wdata,
	rvfi_pc_rdata,
	rvfi_pc_wdata,
	rvfi_mem_addr,
	rvfi_mem_rmask,
	rvfi_mem_wmask,
	rvfi_mem_rdata,
	rvfi_mem_wdata
);
	input wire clk_i;
	input wire rst_ni;
	input wire [31:0] hart_id_i;
	input wire rvfi_valid;
	input wire [63:0] rvfi_order;
	input wire [31:0] rvfi_insn;
	input wire rvfi_trap;
	input wire rvfi_halt;
	input wire rvfi_intr;
	input wire [1:0] rvfi_mode;
	input wire [1:0] rvfi_ixl;
	input wire [4:0] rvfi_rs1_addr;
	input wire [4:0] rvfi_rs2_addr;
	input wire [4:0] rvfi_rs3_addr;
	input wire [31:0] rvfi_rs1_rdata;
	input wire [31:0] rvfi_rs2_rdata;
	input wire [31:0] rvfi_rs3_rdata;
	input wire [4:0] rvfi_rd_addr;
	input wire [31:0] rvfi_rd_wdata;
	input wire [31:0] rvfi_pc_rdata;
	input wire [31:0] rvfi_pc_wdata;
	input wire [31:0] rvfi_mem_addr;
	input wire [3:0] rvfi_mem_rmask;
	input wire [3:0] rvfi_mem_wmask;
	input wire [31:0] rvfi_mem_rdata;
	input wire [31:0] rvfi_mem_wdata;
	reg [63:0] unused_rvfi_order = rvfi_order;
	reg unused_rvfi_trap = rvfi_trap;
	reg unused_rvfi_halt = rvfi_halt;
	reg unused_rvfi_intr = rvfi_intr;
	reg [1:0] unused_rvfi_mode = rvfi_mode;
	reg [1:0] unused_rvfi_ixl = rvfi_ixl;
	reg signed [31:0] file_handle;
	string file_name;
	reg [31:0] cycle;
	string decoded_str;
	reg insn_is_compressed;
	localparam [4:0] RS1 = 1;
	localparam [4:0] RS2 = 2;
	localparam [4:0] RS3 = 4;
	localparam [4:0] RD = 8;
	localparam [4:0] MEM = 16;
	reg [4:0] data_accessed;
	reg trace_log_enable;
	initial if ($value$plusargs("ibex_tracer_enable=%b", trace_log_enable)) begin
		if (trace_log_enable == 1'b0)
			$display("%m: Instruction trace disabled.");
	end
	else
		trace_log_enable = 1'b1;
	function automatic string reg_addr_to_str;
		input reg [4:0] addr;
		if (addr < 10)
			reg_addr_to_str = $sformatf(" x%0d", addr);
		else
			reg_addr_to_str = $sformatf("x%0d", addr);
	endfunction
	task automatic printbuffer_dumpline;
		string rvfi_insn_str;
		begin
			if (file_handle == 32'h00000000) begin : sv2v_autoblock_1
				string file_name_base;
				file_name_base = "trace_core";
				$value$plusargs("ibex_tracer_file_base=%s", file_name_base);
				$sformat(file_name, "%s_%h.log", file_name_base, hart_id_i);
				$display("%m: Writing execution trace to %s", file_name);
				file_handle = $fopen(file_name, "w");
				$fwrite(file_handle, "Time\tCycle\tPC\tInsn\tDecoded instruction\tRegister and memory contents\n");
			end
			if (insn_is_compressed)
				rvfi_insn_str = $sformatf("%h", rvfi_insn[15:0]);
			else
				rvfi_insn_str = $sformatf("%h", rvfi_insn);
			$fwrite(file_handle, "%15t\t%d\t%h\t%s\t%s\t", $time, cycle, rvfi_pc_rdata, rvfi_insn_str, decoded_str);
			if ((data_accessed & RS1) != 0)
				$fwrite(file_handle, " %s:0x%08x", reg_addr_to_str(rvfi_rs1_addr), rvfi_rs1_rdata);
			if ((data_accessed & RS2) != 0)
				$fwrite(file_handle, " %s:0x%08x", reg_addr_to_str(rvfi_rs2_addr), rvfi_rs2_rdata);
			if ((data_accessed & RS3) != 0)
				$fwrite(file_handle, " %s:0x%08x", reg_addr_to_str(rvfi_rs3_addr), rvfi_rs3_rdata);
			if ((data_accessed & RD) != 0)
				$fwrite(file_handle, " %s=0x%08x", reg_addr_to_str(rvfi_rd_addr), rvfi_rd_wdata);
			if ((data_accessed & MEM) != 0) begin
				$fwrite(file_handle, " PA:0x%08x", rvfi_mem_addr);
				if (rvfi_mem_rmask != 4'b0000)
					$fwrite(file_handle, " store:0x%08x", rvfi_mem_wdata);
				if (rvfi_mem_wmask != 4'b0000)
					$fwrite(file_handle, " load:0x%08x", rvfi_mem_rdata);
			end
			$fwrite(file_handle, "\n");
		end
	endtask
	function automatic string get_csr_name;
		input reg [11:0] csr_addr;
		case (csr_addr)
			12'd0: get_csr_name = "ustatus";
			12'd4: get_csr_name = "uie";
			12'd5: get_csr_name = "utvec";
			12'd64: get_csr_name = "uscratch";
			12'd65: get_csr_name = "uepc";
			12'd66: get_csr_name = "ucause";
			12'd67: get_csr_name = "utval";
			12'd68: get_csr_name = "uip";
			12'd1: get_csr_name = "fflags";
			12'd2: get_csr_name = "frm";
			12'd3: get_csr_name = "fcsr";
			12'd3072: get_csr_name = "cycle";
			12'd3073: get_csr_name = "time";
			12'd3074: get_csr_name = "instret";
			12'd3075: get_csr_name = "hpmcounter3";
			12'd3076: get_csr_name = "hpmcounter4";
			12'd3077: get_csr_name = "hpmcounter5";
			12'd3078: get_csr_name = "hpmcounter6";
			12'd3079: get_csr_name = "hpmcounter7";
			12'd3080: get_csr_name = "hpmcounter8";
			12'd3081: get_csr_name = "hpmcounter9";
			12'd3082: get_csr_name = "hpmcounter10";
			12'd3083: get_csr_name = "hpmcounter11";
			12'd3084: get_csr_name = "hpmcounter12";
			12'd3085: get_csr_name = "hpmcounter13";
			12'd3086: get_csr_name = "hpmcounter14";
			12'd3087: get_csr_name = "hpmcounter15";
			12'd3088: get_csr_name = "hpmcounter16";
			12'd3089: get_csr_name = "hpmcounter17";
			12'd3090: get_csr_name = "hpmcounter18";
			12'd3091: get_csr_name = "hpmcounter19";
			12'd3092: get_csr_name = "hpmcounter20";
			12'd3093: get_csr_name = "hpmcounter21";
			12'd3094: get_csr_name = "hpmcounter22";
			12'd3095: get_csr_name = "hpmcounter23";
			12'd3096: get_csr_name = "hpmcounter24";
			12'd3097: get_csr_name = "hpmcounter25";
			12'd3098: get_csr_name = "hpmcounter26";
			12'd3099: get_csr_name = "hpmcounter27";
			12'd3100: get_csr_name = "hpmcounter28";
			12'd3101: get_csr_name = "hpmcounter29";
			12'd3102: get_csr_name = "hpmcounter30";
			12'd3103: get_csr_name = "hpmcounter31";
			12'd3200: get_csr_name = "cycleh";
			12'd3201: get_csr_name = "timeh";
			12'd3202: get_csr_name = "instreth";
			12'd3203: get_csr_name = "hpmcounter3h";
			12'd3204: get_csr_name = "hpmcounter4h";
			12'd3205: get_csr_name = "hpmcounter5h";
			12'd3206: get_csr_name = "hpmcounter6h";
			12'd3207: get_csr_name = "hpmcounter7h";
			12'd3208: get_csr_name = "hpmcounter8h";
			12'd3209: get_csr_name = "hpmcounter9h";
			12'd3210: get_csr_name = "hpmcounter10h";
			12'd3211: get_csr_name = "hpmcounter11h";
			12'd3212: get_csr_name = "hpmcounter12h";
			12'd3213: get_csr_name = "hpmcounter13h";
			12'd3214: get_csr_name = "hpmcounter14h";
			12'd3215: get_csr_name = "hpmcounter15h";
			12'd3216: get_csr_name = "hpmcounter16h";
			12'd3217: get_csr_name = "hpmcounter17h";
			12'd3218: get_csr_name = "hpmcounter18h";
			12'd3219: get_csr_name = "hpmcounter19h";
			12'd3220: get_csr_name = "hpmcounter20h";
			12'd3221: get_csr_name = "hpmcounter21h";
			12'd3222: get_csr_name = "hpmcounter22h";
			12'd3223: get_csr_name = "hpmcounter23h";
			12'd3224: get_csr_name = "hpmcounter24h";
			12'd3225: get_csr_name = "hpmcounter25h";
			12'd3226: get_csr_name = "hpmcounter26h";
			12'd3227: get_csr_name = "hpmcounter27h";
			12'd3228: get_csr_name = "hpmcounter28h";
			12'd3229: get_csr_name = "hpmcounter29h";
			12'd3230: get_csr_name = "hpmcounter30h";
			12'd3231: get_csr_name = "hpmcounter31h";
			12'd256: get_csr_name = "sstatus";
			12'd258: get_csr_name = "sedeleg";
			12'd259: get_csr_name = "sideleg";
			12'd260: get_csr_name = "sie";
			12'd261: get_csr_name = "stvec";
			12'd262: get_csr_name = "scounteren";
			12'd320: get_csr_name = "sscratch";
			12'd321: get_csr_name = "sepc";
			12'd322: get_csr_name = "scause";
			12'd323: get_csr_name = "stval";
			12'd324: get_csr_name = "sip";
			12'd384: get_csr_name = "satp";
			12'd3857: get_csr_name = "mvendorid";
			12'd3858: get_csr_name = "marchid";
			12'd3859: get_csr_name = "mimpid";
			12'd3860: get_csr_name = "mhartid";
			12'd768: get_csr_name = "mstatus";
			12'd769: get_csr_name = "misa";
			12'd770: get_csr_name = "medeleg";
			12'd771: get_csr_name = "mideleg";
			12'd772: get_csr_name = "mie";
			12'd773: get_csr_name = "mtvec";
			12'd774: get_csr_name = "mcounteren";
			12'd832: get_csr_name = "mscratch";
			12'd833: get_csr_name = "mepc";
			12'd834: get_csr_name = "mcause";
			12'd835: get_csr_name = "mtval";
			12'd836: get_csr_name = "mip";
			12'd928: get_csr_name = "pmpcfg0";
			12'd929: get_csr_name = "pmpcfg1";
			12'd930: get_csr_name = "pmpcfg2";
			12'd931: get_csr_name = "pmpcfg3";
			12'd944: get_csr_name = "pmpaddr0";
			12'd945: get_csr_name = "pmpaddr1";
			12'd946: get_csr_name = "pmpaddr2";
			12'd947: get_csr_name = "pmpaddr3";
			12'd948: get_csr_name = "pmpaddr4";
			12'd949: get_csr_name = "pmpaddr5";
			12'd950: get_csr_name = "pmpaddr6";
			12'd951: get_csr_name = "pmpaddr7";
			12'd952: get_csr_name = "pmpaddr8";
			12'd953: get_csr_name = "pmpaddr9";
			12'd954: get_csr_name = "pmpaddr10";
			12'd955: get_csr_name = "pmpaddr11";
			12'd956: get_csr_name = "pmpaddr12";
			12'd957: get_csr_name = "pmpaddr13";
			12'd958: get_csr_name = "pmpaddr14";
			12'd959: get_csr_name = "pmpaddr15";
			12'd2816: get_csr_name = "mcycle";
			12'd2818: get_csr_name = "minstret";
			12'd2819: get_csr_name = "mhpmcounter3";
			12'd2820: get_csr_name = "mhpmcounter4";
			12'd2821: get_csr_name = "mhpmcounter5";
			12'd2822: get_csr_name = "mhpmcounter6";
			12'd2823: get_csr_name = "mhpmcounter7";
			12'd2824: get_csr_name = "mhpmcounter8";
			12'd2825: get_csr_name = "mhpmcounter9";
			12'd2826: get_csr_name = "mhpmcounter10";
			12'd2827: get_csr_name = "mhpmcounter11";
			12'd2828: get_csr_name = "mhpmcounter12";
			12'd2829: get_csr_name = "mhpmcounter13";
			12'd2830: get_csr_name = "mhpmcounter14";
			12'd2831: get_csr_name = "mhpmcounter15";
			12'd2832: get_csr_name = "mhpmcounter16";
			12'd2833: get_csr_name = "mhpmcounter17";
			12'd2834: get_csr_name = "mhpmcounter18";
			12'd2835: get_csr_name = "mhpmcounter19";
			12'd2836: get_csr_name = "mhpmcounter20";
			12'd2837: get_csr_name = "mhpmcounter21";
			12'd2838: get_csr_name = "mhpmcounter22";
			12'd2839: get_csr_name = "mhpmcounter23";
			12'd2840: get_csr_name = "mhpmcounter24";
			12'd2841: get_csr_name = "mhpmcounter25";
			12'd2842: get_csr_name = "mhpmcounter26";
			12'd2843: get_csr_name = "mhpmcounter27";
			12'd2844: get_csr_name = "mhpmcounter28";
			12'd2845: get_csr_name = "mhpmcounter29";
			12'd2846: get_csr_name = "mhpmcounter30";
			12'd2847: get_csr_name = "mhpmcounter31";
			12'd2944: get_csr_name = "mcycleh";
			12'd2946: get_csr_name = "minstreth";
			12'd2947: get_csr_name = "mhpmcounter3h";
			12'd2948: get_csr_name = "mhpmcounter4h";
			12'd2949: get_csr_name = "mhpmcounter5h";
			12'd2950: get_csr_name = "mhpmcounter6h";
			12'd2951: get_csr_name = "mhpmcounter7h";
			12'd2952: get_csr_name = "mhpmcounter8h";
			12'd2953: get_csr_name = "mhpmcounter9h";
			12'd2954: get_csr_name = "mhpmcounter10h";
			12'd2955: get_csr_name = "mhpmcounter11h";
			12'd2956: get_csr_name = "mhpmcounter12h";
			12'd2957: get_csr_name = "mhpmcounter13h";
			12'd2958: get_csr_name = "mhpmcounter14h";
			12'd2959: get_csr_name = "mhpmcounter15h";
			12'd2960: get_csr_name = "mhpmcounter16h";
			12'd2961: get_csr_name = "mhpmcounter17h";
			12'd2962: get_csr_name = "mhpmcounter18h";
			12'd2963: get_csr_name = "mhpmcounter19h";
			12'd2964: get_csr_name = "mhpmcounter20h";
			12'd2965: get_csr_name = "mhpmcounter21h";
			12'd2966: get_csr_name = "mhpmcounter22h";
			12'd2967: get_csr_name = "mhpmcounter23h";
			12'd2968: get_csr_name = "mhpmcounter24h";
			12'd2969: get_csr_name = "mhpmcounter25h";
			12'd2970: get_csr_name = "mhpmcounter26h";
			12'd2971: get_csr_name = "mhpmcounter27h";
			12'd2972: get_csr_name = "mhpmcounter28h";
			12'd2973: get_csr_name = "mhpmcounter29h";
			12'd2974: get_csr_name = "mhpmcounter30h";
			12'd2975: get_csr_name = "mhpmcounter31h";
			12'd803: get_csr_name = "mhpmevent3";
			12'd804: get_csr_name = "mhpmevent4";
			12'd805: get_csr_name = "mhpmevent5";
			12'd806: get_csr_name = "mhpmevent6";
			12'd807: get_csr_name = "mhpmevent7";
			12'd808: get_csr_name = "mhpmevent8";
			12'd809: get_csr_name = "mhpmevent9";
			12'd810: get_csr_name = "mhpmevent10";
			12'd811: get_csr_name = "mhpmevent11";
			12'd812: get_csr_name = "mhpmevent12";
			12'd813: get_csr_name = "mhpmevent13";
			12'd814: get_csr_name = "mhpmevent14";
			12'd815: get_csr_name = "mhpmevent15";
			12'd816: get_csr_name = "mhpmevent16";
			12'd817: get_csr_name = "mhpmevent17";
			12'd818: get_csr_name = "mhpmevent18";
			12'd819: get_csr_name = "mhpmevent19";
			12'd820: get_csr_name = "mhpmevent20";
			12'd821: get_csr_name = "mhpmevent21";
			12'd822: get_csr_name = "mhpmevent22";
			12'd823: get_csr_name = "mhpmevent23";
			12'd824: get_csr_name = "mhpmevent24";
			12'd825: get_csr_name = "mhpmevent25";
			12'd826: get_csr_name = "mhpmevent26";
			12'd827: get_csr_name = "mhpmevent27";
			12'd828: get_csr_name = "mhpmevent28";
			12'd829: get_csr_name = "mhpmevent29";
			12'd830: get_csr_name = "mhpmevent30";
			12'd831: get_csr_name = "mhpmevent31";
			12'd1952: get_csr_name = "tselect";
			12'd1953: get_csr_name = "tdata1";
			12'd1954: get_csr_name = "tdata2";
			12'd1955: get_csr_name = "tdata3";
			12'd1968: get_csr_name = "dcsr";
			12'd1969: get_csr_name = "dpc";
			12'd1970: get_csr_name = "dscratch";
			12'd512: get_csr_name = "hstatus";
			12'd514: get_csr_name = "hedeleg";
			12'd515: get_csr_name = "hideleg";
			12'd516: get_csr_name = "hie";
			12'd517: get_csr_name = "htvec";
			12'd576: get_csr_name = "hscratch";
			12'd577: get_csr_name = "hepc";
			12'd578: get_csr_name = "hcause";
			12'd579: get_csr_name = "hbadaddr";
			12'd580: get_csr_name = "hip";
			12'd896: get_csr_name = "mbase";
			12'd897: get_csr_name = "mbound";
			12'd898: get_csr_name = "mibase";
			12'd899: get_csr_name = "mibound";
			12'd900: get_csr_name = "mdbase";
			12'd901: get_csr_name = "mdbound";
			12'd800: get_csr_name = "mcountinhibit";
			default: get_csr_name = $sformatf("0x%x", csr_addr);
		endcase
	endfunction
	task automatic decode_mnemonic;
		input string mnemonic;
		decoded_str = mnemonic;
	endtask
	task automatic decode_r_insn;
		input string mnemonic;
		begin
			data_accessed = (RS1 | RS2) | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d,x%0d", mnemonic, rvfi_rd_addr, rvfi_rs1_addr, rvfi_rs2_addr);
		end
	endtask
	task automatic decode_r1_insn;
		input string mnemonic;
		begin
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d", mnemonic, rvfi_rd_addr, rvfi_rs1_addr);
		end
	endtask
	task automatic decode_r_cmixcmov_insn;
		input string mnemonic;
		begin
			data_accessed = ((RS1 | RS2) | RS3) | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d,x%0d,x%0d", mnemonic, rvfi_rd_addr, rvfi_rs2_addr, rvfi_rs1_addr, rvfi_rs3_addr);
		end
	endtask
	task automatic decode_r_funnelshift_insn;
		input string mnemonic;
		begin
			data_accessed = ((RS1 | RS2) | RS3) | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d,x%0d,x%0d", mnemonic, rvfi_rd_addr, rvfi_rs1_addr, rvfi_rs3_addr, rvfi_rs2_addr);
		end
	endtask
	task automatic decode_i_insn;
		input string mnemonic;
		begin
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d,%0d", mnemonic, rvfi_rd_addr, rvfi_rs1_addr, $signed({{20 {rvfi_insn[31]}}, rvfi_insn[31:20]}));
		end
	endtask
	task automatic decode_i_shift_insn;
		input string mnemonic;
		reg [4:0] shamt;
		begin
			shamt = {rvfi_insn[24:20]};
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d,0x%0x", mnemonic, rvfi_rd_addr, rvfi_rs1_addr, shamt);
		end
	endtask
	task automatic decode_i_funnelshift_insn;
		input string mnemonic;
		reg [5:0] shamt;
		begin
			shamt = {rvfi_insn[25:20]};
			data_accessed = (RS1 | RS3) | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d,x%0d,0x%0x", mnemonic, rvfi_rd_addr, rvfi_rs1_addr, rvfi_rs3_addr, shamt);
		end
	endtask
	task automatic decode_i_jalr_insn;
		input string mnemonic;
		begin
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,%0d(x%0d)", mnemonic, rvfi_rd_addr, $signed({{20 {rvfi_insn[31]}}, rvfi_insn[31:20]}), rvfi_rs1_addr);
		end
	endtask
	task automatic decode_u_insn;
		input string mnemonic;
		begin
			data_accessed = RD;
			decoded_str = $sformatf("%s\tx%0d,0x%0x", mnemonic, rvfi_rd_addr, {rvfi_insn[31:12]});
		end
	endtask
	task automatic decode_j_insn;
		input string mnemonic;
		begin
			data_accessed = RD;
			decoded_str = $sformatf("%s\tx%0d,%0x", mnemonic, rvfi_rd_addr, rvfi_pc_wdata);
		end
	endtask
	task automatic decode_b_insn;
		input string mnemonic;
		reg [31:0] branch_target;
		reg [31:0] imm;
		begin
			imm = $signed({{19 {rvfi_insn[31]}}, rvfi_insn[31], rvfi_insn[7], rvfi_insn[30:25], rvfi_insn[11:8], 1'b0});
			branch_target = rvfi_pc_rdata + imm;
			data_accessed = RS1 | RS2;
			decoded_str = $sformatf("%s\tx%0d,x%0d,%0x", mnemonic, rvfi_rs1_addr, rvfi_rs2_addr, branch_target);
		end
	endtask
	task automatic decode_csr_insn;
		input string mnemonic;
		reg [11:0] csr;
		string csr_name;
		begin
			csr = rvfi_insn[31:20];
			csr_name = get_csr_name(csr);
			data_accessed = RD;
			if (!rvfi_insn[14]) begin
				data_accessed = data_accessed | RS1;
				decoded_str = $sformatf("%s\tx%0d,%s,x%0d", mnemonic, rvfi_rd_addr, csr_name, rvfi_rs1_addr);
			end
			else
				decoded_str = $sformatf("%s\tx%0d,%s,%0d", mnemonic, rvfi_rd_addr, csr_name, {27'b000000000000000000000000000, rvfi_insn[19:15]});
		end
	endtask
	task automatic decode_cr_insn;
		input string mnemonic;
		if (rvfi_rs2_addr == 5'b00000) begin
			if (rvfi_insn[12] == 1'b1)
				data_accessed = RS1 | RD;
			else
				data_accessed = RS1;
			decoded_str = $sformatf("%s\tx%0d", mnemonic, rvfi_rs1_addr);
		end
		else begin
			data_accessed = (RS1 | RS2) | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d", mnemonic, rvfi_rd_addr, rvfi_rs2_addr);
		end
	endtask
	task automatic decode_ci_cli_insn;
		input string mnemonic;
		reg [5:0] imm;
		begin
			imm = {rvfi_insn[12], rvfi_insn[6:2]};
			data_accessed = RD;
			decoded_str = $sformatf("%s\tx%0d,%0d", mnemonic, rvfi_rd_addr, $signed(imm));
		end
	endtask
	task automatic decode_ci_caddi_insn;
		input string mnemonic;
		reg [5:0] nzimm;
		begin
			nzimm = {rvfi_insn[12], rvfi_insn[6:2]};
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,%0d", mnemonic, rvfi_rd_addr, $signed(nzimm));
		end
	endtask
	task automatic decode_ci_caddi16sp_insn;
		input string mnemonic;
		reg [9:0] nzimm;
		begin
			nzimm = {rvfi_insn[12], rvfi_insn[4:3], rvfi_insn[5], rvfi_insn[2], rvfi_insn[6], 4'b0000};
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,%0d", mnemonic, rvfi_rd_addr, $signed(nzimm));
		end
	endtask
	function automatic signed [19:0] sv2v_cast_20_signed;
		input reg signed [19:0] inp;
		sv2v_cast_20_signed = inp;
	endfunction
	task automatic decode_ci_clui_insn;
		input string mnemonic;
		reg [5:0] nzimm;
		begin
			nzimm = {rvfi_insn[12], rvfi_insn[6:2]};
			data_accessed = RD;
			decoded_str = $sformatf("%s\tx%0d,0x%0x", mnemonic, rvfi_rd_addr, sv2v_cast_20_signed($signed(nzimm)));
		end
	endtask
	task automatic decode_ci_cslli_insn;
		input string mnemonic;
		reg [5:0] shamt;
		begin
			shamt = {rvfi_insn[12], rvfi_insn[6:2]};
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,0x%0x", mnemonic, rvfi_rd_addr, shamt);
		end
	endtask
	task automatic decode_ciw_insn;
		input string mnemonic;
		reg [9:0] nzuimm;
		begin
			nzuimm = {rvfi_insn[10:7], rvfi_insn[12:11], rvfi_insn[5], rvfi_insn[6], 2'b00};
			data_accessed = RD;
			decoded_str = $sformatf("%s\tx%0d,x2,%0d", mnemonic, rvfi_rd_addr, nzuimm);
		end
	endtask
	task automatic decode_cb_sr_insn;
		input string mnemonic;
		reg [5:0] shamt;
		begin
			shamt = {rvfi_insn[12], rvfi_insn[6:2]};
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,0x%0x", mnemonic, rvfi_rs1_addr, shamt);
		end
	endtask
	function automatic signed [31:0] sv2v_cast_32_signed;
		input reg signed [31:0] inp;
		sv2v_cast_32_signed = inp;
	endfunction
	task automatic decode_cb_insn;
		input string mnemonic;
		reg [7:0] imm;
		reg [31:0] jump_target;
		if ((rvfi_insn[15:13] == 3'b110) || (rvfi_insn[15:13] == 3'b111)) begin
			imm = {rvfi_insn[12], rvfi_insn[6:5], rvfi_insn[2], rvfi_insn[11:10], rvfi_insn[4:3]};
			jump_target = rvfi_pc_rdata + sv2v_cast_32_signed($signed({imm, 1'b0}));
			data_accessed = RS1;
			decoded_str = $sformatf("%s\tx%0d,%0x", mnemonic, rvfi_rs1_addr, jump_target);
		end
		else if (rvfi_insn[15:13] == 3'b100) begin
			imm = {{2 {rvfi_insn[12]}}, rvfi_insn[12], rvfi_insn[6:2]};
			data_accessed = RS1 | RD;
			decoded_str = $sformatf("%s\tx%0d,%0d", mnemonic, rvfi_rd_addr, $signed(imm));
		end
		else begin
			imm = {rvfi_insn[12], rvfi_insn[6:2], 2'b00};
			data_accessed = RS1;
			decoded_str = $sformatf("%s\tx%0d,0x%0x", mnemonic, rvfi_rs1_addr, imm);
		end
	endtask
	task automatic decode_cs_insn;
		input string mnemonic;
		begin
			data_accessed = (RS1 | RS2) | RD;
			decoded_str = $sformatf("%s\tx%0d,x%0d", mnemonic, rvfi_rd_addr, rvfi_rs2_addr);
		end
	endtask
	task automatic decode_cj_insn;
		input string mnemonic;
		begin
			if (rvfi_insn[15:13] == 3'b001)
				data_accessed = RD;
			decoded_str = $sformatf("%s\t%0x", mnemonic, rvfi_pc_wdata);
		end
	endtask
	localparam [1:0] ibex_tracer_pkg_OPCODE_C0 = 2'b00;
	task automatic decode_compressed_load_insn;
		input string mnemonic;
		reg [7:0] imm;
		begin
			if (rvfi_insn[1:0] == ibex_tracer_pkg_OPCODE_C0)
				imm = {1'b0, rvfi_insn[5], rvfi_insn[12:10], rvfi_insn[6], 2'b00};
			else
				imm = {rvfi_insn[3:2], rvfi_insn[12], rvfi_insn[6:4], 2'b00};
			data_accessed = (RS1 | RD) | MEM;
			decoded_str = $sformatf("%s\tx%0d,%0d(x%0d)", mnemonic, rvfi_rd_addr, imm, rvfi_rs1_addr);
		end
	endtask
	task automatic decode_compressed_store_insn;
		input string mnemonic;
		reg [7:0] imm;
		begin
			if (rvfi_insn[1:0] == ibex_tracer_pkg_OPCODE_C0)
				imm = {1'b0, rvfi_insn[5], rvfi_insn[12:10], rvfi_insn[6], 2'b00};
			else
				imm = {rvfi_insn[8:7], rvfi_insn[12:9], 2'b00};
			data_accessed = (RS1 | RS2) | MEM;
			decoded_str = $sformatf("%s\tx%0d,%0d(x%0d)", mnemonic, rvfi_rs2_addr, imm, rvfi_rs1_addr);
		end
	endtask
	task automatic decode_load_insn;
		string mnemonic;
		reg [2:0] size;
		reg [0:1] _sv2v_jump;
		begin
			_sv2v_jump = 2'b00;
			size = rvfi_insn[14:12];
			if (size == 3'b000)
				mnemonic = "lb";
			else if (size == 3'b001)
				mnemonic = "lh";
			else if (size == 3'b010)
				mnemonic = "lw";
			else if (size == 3'b100)
				mnemonic = "lbu";
			else if (size == 3'b101)
				mnemonic = "lhu";
			else begin
				decode_mnemonic("INVALID");
				_sv2v_jump = 2'b11;
			end
			if (_sv2v_jump == 2'b00) begin
				data_accessed = (RD | RS1) | MEM;
				decoded_str = $sformatf("%s\tx%0d,%0d(x%0d)", mnemonic, rvfi_rd_addr, $signed({{20 {rvfi_insn[31]}}, rvfi_insn[31:20]}), rvfi_rs1_addr);
			end
		end
	endtask
	task automatic decode_store_insn;
		string mnemonic;
		reg [0:1] _sv2v_jump;
		begin
			_sv2v_jump = 2'b00;
			case (rvfi_insn[13:12])
				2'b00: mnemonic = "sb";
				2'b01: mnemonic = "sh";
				2'b10: mnemonic = "sw";
				default: begin
					decode_mnemonic("INVALID");
					_sv2v_jump = 2'b11;
				end
			endcase
			if (_sv2v_jump == 2'b00)
				if (!rvfi_insn[14]) begin
					data_accessed = (RS1 | RS2) | MEM;
					decoded_str = $sformatf("%s\tx%0d,%0d(x%0d)", mnemonic, rvfi_rs2_addr, $signed({{20 {rvfi_insn[31]}}, rvfi_insn[31:25], rvfi_insn[11:7]}), rvfi_rs1_addr);
				end
				else
					decode_mnemonic("INVALID");
		end
	endtask
	function automatic string get_fence_description;
		input reg [3:0] bits;
		string desc;
		begin
			desc = "";
			if (bits[3])
				desc = {desc, "i"};
			if (bits[2])
				desc = {desc, "o"};
			if (bits[1])
				desc = {desc, "r"};
			if (bits[0])
				desc = {desc, "w"};
			get_fence_description = desc;
		end
	endfunction
	task automatic decode_fence;
		string predecessor;
		string successor;
		begin
			predecessor = get_fence_description(rvfi_insn[27:24]);
			successor = get_fence_description(rvfi_insn[23:20]);
			decoded_str = $sformatf("fence\t%s,%s", predecessor, successor);
		end
	endtask
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			cycle <= 0;
		else
			cycle <= cycle + 1;
	final if (file_handle != 32'h00000000)
		$fclose(file_handle);
	always @(posedge clk_i)
		if (rvfi_valid && trace_log_enable)
			printbuffer_dumpline;
	localparam [31:0] ibex_tracer_pkg_INSN_ADD = 32'b0000000zzzzzzzzzz000zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_ADDI = 32'bzzzzzzzzzzzzzzzzz000zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_AND = 32'b0000000zzzzzzzzzz111zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_ANDI = 32'bzzzzzzzzzzzzzzzzz111zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ANDN = 32'b0100000zzzzzzzzzz111zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_AUIPC = 32'bzzzzzzzzzzzzzzzzzzzzzzzzz0010111;
	localparam [31:0] ibex_tracer_pkg_INSN_BDEP = 32'b0100100zzzzzzzzzz110zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_BEQ = 32'bzzzzzzzzzzzzzzzzz000zzzzz1100011;
	localparam [31:0] ibex_tracer_pkg_INSN_BEXT = 32'b0000100zzzzzzzzzz110zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_BFP = 32'b0100100zzzzzzzzzz111zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_BGE = 32'bzzzzzzzzzzzzzzzzz101zzzzz1100011;
	localparam [31:0] ibex_tracer_pkg_INSN_BGEU = 32'bzzzzzzzzzzzzzzzzz111zzzzz1100011;
	localparam [31:0] ibex_tracer_pkg_INSN_BLT = 32'bzzzzzzzzzzzzzzzzz100zzzzz1100011;
	localparam [31:0] ibex_tracer_pkg_INSN_BLTU = 32'bzzzzzzzzzzzzzzzzz110zzzzz1100011;
	localparam [31:0] ibex_tracer_pkg_INSN_BNE = 32'bzzzzzzzzzzzzzzzzz001zzzzz1100011;
	localparam [1:0] ibex_tracer_pkg_OPCODE_C2 = 2'b10;
	localparam [15:0] ibex_tracer_pkg_INSN_CADD = {14'b1001zzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C2}};
	localparam [1:0] ibex_tracer_pkg_OPCODE_C1 = 2'b01;
	localparam [15:0] ibex_tracer_pkg_INSN_CADDI = {14'b000zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CADDI4SPN = {14'b000zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C0}};
	localparam [15:0] ibex_tracer_pkg_INSN_CAND = {14'b100011zzz11zzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CANDI = {14'b100z10zzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CBEQZ = {14'b110zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CBNEZ = {14'b111zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CEBREAK = {14'b10010000000000, {ibex_tracer_pkg_OPCODE_C2}};
	localparam [15:0] ibex_tracer_pkg_INSN_CJ = {14'b101zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CJAL = {14'b001zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CJALR = {14'b1001zzzzz00000, {ibex_tracer_pkg_OPCODE_C2}};
	localparam [15:0] ibex_tracer_pkg_INSN_CJR = {14'b10000000000000, {ibex_tracer_pkg_OPCODE_C2}};
	localparam [15:0] ibex_tracer_pkg_INSN_CLI = {14'b010zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [31:0] ibex_tracer_pkg_INSN_CLMUL = 32'b0000101zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_CLMULH = 32'b0000101zzzzzzzzzz011zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_CLMULR = 32'b0000101zzzzzzzzzz010zzzzz0110011;
	localparam [15:0] ibex_tracer_pkg_INSN_CLUI = {14'b011zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CLW = {14'b010zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C0}};
	localparam [15:0] ibex_tracer_pkg_INSN_CLWSP = {14'b010zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C2}};
	localparam [31:0] ibex_tracer_pkg_INSN_CLZ = 32'b011000000000zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_CMIX = 32'bzzzzz11zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_CMOV = 32'bzzzzz11zzzzzzzzzz101zzzzz0110011;
	localparam [15:0] ibex_tracer_pkg_INSN_CMV = {14'b1000zzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C2}};
	localparam [15:0] ibex_tracer_pkg_INSN_COR = {14'b100011zzz10zzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [31:0] ibex_tracer_pkg_INSN_CRC32C_B = 32'b011000011000zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_CRC32C_H = 32'b011000011001zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_CRC32C_W = 32'b011000011010zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_CRC32_B = 32'b011000010000zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_CRC32_H = 32'b011000010001zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_CRC32_W = 32'b011000010010zzzzz001zzzzz0010011;
	localparam [15:0] ibex_tracer_pkg_INSN_CSLLI = {14'b000zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C2}};
	localparam [15:0] ibex_tracer_pkg_INSN_CSRAI = {14'b100z01zzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CSRLI = {14'b100z00zzzzzzzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [31:0] ibex_tracer_pkg_INSN_CSRRC = 32'bzzzzzzzzzzzzzzzzz011zzzzz1110011;
	localparam [31:0] ibex_tracer_pkg_INSN_CSRRCI = 32'bzzzzzzzzzzzzzzzzz111zzzzz1110011;
	localparam [31:0] ibex_tracer_pkg_INSN_CSRRS = 32'bzzzzzzzzzzzzzzzzz010zzzzz1110011;
	localparam [31:0] ibex_tracer_pkg_INSN_CSRRSI = 32'bzzzzzzzzzzzzzzzzz110zzzzz1110011;
	localparam [31:0] ibex_tracer_pkg_INSN_CSRRW = 32'bzzzzzzzzzzzzzzzzz001zzzzz1110011;
	localparam [31:0] ibex_tracer_pkg_INSN_CSRRWI = 32'bzzzzzzzzzzzzzzzzz101zzzzz1110011;
	localparam [15:0] ibex_tracer_pkg_INSN_CSUB = {14'b100011zzz00zzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [15:0] ibex_tracer_pkg_INSN_CSW = {14'b110zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C0}};
	localparam [31:0] ibex_tracer_pkg_INSN_CTZ = 32'b011000000001zzzzz001zzzzz0010011;
	localparam [15:0] ibex_tracer_pkg_INSN_CXOR = {14'b100011zzz01zzz, {ibex_tracer_pkg_OPCODE_C1}};
	localparam [31:0] ibex_tracer_pkg_INSN_DIV = 32'b0000001zzzzzzzzzz100zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_DIVU = 32'b0000001zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_DRET = 32'b01111011001000000000000001110011;
	localparam [31:0] ibex_tracer_pkg_INSN_EBREAK = 32'b00000000000100000000000001110011;
	localparam [31:0] ibex_tracer_pkg_INSN_ECALL = 32'b00000000000000000000000001110011;
	localparam [31:0] ibex_tracer_pkg_INSN_FENCE = 32'bzzzzzzzzzzzzzzzzz000zzzzz0001111;
	localparam [31:0] ibex_tracer_pkg_INSN_FENCEI = 32'b00000000000000000001000000001111;
	localparam [31:0] ibex_tracer_pkg_INSN_FSL = 32'bzzzzz10zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_FSR = 32'bzzzzz10zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_FSRI = 32'bzzzzz1zzzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_GORC = 32'b0010100zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_GORCI = 32'b001010zzzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_GREV = 32'b0110100zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_GREVI = 32'b011010zzzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_JAL = 32'bzzzzzzzzzzzzzzzzzzzzzzzzz1101111;
	localparam [31:0] ibex_tracer_pkg_INSN_JALR = 32'bzzzzzzzzzzzzzzzzz000zzzzz1100111;
	localparam [31:0] ibex_tracer_pkg_INSN_LOAD = 32'bzzzzzzzzzzzzzzzzzzzzzzzzz0000011;
	localparam [31:0] ibex_tracer_pkg_INSN_LUI = 32'bzzzzzzzzzzzzzzzzzzzzzzzzz0110111;
	localparam [31:0] ibex_tracer_pkg_INSN_MAX = 32'b0000101zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_MAXU = 32'b0000101zzzzzzzzzz111zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_MIN = 32'b0000101zzzzzzzzzz100zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_MINU = 32'b0000101zzzzzzzzzz110zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_MRET = 32'b00110000001000000000000001110011;
	localparam [31:0] ibex_tracer_pkg_INSN_OR = 32'b0000000zzzzzzzzzz110zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC = 32'b001010z11111zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC16 = 32'b001010z10000zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC2 = 32'b001010z11110zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC2_B = 32'b001010z00110zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC2_H = 32'b001010z01110zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC2_N = 32'b001010z00010zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC4 = 32'b001010z11100zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC4_B = 32'b001010z00100zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC4_H = 32'b001010z01100zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC8 = 32'b001010z11000zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC8_H = 32'b001010z01000zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC_B = 32'b001010z00111zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC_H = 32'b001010z01111zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC_N = 32'b001010z00011zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORC_P = 32'b001010z00001zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORI = 32'bzzzzzzzzzzzzzzzzz110zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ORN = 32'b0100000zzzzzzzzzz110zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_PACK = 32'b0000100zzzzzzzzzz100zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_PACKH = 32'b0000100zzzzzzzzzz111zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_PACKU = 32'b0100100zzzzzzzzzz100zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_PCNT = 32'b011000000010zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_PMUH = 32'b0000001zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_PMUL = 32'b0000001zzzzzzzzzz000zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_PMULHSU = 32'b0000001zzzzzzzzzz010zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_PMULHU = 32'b0000001zzzzzzzzzz011zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_REM = 32'b0000001zzzzzzzzzz110zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_REMU = 32'b0000001zzzzzzzzzz111zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV = 32'b011010z11111zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV16 = 32'b011010z10000zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV2 = 32'b011010z11110zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV2_B = 32'b011010z00110zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV2_H = 32'b011010z01110zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV2_N = 32'b011010z00010zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV4 = 32'b011010z11100zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV4_B = 32'b011010z00100zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV4_H = 32'b011010z01100zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV8 = 32'b011010z11000zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV8_H = 32'b011010z01000zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV_B = 32'b011010z00111zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV_H = 32'b011010z01111zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV_N = 32'b011010z00011zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_REV_P = 32'b011010z00001zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ROL = 32'b0110000zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_ROR = 32'b0110000zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_RORI = 32'b011000zzzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SBCLR = 32'b0100100zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SBCLRI = 32'b01001zzzzzzzzzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SBEXT = 32'b0100100zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SBEXTI = 32'b010010zzzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SBINV = 32'b0110100zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SBINVI = 32'b01101zzzzzzzzzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SBSET = 32'b0010100zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SBSETI = 32'b00101zzzzzzzzzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SEXTB = 32'b011000000100zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SEXTH = 32'b011000000101zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SHFL = 32'b0000100zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SHFLI = 32'b000010zzzzzzzzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SLL = 32'b0000000zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SLLI = 32'b0000000zzzzzzzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SLO = 32'b0010000zzzzzzzzzz001zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SLOI = 32'b00100zzzzzzzzzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SLT = 32'b0000000zzzzzzzzzz010zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SLTI = 32'bzzzzzzzzzzzzzzzzz010zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SLTIU = 32'bzzzzzzzzzzzzzzzzz011zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SLTU = 32'b0000000zzzzzzzzzz011zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SRA = 32'b0100000zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SRAI = 32'b0100000zzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SRL = 32'b0000000zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SRLI = 32'b0000000zzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_SRO = 32'b0010000zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_SROI = 32'b001000zzzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_STORE = 32'bzzzzzzzzzzzzzzzzzzzzzzzzz0100011;
	localparam [31:0] ibex_tracer_pkg_INSN_SUB = 32'b0100000zzzzzzzzzz000zzzzz0110011;
	localparam [15:0] ibex_tracer_pkg_INSN_SWSP = {14'b110zzzzzzzzzzz, {ibex_tracer_pkg_OPCODE_C2}};
	localparam [31:0] ibex_tracer_pkg_INSN_UNSHFL = 32'b0000100zzzzzzzzzz101zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNSHFLI = 32'b000010zzzzzzzzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP = 32'b000010zz1111zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP2 = 32'b000010zz1110zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP2_B = 32'b000010zz0010zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP2_H = 32'b000010zz0110zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP4 = 32'b000010zz1100zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP4_H = 32'b000010zz0100zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP8 = 32'b000010zz1000zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP_B = 32'b000010zz0011zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP_H = 32'b000010zz0111zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_UNZIP_N = 32'b000010zz0001zzzzz101zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_WFI = 32'b00010000010100000000000001110011;
	localparam [31:0] ibex_tracer_pkg_INSN_XNOR = 32'b0100000zzzzzzzzzz100zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_XOR = 32'b0000000zzzzzzzzzz100zzzzz0110011;
	localparam [31:0] ibex_tracer_pkg_INSN_XORI = 32'bzzzzzzzzzzzzzzzzz100zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP = 32'b000010zz1111zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP2 = 32'b000010zz1110zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP2_B = 32'b000010zz0010zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP2_H = 32'b000010zz0110zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP4 = 32'b000010zz1100zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP4_H = 32'b000010zz0100zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP8 = 32'b000010zz1000zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP_B = 32'b000010zz0011zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP_H = 32'b000010zz0111zzzzz001zzzzz0010011;
	localparam [31:0] ibex_tracer_pkg_INSN_ZIP_N = 32'b000010zz0001zzzzz001zzzzz0010011;
	always @(*) begin
		decoded_str = "";
		data_accessed = 5'h00;
		insn_is_compressed = 0;
		if (rvfi_insn[1:0] != 2'b11) begin
			insn_is_compressed = 1;
			if ((rvfi_insn[15:13] == ibex_tracer_pkg_INSN_CMV[15:13]) && (rvfi_insn[1:0] == ibex_tracer_pkg_OPCODE_C2)) begin
				if (rvfi_insn[12] == ibex_tracer_pkg_INSN_CADD[12]) begin
					if (rvfi_insn[11:2] == ibex_tracer_pkg_INSN_CEBREAK[11:2])
						decode_mnemonic("c.ebreak");
					else if (rvfi_insn[6:2] == ibex_tracer_pkg_INSN_CJALR[6:2])
						decode_cr_insn("c.jalr");
					else
						decode_cr_insn("c.add");
				end
				else if (rvfi_insn[6:2] == ibex_tracer_pkg_INSN_CJR[6:2])
					decode_cr_insn("c.jr");
				else
					decode_cr_insn("c.mv");
			end
			else
				casez (rvfi_insn[15:0])
					ibex_tracer_pkg_INSN_CADDI4SPN:
						if (rvfi_insn[12:2] == 11'h000)
							decode_mnemonic("c.unimp");
						else
							decode_ciw_insn("c.addi4spn");
					ibex_tracer_pkg_INSN_CLW:
						decode_compressed_load_insn("c.lw");
					ibex_tracer_pkg_INSN_CSW:
						decode_compressed_store_insn("c.sw");
					ibex_tracer_pkg_INSN_CADDI:
						decode_ci_caddi_insn("c.addi");
					ibex_tracer_pkg_INSN_CJAL:
						decode_cj_insn("c.jal");
					ibex_tracer_pkg_INSN_CJ:
						decode_cj_insn("c.j");
					ibex_tracer_pkg_INSN_CLI:
						decode_ci_cli_insn("c.li");
					ibex_tracer_pkg_INSN_CLUI:
						if (rvfi_insn[11:7] == 5'd2)
							decode_ci_caddi16sp_insn("c.addi16sp");
						else
							decode_ci_clui_insn("c.lui");
					ibex_tracer_pkg_INSN_CSRLI:
						decode_cb_sr_insn("c.srli");
					ibex_tracer_pkg_INSN_CSRAI:
						decode_cb_sr_insn("c.srai");
					ibex_tracer_pkg_INSN_CANDI:
						decode_cb_insn("c.andi");
					ibex_tracer_pkg_INSN_CSUB:
						decode_cs_insn("c.sub");
					ibex_tracer_pkg_INSN_CXOR:
						decode_cs_insn("c.xor");
					ibex_tracer_pkg_INSN_COR:
						decode_cs_insn("c.or");
					ibex_tracer_pkg_INSN_CAND:
						decode_cs_insn("c.and");
					ibex_tracer_pkg_INSN_CBEQZ:
						decode_cb_insn("c.beqz");
					ibex_tracer_pkg_INSN_CBNEZ:
						decode_cb_insn("c.bnez");
					ibex_tracer_pkg_INSN_CSLLI:
						decode_ci_cslli_insn("c.slli");
					ibex_tracer_pkg_INSN_CLWSP:
						decode_compressed_load_insn("c.lwsp");
					ibex_tracer_pkg_INSN_SWSP:
						decode_compressed_store_insn("c.swsp");
					default:
						decode_mnemonic("INVALID");
				endcase
		end
		else
			casez (rvfi_insn)
				ibex_tracer_pkg_INSN_LUI:
					decode_u_insn("lui");
				ibex_tracer_pkg_INSN_AUIPC:
					decode_u_insn("auipc");
				ibex_tracer_pkg_INSN_JAL:
					decode_j_insn("jal");
				ibex_tracer_pkg_INSN_JALR:
					decode_i_jalr_insn("jalr");
				ibex_tracer_pkg_INSN_BEQ:
					decode_b_insn("beq");
				ibex_tracer_pkg_INSN_BNE:
					decode_b_insn("bne");
				ibex_tracer_pkg_INSN_BLT:
					decode_b_insn("blt");
				ibex_tracer_pkg_INSN_BGE:
					decode_b_insn("bge");
				ibex_tracer_pkg_INSN_BLTU:
					decode_b_insn("bltu");
				ibex_tracer_pkg_INSN_BGEU:
					decode_b_insn("bgeu");
				ibex_tracer_pkg_INSN_ADDI:
					if (rvfi_insn == 32'h00000013)
						decode_i_insn("addi");
					else
						decode_i_insn("addi");
				ibex_tracer_pkg_INSN_SLTI:
					decode_i_insn("slti");
				ibex_tracer_pkg_INSN_SLTIU:
					decode_i_insn("sltiu");
				ibex_tracer_pkg_INSN_XORI:
					decode_i_insn("xori");
				ibex_tracer_pkg_INSN_ORI:
					decode_i_insn("ori");
				ibex_tracer_pkg_INSN_ANDI:
					decode_i_insn("andi");
				ibex_tracer_pkg_INSN_SLLI:
					decode_i_shift_insn("slli");
				ibex_tracer_pkg_INSN_SRLI:
					decode_i_shift_insn("srli");
				ibex_tracer_pkg_INSN_SRAI:
					decode_i_shift_insn("srai");
				ibex_tracer_pkg_INSN_ADD:
					decode_r_insn("add");
				ibex_tracer_pkg_INSN_SUB:
					decode_r_insn("sub");
				ibex_tracer_pkg_INSN_SLL:
					decode_r_insn("sll");
				ibex_tracer_pkg_INSN_SLT:
					decode_r_insn("slt");
				ibex_tracer_pkg_INSN_SLTU:
					decode_r_insn("sltu");
				ibex_tracer_pkg_INSN_XOR:
					decode_r_insn("xor");
				ibex_tracer_pkg_INSN_SRL:
					decode_r_insn("srl");
				ibex_tracer_pkg_INSN_SRA:
					decode_r_insn("sra");
				ibex_tracer_pkg_INSN_OR:
					decode_r_insn("or");
				ibex_tracer_pkg_INSN_AND:
					decode_r_insn("and");
				ibex_tracer_pkg_INSN_CSRRW:
					decode_csr_insn("csrrw");
				ibex_tracer_pkg_INSN_CSRRS:
					decode_csr_insn("csrrs");
				ibex_tracer_pkg_INSN_CSRRC:
					decode_csr_insn("csrrc");
				ibex_tracer_pkg_INSN_CSRRWI:
					decode_csr_insn("csrrwi");
				ibex_tracer_pkg_INSN_CSRRSI:
					decode_csr_insn("csrrsi");
				ibex_tracer_pkg_INSN_CSRRCI:
					decode_csr_insn("csrrci");
				ibex_tracer_pkg_INSN_ECALL:
					decode_mnemonic("ecall");
				ibex_tracer_pkg_INSN_EBREAK:
					decode_mnemonic("ebreak");
				ibex_tracer_pkg_INSN_MRET:
					decode_mnemonic("mret");
				ibex_tracer_pkg_INSN_DRET:
					decode_mnemonic("dret");
				ibex_tracer_pkg_INSN_WFI:
					decode_mnemonic("wfi");
				ibex_tracer_pkg_INSN_PMUL:
					decode_r_insn("mul");
				ibex_tracer_pkg_INSN_PMUH:
					decode_r_insn("mulh");
				ibex_tracer_pkg_INSN_PMULHSU:
					decode_r_insn("mulhsu");
				ibex_tracer_pkg_INSN_PMULHU:
					decode_r_insn("mulhu");
				ibex_tracer_pkg_INSN_DIV:
					decode_r_insn("div");
				ibex_tracer_pkg_INSN_DIVU:
					decode_r_insn("divu");
				ibex_tracer_pkg_INSN_REM:
					decode_r_insn("rem");
				ibex_tracer_pkg_INSN_REMU:
					decode_r_insn("remu");
				ibex_tracer_pkg_INSN_LOAD:
					decode_load_insn;
				ibex_tracer_pkg_INSN_STORE:
					decode_store_insn;
				ibex_tracer_pkg_INSN_FENCE:
					decode_fence;
				ibex_tracer_pkg_INSN_FENCEI:
					decode_mnemonic("fence.i");
				ibex_tracer_pkg_INSN_SLOI:
					decode_i_shift_insn("sloi");
				ibex_tracer_pkg_INSN_SROI:
					decode_i_shift_insn("sroi");
				ibex_tracer_pkg_INSN_RORI:
					decode_i_shift_insn("rori");
				ibex_tracer_pkg_INSN_SLO:
					decode_r_insn("slo");
				ibex_tracer_pkg_INSN_SRO:
					decode_r_insn("sro");
				ibex_tracer_pkg_INSN_ROL:
					decode_r_insn("rol");
				ibex_tracer_pkg_INSN_ROR:
					decode_r_insn("ror");
				ibex_tracer_pkg_INSN_MIN:
					decode_r_insn("min");
				ibex_tracer_pkg_INSN_MAX:
					decode_r_insn("max");
				ibex_tracer_pkg_INSN_MINU:
					decode_r_insn("minu");
				ibex_tracer_pkg_INSN_MAXU:
					decode_r_insn("maxu");
				ibex_tracer_pkg_INSN_XNOR:
					decode_r_insn("xnor");
				ibex_tracer_pkg_INSN_ORN:
					decode_r_insn("orn");
				ibex_tracer_pkg_INSN_ANDN:
					decode_r_insn("andn");
				ibex_tracer_pkg_INSN_PACK:
					decode_r_insn("pack");
				ibex_tracer_pkg_INSN_PACKH:
					decode_r_insn("packh");
				ibex_tracer_pkg_INSN_PACKU:
					decode_r_insn("packu");
				ibex_tracer_pkg_INSN_CLZ:
					decode_r1_insn("clz");
				ibex_tracer_pkg_INSN_CTZ:
					decode_r1_insn("ctz");
				ibex_tracer_pkg_INSN_PCNT:
					decode_r1_insn("pcnt");
				ibex_tracer_pkg_INSN_SEXTB:
					decode_r1_insn("sext.b");
				ibex_tracer_pkg_INSN_SEXTH:
					decode_r1_insn("sext.h");
				ibex_tracer_pkg_INSN_SBCLRI:
					decode_i_insn("sbclri");
				ibex_tracer_pkg_INSN_SBSETI:
					decode_i_insn("sbseti");
				ibex_tracer_pkg_INSN_SBINVI:
					decode_i_insn("sbinvi");
				ibex_tracer_pkg_INSN_SBEXTI:
					decode_i_insn("sbexti");
				ibex_tracer_pkg_INSN_SBCLR:
					decode_r_insn("sbclr");
				ibex_tracer_pkg_INSN_SBSET:
					decode_r_insn("sbset");
				ibex_tracer_pkg_INSN_SBINV:
					decode_r_insn("sbinv");
				ibex_tracer_pkg_INSN_SBEXT:
					decode_r_insn("sbext");
				ibex_tracer_pkg_INSN_BDEP:
					decode_r_insn("bdep");
				ibex_tracer_pkg_INSN_BEXT:
					decode_r_insn("bext");
				ibex_tracer_pkg_INSN_GREV:
					decode_r_insn("grev");
				ibex_tracer_pkg_INSN_GREVI:
					casez (rvfi_insn)
						ibex_tracer_pkg_INSN_REV_P:
							decode_r1_insn("rev.p");
						ibex_tracer_pkg_INSN_REV2_N:
							decode_r1_insn("rev2.n");
						ibex_tracer_pkg_INSN_REV_N:
							decode_r1_insn("rev.n");
						ibex_tracer_pkg_INSN_REV4_B:
							decode_r1_insn("rev4.b");
						ibex_tracer_pkg_INSN_REV2_B:
							decode_r1_insn("rev2.b");
						ibex_tracer_pkg_INSN_REV_B:
							decode_r1_insn("rev.b");
						ibex_tracer_pkg_INSN_REV8_H:
							decode_r1_insn("rev8.h");
						ibex_tracer_pkg_INSN_REV4_H:
							decode_r1_insn("rev4.h");
						ibex_tracer_pkg_INSN_REV2_H:
							decode_r1_insn("rev2.h");
						ibex_tracer_pkg_INSN_REV_H:
							decode_r1_insn("rev.h");
						ibex_tracer_pkg_INSN_REV16:
							decode_r1_insn("rev16");
						ibex_tracer_pkg_INSN_REV8:
							decode_r1_insn("rev8");
						ibex_tracer_pkg_INSN_REV4:
							decode_r1_insn("rev4");
						ibex_tracer_pkg_INSN_REV2:
							decode_r1_insn("rev2");
						ibex_tracer_pkg_INSN_REV:
							decode_r1_insn("rev");
						default:
							decode_i_insn("grevi");
					endcase
				ibex_tracer_pkg_INSN_GORC:
					decode_r_insn("gorc");
				ibex_tracer_pkg_INSN_GORCI:
					casez (rvfi_insn)
						ibex_tracer_pkg_INSN_ORC_P:
							decode_r1_insn("orc.p");
						ibex_tracer_pkg_INSN_ORC2_N:
							decode_r1_insn("orc2.n");
						ibex_tracer_pkg_INSN_ORC_N:
							decode_r1_insn("orc.n");
						ibex_tracer_pkg_INSN_ORC4_B:
							decode_r1_insn("orc4.b");
						ibex_tracer_pkg_INSN_ORC2_B:
							decode_r1_insn("orc2.b");
						ibex_tracer_pkg_INSN_ORC_B:
							decode_r1_insn("orc.b");
						ibex_tracer_pkg_INSN_ORC8_H:
							decode_r1_insn("orc8.h");
						ibex_tracer_pkg_INSN_ORC4_H:
							decode_r1_insn("orc4.h");
						ibex_tracer_pkg_INSN_ORC2_H:
							decode_r1_insn("orc2.h");
						ibex_tracer_pkg_INSN_ORC_H:
							decode_r1_insn("orc.h");
						ibex_tracer_pkg_INSN_ORC16:
							decode_r1_insn("orc16");
						ibex_tracer_pkg_INSN_ORC8:
							decode_r1_insn("orc8");
						ibex_tracer_pkg_INSN_ORC4:
							decode_r1_insn("orc4");
						ibex_tracer_pkg_INSN_ORC2:
							decode_r1_insn("orc2");
						ibex_tracer_pkg_INSN_ORC:
							decode_r1_insn("orc");
						default:
							decode_i_insn("gorci");
					endcase
				ibex_tracer_pkg_INSN_SHFL:
					decode_r_insn("shfl");
				ibex_tracer_pkg_INSN_SHFLI:
					casez (rvfi_insn)
						ibex_tracer_pkg_INSN_ZIP_N:
							decode_r1_insn("zip.n");
						ibex_tracer_pkg_INSN_ZIP2_B:
							decode_r1_insn("zip2.b");
						ibex_tracer_pkg_INSN_ZIP_B:
							decode_r1_insn("zip.b");
						ibex_tracer_pkg_INSN_ZIP4_H:
							decode_r1_insn("zip4.h");
						ibex_tracer_pkg_INSN_ZIP2_H:
							decode_r1_insn("zip2.h");
						ibex_tracer_pkg_INSN_ZIP_H:
							decode_r1_insn("zip.h");
						ibex_tracer_pkg_INSN_ZIP8:
							decode_r1_insn("zip8");
						ibex_tracer_pkg_INSN_ZIP4:
							decode_r1_insn("zip4");
						ibex_tracer_pkg_INSN_ZIP2:
							decode_r1_insn("zip2");
						ibex_tracer_pkg_INSN_ZIP:
							decode_r1_insn("zip");
						default:
							decode_i_insn("shfli");
					endcase
				ibex_tracer_pkg_INSN_UNSHFL:
					decode_r_insn("unshfl");
				ibex_tracer_pkg_INSN_UNSHFLI:
					casez (rvfi_insn)
						ibex_tracer_pkg_INSN_UNZIP_N:
							decode_r1_insn("unzip.n");
						ibex_tracer_pkg_INSN_UNZIP2_B:
							decode_r1_insn("unzip2.b");
						ibex_tracer_pkg_INSN_UNZIP_B:
							decode_r1_insn("unzip.b");
						ibex_tracer_pkg_INSN_UNZIP4_H:
							decode_r1_insn("unzip4.h");
						ibex_tracer_pkg_INSN_UNZIP2_H:
							decode_r1_insn("unzip2.h");
						ibex_tracer_pkg_INSN_UNZIP_H:
							decode_r1_insn("unzip.h");
						ibex_tracer_pkg_INSN_UNZIP8:
							decode_r1_insn("unzip8");
						ibex_tracer_pkg_INSN_UNZIP4:
							decode_r1_insn("unzip4");
						ibex_tracer_pkg_INSN_UNZIP2:
							decode_r1_insn("unzip2");
						ibex_tracer_pkg_INSN_UNZIP:
							decode_r1_insn("unzip");
						default:
							decode_i_insn("unshfli");
					endcase
				ibex_tracer_pkg_INSN_CMIX:
					decode_r_cmixcmov_insn("cmix");
				ibex_tracer_pkg_INSN_CMOV:
					decode_r_cmixcmov_insn("cmov");
				ibex_tracer_pkg_INSN_FSR:
					decode_r_funnelshift_insn("fsr");
				ibex_tracer_pkg_INSN_FSL:
					decode_r_funnelshift_insn("fsl");
				ibex_tracer_pkg_INSN_FSRI:
					decode_i_funnelshift_insn("fsri");
				ibex_tracer_pkg_INSN_BFP:
					decode_r_insn("bfp");
				ibex_tracer_pkg_INSN_CLMUL:
					decode_r_insn("clmul");
				ibex_tracer_pkg_INSN_CLMULR:
					decode_r_insn("clmulr");
				ibex_tracer_pkg_INSN_CLMULH:
					decode_r_insn("clmulh");
				ibex_tracer_pkg_INSN_CRC32_B:
					decode_r1_insn("crc32.b");
				ibex_tracer_pkg_INSN_CRC32_H:
					decode_r1_insn("crc32.h");
				ibex_tracer_pkg_INSN_CRC32_W:
					decode_r1_insn("crc32.w");
				ibex_tracer_pkg_INSN_CRC32C_B:
					decode_r1_insn("crc32c.b");
				ibex_tracer_pkg_INSN_CRC32C_H:
					decode_r1_insn("crc32c.h");
				ibex_tracer_pkg_INSN_CRC32C_W:
					decode_r1_insn("crc32c.w");
				default:
					decode_mnemonic("INVALID");
			endcase
	end
endmodule
