/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module IR
 *
 * Holds the last instruction recieved from the instruction memory (ROM).
 * Updates its value when the ld (load) input is 1.
 */

module IR(
    input clk,
    input ld,
    input [15:0] data_in,
    output logic [15:0] data_out
);

    always @ (posedge clk)
        if (ld)
            data_out <= data_in;

endmodule

module IR_tb;

    logic clk, ld;
    logic [15:0] data_in, data_out, old_data;
    
    IR dut (clk, ld, data_in, data_out);
    
    initial begin
        clk = '0;
        old_data = '0;
        data_in = '0;
        ld = '1;
    end
    
    always begin
        clk = ~clk; #20;
    end
    
    initial begin
        for (int i = 0; i < 20; ++i) begin
            @ (negedge clk) { ld, data_in } = $urandom();
            
            @ (negedge clk)
            if (ld)
                assert (data_out == data_in);
            else
                assert (data_out == old_data);
                
            old_data = data_out;
        end
        
        $stop;
   end
   
   initial
       $monitor("%0t ld: %b, data_in: %X, data_out: %X", $time, ld, data_in, data_out);
 
endmodule 
