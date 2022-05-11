vlib work
vlog ButtonSync.sv
vsim -voptargs="+acc" -t 1ps -lib work ButtonSync_tb

do buttonwave.do

view wave
view structure
view signals

run -all
