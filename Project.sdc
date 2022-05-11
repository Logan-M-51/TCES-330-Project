## Generated SDC file "Project.sdc"

## Copyright (C) 2020  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

## DATE    "Tue May 25 21:09:59 2021"

##
## DEVICE  "EP4CE115F29C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {SysClock} -period 10.000 -waveform { 0.000 5.000 } [get_ports {CLOCK_50}]
create_clock -name {ButtonClock} -period 500.000 -waveform { 0.000 250.000 } [get_keepers {KeyFilter:kf|OUT}]

#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {SysClock}] -rise_to [get_clocks {SysClock}] 1.000
set_clock_uncertainty -rise_from [get_clocks {SysClock}] -fall_to [get_clocks {SysClock}] 1.000
set_clock_uncertainty -fall_from [get_clocks {SysClock}] -rise_to [get_clocks {SysClock}] 1.000
set_clock_uncertainty -fall_from [get_clocks {SysClock}] -fall_to [get_clocks {SysClock}] 1.000
set_clock_uncertainty -rise_from [get_clocks {ButtonClock}] -rise_to [get_clocks {ButtonClock}] 1.000
set_clock_uncertainty -rise_from [get_clocks {ButtonClock}] -fall_to [get_clocks {ButtonClock}] 1.000
set_clock_uncertainty -fall_from [get_clocks {ButtonClock}] -rise_to [get_clocks {ButtonClock}] 1.000
set_clock_uncertainty -fall_from [get_clocks {ButtonClock}] -fall_to [get_clocks {ButtonClock}] 1.000
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] 1.000
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] 1.000
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] 1.000
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] 1.000

derive_clock_uncertainty

#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************
