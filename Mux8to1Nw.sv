/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module Mux8to1Nw
 *
 * A 8 to 1 mux with a parameter 'WIDTH' for the bit width.
 */

module Mux8to1Nw
#(
    parameter WIDTH
) (
    input [WIDTH-1:0] X [8],
    input [2:0] S,
    output [WIDTH-1:0] Y
);

    assign Y = X[S];
    
endmodule

module Mux8to1Nw_tb;

    logic [2:0] X [8] = '{ 3'h0, 3'h1, 3'h2, 3'h3, 3'h4, 3'h5, 3'h6, 3'h7 };
    logic [2:0] S;
    logic [2:0] Y;
    
    Mux8to1Nw #(3) dut (X, S, Y);
    
    initial begin
        for (int i = 0; i < 8; ++i) begin
            S = i; #10;
            assert (Y == i) else $display("Failed to get corret output: %d", i);
        end
        
        $stop;
    end
    
    initial
        $monitor("S: %X, Y: %X", S, Y);
        
endmodule
