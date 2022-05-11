vlib work
vlog ALU.sv
vsim -voptargs="+acc" -t 1ps -lib work ALU_tb

do ALU_wave.do

view wave
view structure
view signals

run -all
