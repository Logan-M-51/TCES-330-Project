/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module PC
 *
 * Increments a counter by adding the signed input 'up' to the current count.
 * A clr signal resets the counter back to 0.
 */

module PC(
    input clk,
    input clr,
    input signed [7:0] up,
    output [6:0] addr
);

    logic [7:0] count;

    always_ff @ (posedge clk)
        count <= clr ? '0 : count + up;
        
    assign addr = count[6:0];

endmodule

module PC_tb;

	logic clk, clr;
    logic signed [7:0] up;
	logic [6:0] addr;

	PC dut (clk, clr, up, addr);

	initial begin
		clk = '0;
		clr = '0;
		up = '0;
	end

	always
		#20 clk = ~clk;

	initial begin
		@ (negedge clk) clr = 1'b1;
		@ (negedge clk) clr = 1'b0;

		@ (negedge clk) assert (addr == '0);

        up = 1;
        @ (negedge clk) assert (addr == 7'd1);
        
        up = 2;
        @ (negedge clk) assert (addr == 7'd3);
        
        up = -2;
        @ (negedge clk) assert (addr == 7'd1);
        
        up = -1;
        @ (negedge clk) assert (addr == 7'd0);

		$stop;
	end

	initial
		$monitor("%0t clr: %b, up: 0x%X, addr: 0x%X", $time, clr, up, addr);

endmodule
