/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module Register
 *
 * Defines 'm' 16-bit registers, where 'm' is a parameter which defaults to
 * 16. A 0 reset signal will clear all registers to 0. Every clock cycle the
 * output for two registers will be updated based on the register addresses
 * given. If the write input is 1 the register at wrAddr will be updated with
 * wrData.
 */

module Register(clk, n_rst, write, wrData, wrAddr, rdAddrA, rdDataA, rdAddrB, rdDataB);

    parameter m = 16;

    input clk, n_rst, write;
    input [3:0] wrAddr, rdAddrA, rdAddrB;
    input [15:0] wrData;
    output logic [15:0] rdDataA, rdDataB;

    logic [15:0] regfile [0:m-1];

    always @ (posedge clk)
        if (!n_rst)
            regfile <= '{ default: '0 };
        else begin
            if (write)
                regfile[wrAddr] <= wrData;

            rdDataA <= regfile[rdAddrA];
            rdDataB <= regfile[rdAddrB];
        end

endmodule

module register_tb();

    logic CLK, WR;
    logic [3:0] WRAddr, RDAddrA, RDAddrB;
    logic [15:0] WRData;
    logic [15:0] RDDataA, RDDataB;

    Register unit(.clk(CLK), .write(WR), .wrData(WRData), .wrAddr(WRAddr), .rdAddrA(RDAddrA), .rdDataA(RDDataA), .rdAddrB(RDAddrB), .rdDataB(RDDataB));

    always begin
     CLK = 0; #10;
     CLK = 1; #10;
    end

    initial begin
         WR = 1; #100;
         RDAddrA = 4'b0001; RDAddrB = 4'b0000; #10;
         WRAddr = 4'b0001; WRData = 16'b0000000000000001; #10;
         $display(RDAddrA,,, RDAddrB,,, RDDataA,,, RDDataB,,, WR);#10;
             WRAddr = 4'b0000; WRData = 16'b0000000000000011; #10;
         $display(RDAddrA,,, RDAddrB,,, RDDataA,,, RDDataB,,, WR);#10;
         WR = 0; #100
         WRAddr = 4'b0001; WRData = 16'b0000000000000111; #10;
         $display(RDAddrA,,, RDAddrB,,, RDDataA,,, RDDataB,,, WR);#10;
             WRAddr = 4'b0000; WRData = 16'b0000000000000111;#10;
         $display(RDAddrA,,, RDAddrB,,, RDDataA,,, RDDataB,,, WR);#10;
         $stop;
    end

endmodule
