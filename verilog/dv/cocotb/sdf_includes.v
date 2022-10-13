initial begin
    $sdf_annotate({`MAIN_PATH,"/../../../signoff/caravel/primetime-signoff/sdf/",`CORNER,"/caravel.", `SDF_POSTFIX,".sdf"}, uut,,{`MAIN_PATH,"/sim/",`TAG,"/",`FTESTNAME,"/caravel_sdf.log"},"MINIMUM"); 
end
