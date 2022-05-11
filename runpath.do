# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DataPath.sv"
vlog "./ALU.sv"
vlog "./Mux_2_to_1.sv"
vlog "./DataMemory.v"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -L altera_mf_ver -t 1ps -lib work DataPath_tb

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do pathwave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
