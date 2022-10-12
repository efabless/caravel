initial begin
    // $sdf_annotate({`MAIN_PATH,"sdf_pt//RAM256", `SDF_POSTFIX, ".sdf"}, uut.soc.RAM256,,"annotation_logs/DFFRAM.log","MINIMUM");
    // $sdf_annotate({`MAIN_PATH,"sdf_pt//RAM128", `SDF_POSTFIX, ".sdf"}, uut.soc.RAM128,,"annotation_logs/DFFRAM.log","MINIMUM");
    // $sdf_annotate({`MAIN_PATH,"sdf_pt//mgmt_core_wrapper", `SDF_POSTFIX, ".sdf"}, uut.soc,,"annotation_logs/mgmt_core_wrapper.log","MINIMUM");
    $sdf_annotate({"sdf_pt/caravel", `SDF_POSTFIX,".sdf"}, uut,,{`MAIN_PATH,"/sim/",`TAG,"/",`FTESTNAME,"/",`TESTNAME ,"annotation_logs/caravel.log"},"MINIMUM"); 
end
