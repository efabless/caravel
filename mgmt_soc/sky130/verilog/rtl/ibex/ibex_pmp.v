module ibex_pmp (
	clk_i,
	rst_ni,
	csr_pmp_cfg_i,
	csr_pmp_addr_i,
	csr_pmp_mseccfg_i,
	priv_mode_i,
	pmp_req_addr_i,
	pmp_req_type_i,
	pmp_req_err_o
);
	parameter [31:0] PMPGranularity = 0;
	parameter [31:0] PMPNumChan = 2;
	parameter [31:0] PMPNumRegions = 4;
	input wire clk_i;
	input wire rst_ni;
	input wire [(PMPNumRegions * 6) - 1:0] csr_pmp_cfg_i;
	input wire [(PMPNumRegions * 34) - 1:0] csr_pmp_addr_i;
	input wire [2:0] csr_pmp_mseccfg_i;
	input wire [(PMPNumChan * 2) - 1:0] priv_mode_i;
	input wire [(PMPNumChan * 34) - 1:0] pmp_req_addr_i;
	input wire [(PMPNumChan * 2) - 1:0] pmp_req_type_i;
	output wire [0:PMPNumChan - 1] pmp_req_err_o;
	wire [33:0] region_start_addr [0:PMPNumRegions - 1];
	wire [33:PMPGranularity + 2] region_addr_mask [0:PMPNumRegions - 1];
	wire [(PMPNumChan * PMPNumRegions) - 1:0] region_match_gt;
	wire [(PMPNumChan * PMPNumRegions) - 1:0] region_match_lt;
	wire [(PMPNumChan * PMPNumRegions) - 1:0] region_match_eq;
	reg [(PMPNumChan * PMPNumRegions) - 1:0] region_match_all;
	wire [(PMPNumChan * PMPNumRegions) - 1:0] region_basic_perm_check;
	reg [(PMPNumChan * PMPNumRegions) - 1:0] region_mml_perm_check;
	reg [PMPNumChan - 1:0] access_fault;
	genvar r;
	generate
		for (r = 0; r < PMPNumRegions; r = r + 1) begin : g_addr_exp
			if (r == 0) begin : g_entry0
				assign region_start_addr[r] = (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] == 2'b01 ? 34'h000000000 : csr_pmp_addr_i[((PMPNumRegions - 1) - r) * 34+:34]);
			end
			else begin : g_oth
				assign region_start_addr[r] = (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] == 2'b01 ? csr_pmp_addr_i[((PMPNumRegions - 1) - (r - 1)) * 34+:34] : csr_pmp_addr_i[((PMPNumRegions - 1) - r) * 34+:34]);
			end
			genvar b;
			for (b = PMPGranularity + 2; b < 34; b = b + 1) begin : g_bitmask
				if (b == 2) begin : g_bit0
					assign region_addr_mask[r][b] = csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] != 2'b11;
				end
				else begin : g_others
					if (PMPGranularity == 0) begin : g_region_addr_mask_zero_granularity
						assign region_addr_mask[r][b] = (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] != 2'b11) | ~&csr_pmp_addr_i[(((PMPNumRegions - 1) - r) * 34) + ((b - 1) >= 2 ? b - 1 : ((b - 1) + ((b - 1) >= 2 ? b - 2 : 4 - b)) - 1)-:((b - 1) >= 2 ? b - 2 : 4 - b)];
					end
					else begin : g_region_addr_mask_other_granularity
						assign region_addr_mask[r][b] = (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2] != 2'b11) | ~&csr_pmp_addr_i[(((PMPNumRegions - 1) - r) * 34) + ((b - 1) >= (PMPGranularity + 1) ? b - 1 : ((b - 1) + ((b - 1) >= (PMPGranularity + 1) ? ((b - 1) - (PMPGranularity + 1)) + 1 : ((PMPGranularity + 1) - (b - 1)) + 1)) - 1)-:((b - 1) >= (PMPGranularity + 1) ? ((b - 1) - (PMPGranularity + 1)) + 1 : ((PMPGranularity + 1) - (b - 1)) + 1)];
					end
				end
			end
		end
	endgenerate
	genvar c;
	generate
		for (c = 0; c < PMPNumChan; c = c + 1) begin : g_access_check
			genvar r;
			for (r = 0; r < PMPNumRegions; r = r + 1) begin : g_regions
				assign region_match_eq[(c * PMPNumRegions) + r] = (pmp_req_addr_i[(((PMPNumChan - 1) - c) * 34) + (33 >= (PMPGranularity + 2) ? 33 : (33 + (33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)) - 1)-:(33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)] & region_addr_mask[r]) == (region_start_addr[r][33:PMPGranularity + 2] & region_addr_mask[r]);
				assign region_match_gt[(c * PMPNumRegions) + r] = pmp_req_addr_i[(((PMPNumChan - 1) - c) * 34) + (33 >= (PMPGranularity + 2) ? 33 : (33 + (33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)) - 1)-:(33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)] > region_start_addr[r][33:PMPGranularity + 2];
				assign region_match_lt[(c * PMPNumRegions) + r] = pmp_req_addr_i[(((PMPNumChan - 1) - c) * 34) + (33 >= (PMPGranularity + 2) ? 33 : (33 + (33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)) - 1)-:(33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)] < csr_pmp_addr_i[(((PMPNumRegions - 1) - r) * 34) + (33 >= (PMPGranularity + 2) ? 33 : (33 + (33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)) - 1)-:(33 >= (PMPGranularity + 2) ? 34 - (PMPGranularity + 2) : PMPGranularity - 30)];
				always @(*) begin
					region_match_all[(c * PMPNumRegions) + r] = 1'b0;
					case (csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 4-:2])
						2'b00: region_match_all[(c * PMPNumRegions) + r] = 1'b0;
						2'b10: region_match_all[(c * PMPNumRegions) + r] = region_match_eq[(c * PMPNumRegions) + r];
						2'b11: region_match_all[(c * PMPNumRegions) + r] = region_match_eq[(c * PMPNumRegions) + r];
						2'b01: region_match_all[(c * PMPNumRegions) + r] = (region_match_eq[(c * PMPNumRegions) + r] | region_match_gt[(c * PMPNumRegions) + r]) & region_match_lt[(c * PMPNumRegions) + r];
						default: region_match_all[(c * PMPNumRegions) + r] = 1'b0;
					endcase
				end
				assign region_basic_perm_check[(c * PMPNumRegions) + r] = (((pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b00) & csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 2]) | ((pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b01) & csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 1])) | ((pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b10) & csr_pmp_cfg_i[((PMPNumRegions - 1) - r) * 6]);
				always @(*) begin
					region_mml_perm_check[(c * PMPNumRegions) + r] = 1'b0;
					if (!csr_pmp_cfg_i[((PMPNumRegions - 1) - r) * 6] && csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 1])
						case ({csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 5], csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 2]})
							2'b00: region_mml_perm_check[(c * PMPNumRegions) + r] = (pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b10) | ((pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b01) & (priv_mode_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b11));
							2'b01: region_mml_perm_check[(c * PMPNumRegions) + r] = (pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b10) | (pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b01);
							2'b10: region_mml_perm_check[(c * PMPNumRegions) + r] = pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b00;
							2'b11: region_mml_perm_check[(c * PMPNumRegions) + r] = (pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b00) | ((pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b10) & (priv_mode_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b11));
							default:
								;
						endcase
					else if (((csr_pmp_cfg_i[((PMPNumRegions - 1) - r) * 6] & csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 1]) & csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 2]) & csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 5])
						region_mml_perm_check[(c * PMPNumRegions) + r] = pmp_req_type_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b10;
					else
						region_mml_perm_check[(c * PMPNumRegions) + r] = (priv_mode_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b11 ? csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 5] & region_basic_perm_check[(c * PMPNumRegions) + r] : ~csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 5] & region_basic_perm_check[(c * PMPNumRegions) + r]);
				end
			end
			always @(*) begin
				access_fault[c] = csr_pmp_mseccfg_i[1] | (priv_mode_i[((PMPNumChan - 1) - c) * 2+:2] != 2'b11);
				begin : sv2v_autoblock_1
					reg signed [31:0] r;
					for (r = PMPNumRegions - 1; r >= 0; r = r - 1)
						if (region_match_all[(c * PMPNumRegions) + r])
							if (csr_pmp_mseccfg_i[0])
								access_fault[c] = ~region_mml_perm_check[(c * PMPNumRegions) + r];
							else
								access_fault[c] = (priv_mode_i[((PMPNumChan - 1) - c) * 2+:2] == 2'b11 ? csr_pmp_cfg_i[(((PMPNumRegions - 1) - r) * 6) + 5] & ~region_basic_perm_check[(c * PMPNumRegions) + r] : ~region_basic_perm_check[(c * PMPNumRegions) + r]);
				end
			end
			assign pmp_req_err_o[c] = access_fault[c];
		end
	endgenerate
	wire unused_csr_pmp_mseccfg_rlb;
	assign unused_csr_pmp_mseccfg_rlb = csr_pmp_mseccfg_i[2];
endmodule
