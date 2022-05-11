/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module ButtonSync
 *
 * Ensures the button is pressed for three clock cycles @ 50 MHz to avoid
 * a false positive from metastability issues.
 */

module ButtonSync(BI, CLK, BO);
	input BI, CLK;
	output logic BO;

	logic BI_, BI__;
	
	logic [1:0] State, Next;
	
	localparam S_A = 2'h0,
				  S_B = 2'h1,
				  S_C = 2'h2;
	
	always_comb begin;
		BO = 0;
        Next = State;
		case (State)
			S_A: begin
				if (BI__) begin
					Next = S_B;
				end
			end
			
			S_B: begin
				BO = 1;
				if (BI__) begin
					Next = S_C;
				end
				else begin
					Next = S_A;
				end
			end
			
			S_C: begin
				if (~BI__) begin
					Next = S_A;
				end	
			end
			
			default: begin
				Next = S_A;
			end
			
		endcase
	end


	always_ff @(posedge CLK) begin
		BI_ <= BI;
		BI__ <= BI_;
		State <= Next;
	end
	
endmodule



module ButtonSync_tb();
 logic clk, bi, bo;
 
 ButtonSync DUT(bi, clk, bo);
 
 always begin
	clk <= 0; #10;
	clk <= 1; #10;
 end

 
 initial begin
	bi = 0;
	#100 bi = 1;
	$display(bi,,, bo);
	#110 bi = 0;
	$display(bi,,, bo);
	#100 $stop;
	end
	  
endmodule
