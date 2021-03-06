
 
 
 

 



#!/bin/sh

# Clean up the results directory
rm -rf results
mkdir results

#Synthesize the Wrapper Files

echo 'Synthesizing example design with XST';
xst -ifn xst.scr
cp asyncram_w32d1024_exdes.ngc ./results/


# Copy the netlist generated by Coregen
echo 'Copying files from the netlist directory to the results directory'
cp ../../asyncram_w32d1024.ngc results/

#  Copy the constraints files generated by Coregen
echo 'Copying files from constraints directory to results directory'
cp ../example_design/asyncram_w32d1024_exdes.ucf results/

cd results

echo 'Running ngdbuild'
ngdbuild -p xc7k160t-ffg676-2 asyncram_w32d1024_exdes

echo 'Running map'
map asyncram_w32d1024_exdes -o mapped.ncd -pr i

echo 'Running par'
par mapped.ncd routed.ncd

echo 'Running trce'
trce -e 10 routed.ncd mapped.pcf -o routed

echo 'Running design through bitgen'
bitgen -w routed -g UnconstrainedPins:Allow

echo 'Running netgen to create gate level Verilog model'
netgen -ofmt verilog -sim -tm asyncram_w32d1024_exdes -pcf mapped.pcf -w -sdf_anno false routed.ncd routed.v
