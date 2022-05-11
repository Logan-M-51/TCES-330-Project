/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module Project
 *
 * Top-level module defining the inputs and outputs for the DE2-115 Board.
 *
 * Connects the ButtonSync, KeyFilter, and Processor modules together.
 *
 * Connects a Mux8to1Nw with signals from the Processor module to display
 * state/debug info on the 7-seg displays.
 */

module Project(
    input CLOCK_50,
    input [2:1] KEY,
    input [17:15] SW,
    output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);

    wire sysclk = CLOCK_50;
    wire n_rst = KEY[1];
    
    logic [6:0] PC_addr;
    logic [3:0] current_state;
    logic [3:0] next_state;
    logic [15:0] ALU_A;
    logic [15:0] ALU_B;
    logic [15:0] ALU_Out;
    logic [15:0] IR_data;
    
    logic [3:0] hex_val [7:0];
    logic [15:0] Mout;
    
    logic BO, keyclk;
    
    ButtonSync bs (
        .CLK(sysclk),
        .BI(~KEY[2]), // KEY are connected via pull-up
        .BO(BO)
    );
    
    KeyFilter kf (
        .CLK(sysclk),
        .IN(BO),
        .OUT(keyclk)
    );
    
    Processor cpu (
        .Clk(keyclk),
        .Reset(n_rst),
        .PC_Out(PC_addr),
        .State(current_state),
        .NextState(next_state),
        .ALU_A(ALU_A),
        .ALU_B(ALU_B),
        .ALU_Out(ALU_Out),
        .IR_Out(IR_data)
    );
    
    Mux8to1Nw #(16) mx (
        .X('{ { 1'b0, PC_addr[6:4], PC_addr[3:0], 4'h0, current_state },
              { ALU_A[15:12], ALU_A[11:8], ALU_A[7:4], ALU_A[3:0] },
              { ALU_B[15:12], ALU_B[11:8], ALU_B[7:4], ALU_B[3:0] },
              { ALU_Out[15:12], ALU_Out[11:8], ALU_Out[7:4], ALU_Out[3:0] },
              { 12'h000, next_state },
              16'd0, 16'd0, 16'd0 }
        ),
        .S(SW[17:15]),
        .Y(Mout)
    );
    
    assign hex_val[7:4] = '{ Mout[15:12], Mout[11:8], Mout[7:4], Mout[3:0] };
    assign hex_val[3:0] = '{ IR_data[15:12], IR_data[11:8], IR_data[7:4], IR_data[3:0] };
    
    Decoder d7 (.Bin(hex_val[7]), .Seg(HEX7));
    Decoder d6 (.Bin(hex_val[6]), .Seg(HEX6));
    Decoder d5 (.Bin(hex_val[5]), .Seg(HEX5));
    Decoder d4 (.Bin(hex_val[4]), .Seg(HEX4));
    Decoder d3 (.Bin(hex_val[3]), .Seg(HEX3));
    Decoder d2 (.Bin(hex_val[2]), .Seg(HEX2));
    Decoder d1 (.Bin(hex_val[1]), .Seg(HEX1));
    Decoder d0 (.Bin(hex_val[0]), .Seg(HEX0));

endmodule 
