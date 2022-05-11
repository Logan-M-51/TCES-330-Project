/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module KeyFilter
 *
 * Ensures only one ButtonClock cycle per button press, and checks 10 times
 * a second if there has been a change in the button state from the ButtonSync
 * module.
 */

module KeyFilter(CLK, IN, OUT);
	input CLK, IN;
	output logic OUT;
	
	parameter DUR = 23'd4999999;
	logic [22:0] Countdown;
	
	always_ff @(posedge CLK) begin
		OUT <= 0;	
		if (Countdown != '0) begin
				Countdown <= Countdown - 1'b1;		
		end
		else begin
			if (IN == 1) begin
				OUT <= 1;
				Countdown <= DUR;
			end

		end	
	end

endmodule



module KeyFilter_tb();
	logic clk, in;
	wire out;
	wire [32:0] CN;
	KeyFilter #(.DUR(50)) DUT(.CLK(clk), .IN(in), .OUT(out));
	
	
	always begin
		clk <= 0; #10;
		clk <= 1; #10;
	end
	
	initial begin
		in = 0;
		in = 1; #100;
		$display(out);
		in = 0; #100;
		in = 1; #100;
		$display(out);
		in = 0; #100;
		in = 1; #100;
		$display(out);
		in = 0; #100;
		in = 1; #100;
		$display(out);
		in = 0; #100;
		in = 1; #100;
		$display(out);
		in = 0; #100;
		in = 1; #100;
		$display(out);	
		$stop;
	end

endmodule
