/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module Processor
 *
 * Connects the Controller and DataPath modules together.
 */

module Processor(
    input Clk,
    input Reset,
    output [15:0] IR_Out,
    output [6:0] PC_Out,
    output [3:0] State,
    output [3:0] NextState,
    output [15:0] ALU_A,
    output [15:0] ALU_B,
    output [15:0] ALU_Out
);

    logic [7:0] D_addr;
    logic D_w;
    logic RF_s;
    logic [3:0] RF_W_addr;
    logic RF_W_en;
    logic [3:0] RF_Ra_addr;
    logic [3:0] RF_Rb_addr;
    logic [2:0] ALU_s;
    logic zero_flag;

    Controller ctrl (
        .clk(Clk),
        .n_rst(Reset),
        .zero_flag(zero_flag),
        .D_addr(D_addr),
        .D_w(D_w),
        .RF_s(RF_s),
        .RF_W_addr(RF_W_addr),
        .RF_W_en(RF_W_en),
        .RF_Ra_addr(RF_Ra_addr),
        .RF_Rb_addr(RF_Rb_addr),
        .ALU_s(ALU_s),
        .PC_addr(PC_Out),
        .current_state(State),
        .next_state(NextState),
        .IR_data(IR_Out)
    );
    
    DataPath dp (
        .Clock(Clk),
        .n_rst(Reset),
        .D_Addr(D_addr),
        .D_Wr(D_w),
        .RF_s(RF_s),
        .RF_W_Addr(RF_W_addr),
        .RF_W_en(RF_W_en),
        .RF_Ra_Addr(RF_Ra_addr),
        .RF_Rb_Addr(RF_Rb_addr),
        .ALU_s0(ALU_s),
        .ALU_inA(ALU_A),
        .ALU_inB(ALU_B),
        .ALU_out(ALU_Out),
        .zero_flag(zero_flag)
    );

endmodule 
