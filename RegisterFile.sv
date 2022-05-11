module RegisterFile(
    input clk,
    input [15:0] W_data,
    input [3:0] W_addr,
    input W_en,
    input [3:0] Ra_addr,
    input [3:0] Rb_addr,
    output logic [15:0] Ra_data,
    output logic [15:0] Rb_data
);

    logic [15:0] regfile [16];

    always_ff @ (posedge clk) begin
        if (W_en)
            regfile[W_addr] <= W_data;

        Ra_data <= regfile[Ra_addr];
        Rb_data <= regfile[Rb_addr];
    end

endmodule 