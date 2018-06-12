
 M:/pc/Desktop/LAB3/oppgave3
vsim -voptargs=+acc work.tb_p_ctrl(test)
# vsim -voptargs=+acc work.tb_p_ctrl(test) 
# ** Note: (vsim-3812) Design is being optimized...
# 
# ** Note: (vopt-143) Recognized 1 FSM in architecture body "pos_meas(pos_measArchitecture)".
# 
# ** Note: (vopt-143) Recognized 1 FSM in architecture body "p_ctrl(p_ctrlArch)".

add wave -position insertpoint sim:/tb_p_ctrl/uut3/*
run 1ms
# ** 