/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module Decoder
 *
 * Decodes a 4-bit binay value in its 7-segment display as hexidecimal.
 */

module Decoder(
	input [3:0] Bin,
	output logic [6:0] Seg
);

	always @ (Bin)
		case (Bin)
			4'h0: Seg = 7'b1000000;
			4'h1: Seg = 7'b1111001;
			4'h2: Seg = 7'b0100100;
			4'h3: Seg = 7'b0110000;
			4'h4: Seg = 7'b0011001;
			4'h5: Seg = 7'b0010010;
			4'h6: Seg = 7'b0000010;
			4'h7: Seg = 7'b1111000;
			4'h8: Seg = '0;
			4'h9: Seg = 7'b0010000;
			4'ha: Seg = 7'b0001000;
			4'hb: Seg = 7'b0000011;
			4'hc: Seg = 7'b1000110;
			4'hd: Seg = 7'b0100001;
			4'he: Seg = 7'b0000110;
			4'hf: Seg = 7'b0001110;
		endcase

endmodule
