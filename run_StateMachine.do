vlib work
vlog StateMachine.sv
vsim -voptargs="+acc" -t 1ps -lib work StateMachine_tb

do StateMachine_wave.do

view wave
view structure
view signals

run -all
