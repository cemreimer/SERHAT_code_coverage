quietly set ACTELLIBNAME IGLOO2
quietly set PROJECT_DIR "C:/Users/c001/Desktop/Cemre_imer/serhat_git/SERHAT_code_coverage/HI6110"

if {[file exists postsynth/_info]} {
   echo "INFO: Simulation library postsynth already exists"
} else {
   file delete -force postsynth 
   vlib postsynth
}
vmap postsynth postsynth
vmap IGLOO2 "C:/Microsemi/Libero_SoC_v11.7///Designer//lib//modelsim//precompiled/vhdl/smartfusion2"

vcom -2008 -explicit  -work postsynth "${PROJECT_DIR}/hdl/parameters.vhd"
vcom -2008 -explicit  -work postsynth "${PROJECT_DIR}/hdl/types.vhd"
vcom -2008 -explicit  -work postsynth "${PROJECT_DIR}/synthesis/TopModule.vhd"
vcom -2008 -explicit  -work postsynth "${PROJECT_DIR}/stimulus/1553_coverage_tb.vhd"

vsim -L IGLOO2 -L postsynth  -t 1fs postsynth.coverage_1553_tb
add wave /coverage_1553_tb/*
run 1000ns
