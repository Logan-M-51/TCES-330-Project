vlib work
vlog PC.sv
vsim -voptargs="+acc" -t 1ps -lib work PC_tb

do PC_wave.do

view wave
view structure
view signals

run -all
