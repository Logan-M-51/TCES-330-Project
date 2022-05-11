# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./Processor.sv"
vlog "./DataPath.sv"
vlog "./DataMemory.v"
vlog "./Mux_2_to_1.sv"
vlog "./Register.sv"
vlog "./ALU.sv"


vlog "./Controller.sv"
vlog "./IR.sv"
vlog "./PC.sv"
vlog "./StateMachine.sv"
vlog "./AlteraROM.v"
vlog "./testProcessor.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -L altera_mf_ver -t 1ps -lib work testProcessor

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do prwave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
