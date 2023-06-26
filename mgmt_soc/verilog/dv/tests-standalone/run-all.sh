#!/bin/sh

#x=`basename $(pwd)` ; SIM=RTL	   make  2>&1 | tee -a verify-rtl.log     ; grep Monitor verify-rtl.log	 
#x=`basename $(pwd)` ; SIM=GL	   make  2>&1 | tee -a verify-gl.log      ; grep Monitor verify-gl.log    
#x=`basename $(pwd)` ; SIM=GL_SDF  make  2>&1 | tee -a verify-gl-sdf.log  ; grep Monitor verify-gl-sdf.log


for x in `ls -d */` ; do cd $x ; SIM=$1     make               > $1-verify.log      ; grep Monitor $1-verify.log     ; cd ..   ; done

#for x in `ls -d */` ; do cd $x ; SIM=$1     make  2>&1 | tee -a $1-verify.log      ; grep Monitor $1-verify.log     ; cd ..   ; done

#for x in `ls -d */` ; do cd $x ; SIM=RTL     make  2>&1 | tee -a $1-verify-rtl.lo      ; grep Monitor verify-rtl.log     ; cd ..   ; done
#for x in `ls -d */` ; do cd $x ; SIM=GL      make  2>&1 | tee -a verify-gl.log	     ; grep Monitor verify-gl.log      ; cd ..   ; done
#for x in `ls -d */` ; do cd $x ; SIM=GL_SDF  make  2>&1 | tee -a verify-gl-sdf.log  ; grep Monitor verify-gl-sdf.log  ; cd ..   ; done

#cd $2
#SIM=$1 make  2>&1 | tee -a  $1-verify.log  ; grep Monitor $1-verify.log 
#cd ..


