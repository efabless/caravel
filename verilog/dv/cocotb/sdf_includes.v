initial begin
    `ifndef CARAVAN
    $sdf_annotate({`MAIN_PATH,"/../../../signoff/caravel/primetime-signoff/sdf/",`CORNER,"/caravel.", `SDF_POSTFIX,".sdf"}, uut,,{`MAIN_PATH,"/sim/",`TAG,"/",`FTESTNAME,"/caravel_sdf.log"},`ifdef MAX_SDF "MAXIMUM" `else "MINIMUM" `endif ); 
    `else
    $sdf_annotate({`MAIN_PATH,"/../../../signoff/caravan/primetime-signoff/sdf/",`CORNER,"/caravan.", `SDF_POSTFIX,".sdf"}, uut,,{`MAIN_PATH,"/sim/",`TAG,"/",`FTESTNAME,"/caravan_sdf.log"},`ifdef MAX_SDF "MAXIMUM" `else "MINIMUM" `endif ); 
    `endif
end
