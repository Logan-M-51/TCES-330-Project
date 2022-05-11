/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module Mux_2_to_1
 *
 * A 2 to 1 mux with a parameter 'm' for the bit width of the inputs and
 * output. Defaults to 16-bit.
 */

module Mux_2_to_1(X, Y, S, M);

    parameter m = 16;

    input [m-1:0] X, Y;
    input S;
    output [m-1:0] M;

    assign M = S ? Y : X;

endmodule

module Mux_2_to_1_tb();

	localparam n = 4;

	logic [3:0] S, X, Y;
	logic [3:0] M;


	Mux_2_to_1 #(.m(n)) DUT( .S(S), .X(X), .Y(Y), .M(M));

    initial begin
        S = 4'b0000; X = 4'b0000; Y = 4'b0001; #100;
        $display(S,,, X,,, Y,,, M);
        S = 4'b0000; X = 4'b0000; Y = 4'b0011; #100;
        $display(S,,, X,,, Y,,, M);
        S = 4'b0000; X = 4'b0001; Y = 4'b0000; #100;
        $display(S,,, X,,, Y,,, M);
        S = 4'b0000; X = 4'b0001; Y = 4'b1110; #100;
        $display(S,,, X,,, Y,,, M);
        S = 4'b0001; X = 4'b0000; Y = 4'b0110; #100;
        $display(S,,, X,,, Y,,, M);
        S = 4'b0001; X = 4'b0000; Y = 4'b1111; #100;
        $display(S,,, X,,, Y,,, M);
        S = 4'b0001; X = 4'b1111; Y = 4'b0111; #100;
        $display(S,,, X,,, Y,,, M);
        S = 4'b0001; X = 4'b1111; Y = 4'b0111; #100;
        $display(S,,, X,,, Y,,, M);
    end

endmodule

