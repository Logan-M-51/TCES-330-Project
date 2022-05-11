/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module DataPath
 *
 * Connects the DataMemory, Mux_2_to_1, Register, and ALU modules together to
 * create the DataPath portion of the processor.
 */

module DataPath(
    Clock, n_rst,
    D_Addr, D_Wr,
    RF_s, RF_W_Addr, RF_W_en,
	RF_Ra_Addr, RF_Rb_Addr,
	ALU_s0, ALU_inA, ALU_inB, ALU_out,
    zero_flag
);

    input Clock, n_rst, D_Wr, RF_W_en, RF_s;
    input [2:0] ALU_s0;
    input [7:0] D_Addr;
    input [3:0] RF_W_Addr, RF_Rb_Addr, RF_Ra_Addr;
    output [15:0] ALU_inA, ALU_inB, ALU_out;
    output zero_flag;

    logic [15:0] Mux_out, Dout;

    //address,clock,data,wren,q
    DataMemory unit0(D_Addr, Clock, ALU_inA, D_Wr, Dout);

    //X, Y, S, M
    Mux_2_to_1 unit1(ALU_out, Dout, RF_s, Mux_out);

                   //clk, n_rst, write, wrData, wrAddr, rdAddrA, rdDataA, rdAddrB, rdDataB
    Register unit2(Clock, n_rst, RF_W_en, Mux_out, RF_W_Addr, RF_Ra_Addr, ALU_inA, RF_Rb_Addr, ALU_inB);

    //clk,a,b,sel,q,zero_flag
    ALU unit3(Clock, ALU_inA, ALU_inB, ALU_s0, ALU_out, zero_flag);

endmodule


//Clock, D_Addr, D_Wr, RF_s, RF_W_Addr, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, ALU_s0, ALU_inA, ALU_inB, ALU_out);
`timescale 1ps/1ps
module DataPath_tb();

    logic CLK, DWR, WEN, RFS;
    logic [2:0] ALUS;
    logic [7:0] DADDR;
    logic [3:0] RFWADDR, RFRBADDR, RFRAADDR;
    logic [15:0] ALUIA, ALUIB, ALUO;

    DataPath DUT(.Clock(CLK), .D_Addr(DADDR), .D_Wr(DWR), .RF_s(RFS), .RF_W_Addr(RFWADDR), .RF_W_en(WEN), .RF_Ra_Addr(RFRAADDR),
                 .RF_Rb_Addr(RFRBADDR), .ALU_s0(ALUS), .ALU_inA(ALUIA), .ALU_inB(ALUIB), .ALU_out(ALUO));
     
    always begin
        CLK = 0; #10;
        CLK = 1; #10;
    end

    initial begin
        DADDR = 8'b00000000;  DWR = 0; 
        RFS = 1;
        WEN = 1; RFWADDR = 4'b0010; RFRAADDR = 4'b0010; RFRBADDR = 4'b0000; 
        ALUS = 3'b111;
        @(posedge CLK) #1;
        @(posedge CLK) #1;
        $display(DWR,,, RFS,,, ALUS,,,, DADDR,,, RFWADDR,,, RFRAADDR,,, RFRBADDR,,, ALUIA,,, ALUIB,,, ALUO,,,);


        DADDR = 8'b00000001;  DWR = 1; 
        RFS = 0;
        WEN = 1; RFWADDR = 4'b0001; RFRAADDR = 4'b0010; RFRBADDR = 4'b0011; 
        //ALUS = 3'b110;
        //$display(DWR,,, RFS,,, ALUS,,,, DADDR,,, RFWADDR,,, RFRAADDR,,, RFRBADDR,,, ALUIA,,, ALUIB,,, ALUO,,,);
        @(posedge CLK) #1;


        DADDR = 8'b00000010; DWR = 0;
        RFS = 1;
        WEN = 1; RFWADDR = 4'b0100; RFRBADDR = 4'b0010; RFRAADDR = 4'b0001;
        ALUS = 3'b001;
        @(posedge CLK) #1;
        @(posedge CLK) #1;
        $display(DWR,,, RFS,,, ALUS,,,, DADDR,,, RFWADDR,,, RFRAADDR,,, RFRBADDR,,, ALUIA,,, ALUIB,,, ALUO,,,);
        $stop;
        
    end


endmodule
