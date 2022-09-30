# How to run test: 

Navigate to the cocotb directory and run the following command
## To run test :
  >python3 run.py  -t <test/s> -sim <type of simulation/s RTL GL or GL_SDF> -tag <run tag optional>
  
  Or
  
  >python3 run.py --test <test/s> -sim <type of simulation/s RTL GL or GL_SDF>  -tag <run tag optional>

## To run regression 
  >python3 run.py  -r <regression> -tag <run tag optional>

  Or 

  >python3 run.py  --regression <regression> -tag <run tag optional>

## Notes
>  Tests and regressions can be used in the same command 
  
>  Tests and regressions  can be found under cocotb/tests.json
