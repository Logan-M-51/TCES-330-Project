vlib work
vlog AlteraROM.v IR.sv PC.sv StateMachine.sv Controller.sv
vsim -voptargs="+acc" -L altera_mf_ver -t 1ps -lib work Controller_tb

do Controller_wave.do

view wave
view structure
view signals

run -all
