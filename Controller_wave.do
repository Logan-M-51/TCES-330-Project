onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Controller_tb/clk
add wave -noupdate /Controller_tb/n_rst
add wave -noupdate /Controller_tb/D_addr
add wave -noupdate /Controller_tb/D_w
add wave -noupdate /Controller_tb/RF_s
add wave -noupdate /Controller_tb/RF_W_addr
add wave -noupdate /Controller_tb/RF_W_en
add wave -noupdate /Controller_tb/RF_Ra_addr
add wave -noupdate /Controller_tb/RF_Rb_addr
add wave -noupdate /Controller_tb/ALU_s
add wave -noupdate /Controller_tb/PC_addr
add wave -noupdate /Controller_tb/current_state
add wave -noupdate /Controller_tb/next_state
add wave -noupdate /Controller_tb/IR_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
