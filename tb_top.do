vlog -reportprogress 300 -work work ./tb_top.sv

vsim work.tb_top

add wave -divider "Testbench:"
add wave -position insertpoint -color yellow -label "CLK" sim:/tb_top/CLK
add wave -position insertpoint -color yellow -label "RSTn" sim:/tb_top/RSTn
add wave -position insertpoint -color yellow -label "ENABLE" sim:/tb_top/ENABLE
add wave -position insertpoint -color green -label "OUTPUT" sim:/tb_top/OUTPUT
add wave -position insertpoint -color green -label "LEDS" sim:/tb_top/LEDS

run -all
