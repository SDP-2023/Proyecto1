vlog -reportprogress 300 -work work ./tb_shift_register.sv
vlog -reportprogress 300 -work work ./shift_register.sv

vsim work.tb_shift_register

add wave -divider "Testbench:"
add wave -position insertpoint -color yellow -label "CLK" sim:/tb_shift_register/CLK
add wave -position insertpoint -color yellow -label "RSTn" sim:/tb_shift_register/RSTn
add wave -position insertpoint -color yellow -label "ENABLE" sim:/tb_shift_register/ENABLE
add wave -position insertpoint -color yellow -label "SHIFT_IN" sim:/tb_shift_register/SHIFT_IN
add wave -position insertpoint -color yellow -label "SHIFT_OUT" sim:/tb_shift_register/SHIFT_OUT
add wave -position insertpoint -color green -label "OUT_P" sim:/tb_shift_register/OUT_P

add wave -divider "Registro:"
add wave -position insertpoint -color green -label "Memoria" sim:/tb_shift_register/register/mem

run -all
