vlib work
vlog IR.sv
vsim -voptargs="+acc" -t 1ps -lib work IR_tb

do IR_wave.do

view wave
view structure
view signals

run -all
