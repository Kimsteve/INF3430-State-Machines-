# Reading C:/questasim64_10.1d/tcl/vsim/pref.tcl 

# //

vsim -voptargs=+acc work.tb_pos_meas(testbench)
# vsim -voptargs=+acc work.tb_pos_meas(testbench) 
# ** Note: (vsim-3812) Design is being optimized...
# 
# ** Note: (vopt-143) Recognized 1 FSM in architecture body "pos_meas(pos_measArchitecture)".
# 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.tb_pos_meas(testbench)#1
# Loading work.motor(motor_beh)#1
# Loading work.pos_meas(pos_measarchitecture)#1
add wave -position insertpoint sim:/tb_pos_meas/uut2/*
run 1ms


