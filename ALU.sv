/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module ALU
 *
 * Performs basic addition, subtraction, and binary operations. Registers
 * a zero_flag set if the output q value is 0.
 */

module ALU (
    input clk,
    input [15:0] a, b,
    input [2:0] sel,
    output logic [15:0] q,
    output logic zero_flag
);

    always_comb
        case (sel)
            0: q = '0;
            1: q = a + b;
            2: q = a - b;
            3: q = a;
            4: q = a ^ b;
            5: q = a | b;
            6: q = a & b;
            7: q = a + 1'b1;
        endcase
        
    always_ff @ (posedge clk)
        zero_flag <= ~|q;

endmodule

module ALU_tb;

    logic [15:0] a, b;
    logic [2:0] sel;
    logic [15:0] q;

    ALU dut (a, b, sel, q);

    initial begin
        for (int i = 0; i < 100; ++i) begin
            { a, b, sel } = $urandom(); #10;
            
            test_alu(a, b, sel, q);
        end
       
        $stop;
    end
   
    function void test_alu(
        input [15:0] a, b,
        input [2:0] sel,
        input [15:0] q
    );
        logic [15:0] r;

        case (sel)
            0: r = 0;
            1: r = 16'(a + b);
            2: r = (a - b);
            3: r = a;
            4: r = (a ^ b);
            5: r = (a | b);
            6: r = (a & b);
            7: r = 16'(a + 1);
        endcase

        if (r != q)
            $error("Function %d, A: %d, B: %d, Q: %d. Expected Result: %d", sel, a, b, q, r);

    endfunction
   
endmodule
