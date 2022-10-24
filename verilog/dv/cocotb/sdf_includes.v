initial begin
    `ifndef CARAVAN
    $sdf_annotate({`MAIN_PATH,"/../../../signoff/caravel/primetime-signoff/sdf/",`CORNER,"/caravel.", `SDF_POSTFIX,".sdf"}, uut,,{`MAIN_PATH,"/sim/",`TAG,"/",`FTESTNAME,"/caravel_sdf.log"},"MINIMUM"); 
    `else
    $sdf_annotate({`MAIN_PATH,"/../../../signoff/caravan/primetime-signoff/sdf/",`CORNER,"/caravan.", `SDF_POSTFIX,".sdf"}, uut,,{`MAIN_PATH,"/sim/",`TAG,"/",`FTESTNAME,"/caravan_sdf.log"},"MINIMUM"); 
    `endif
end
