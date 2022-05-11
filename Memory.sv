module Memory(clk, reset, Din, wren, ADDM, Dout);

input clk, reset, wren;
input [7:0] ADDM;
input [15:0] Din;
output [15:0] Dout;

logic [7:0] Addr = ADDM;

DataMemory unit(.address(Addr), .clock(clk), .data(Din), .wren(wren), .q(Dout));

always_ff @(posedge clk) begin

	if (reset) begin
		Addr <= 8'd0;
	end	
	else if (Addr != 8'd255) begin
		Addr <= Addr + 1'b1;	
	end
	else begin
		Addr <= 8'd0;
	end
	
end

endmodule


`timescale 1ps/1ps
module Memory_tb();
   
   logic Clk, Reset, wren;
   logic [15:0]Din;	
   logic [15:0]Dout;
   logic [7:0] Addr = 8'b0;
   
   Memory dut(.clk(Clk), .reset(Reset), .Din(Din), .wren(wren), .ADDM(Addr), .Dout(Dout));
	
	always begin
	  Clk =0; #10;
	  Clk =1; #10;
	end
	
	initial  begin
	  Reset = 1'b1; #53; //make Address = 0;
	  Reset = 1'b0;
	  wren = 1'b1;
	  Din = 16'b11111111111111111;
	  for (int k = 0; k< 256; k++) begin
	    @(posedge Clk); 
	    #5 $display(k, $time, Dout); 
	  end
	  $stop;
	end
		
endmodule
