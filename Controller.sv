/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module Controller
 *
 * Connects the PC, AlteraROM, IR, and StateMachine modules together to create
 * the control unit portion of the processor.
 */

module Controller(
    input clk,
    input n_rst,
    input zero_flag,
	output [7:0] D_addr,
    output D_w,
	output RF_s,
	output [3:0] RF_W_addr,
	output RF_W_en,
	output [3:0] RF_Ra_addr,
	output [3:0] RF_Rb_addr,
	output [2:0] ALU_s,
    output [6:0] PC_addr,
    output [3:0] current_state,
    output [3:0] next_state,
    output [15:0] IR_data
);

	logic PC_clr;
	logic [7:0] PC_up;
	logic IR_ld ;
    logic [15:0] ROM_data;
    
    PC pc (
        .clk(clk),
        .clr(PC_clr),
        .up(PC_up),
        .addr(PC_addr)
    );
    
    AlteraROM rom (
        .address(PC_addr),
        .clock(clk),
        .q(ROM_data));
    
    IR ir (
        .clk(clk),
        .ld(IR_ld),
        .data_in(ROM_data),
        .data_out(IR_data)
    );

	StateMachine sm (
		.clk(clk),
		.n_rst(n_rst),
		.IR(IR_data),
        .zero_flag(zero_flag),
		.D_addr(D_addr),
		.PC_clr(PC_clr),
		.PC_up(PC_up),
		.IR_ld(IR_ld), 
		.D_wr(D_w),
		.RF_s(RF_s),
		.RF_W_addr(RF_W_addr),
		.RF_W_en(RF_W_en),
		.RF_Ra_addr(RF_Ra_addr),
		.RF_Rb_addr(RF_Rb_addr),
		.ALU_s(ALU_s),
        .State(current_state),
        .NextState(next_state)
	);
    
endmodule

`timescale 1 ps / 1 ps
module Controller_tb;

    logic clk;
    logic n_rst;
    logic zero_flag;
	logic [7:0] D_addr;
    logic D_w;
	logic RF_s;
	logic [3:0] RF_W_addr;
	logic RF_W_en;
	logic [3:0] RF_Ra_addr;
	logic [3:0] RF_Rb_addr;
	logic [2:0] ALU_s;
    logic [6:0] PC_addr;
    logic [3:0] current_state;
    logic [3:0] next_state;
    logic [15:0] IR_data;

	wire [3:0] opcode = IR_data[15:12];

	logic [6:0] old_PC_addr;

	Controller dut (clk, n_rst, zero_flag, D_addr, D_w, RF_s, RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, ALU_s, PC_addr, current_state, next_state, IR_data);

	initial begin
		clk = '0;
		n_rst = '1;
		old_PC_addr = '0;
        zero_flag = '0;
	end

	always
		#20 clk = ~clk;

	initial begin
		@ (negedge clk) n_rst = '0;
		@ (negedge clk) n_rst = '1;
        assert (current_state == 4'h0); // INIT
        
        @ (negedge clk) assert (current_state == 4'h3); // NOOP
        @ (negedge clk)
        
		forever begin
			@ (negedge clk) assert (PC_addr == old_PC_addr + 1'b1) else
				$error("PC: 0x%X, old_PC: 0x%X", PC_addr, old_PC_addr);

			assert (current_state == 4'h2) else
				$error("current_state: %d", current_state);

			@ (negedge clk) case (opcode)
				4'h1: begin
					assert (D_w == 1'b1);
					assert (current_state == 4'h6);
					assert (next_state == 4'h1);
				end
				4'h2: begin
					assert (RF_s == 1'b1);
					assert (current_state == 4'h4);
					assert (next_state == 4'h5);
					@ (negedge clk) assert (RF_W_en == 1'b1);
					assert (current_state == 4'h5);
					assert (next_state == 4'h1);
				end
				4'h3: begin
					assert (ALU_s == 3'h1);
					assert (RF_W_en == 1'b1);
					assert (current_state == 4'h7);
					assert (next_state == 4'h1);
				end
				4'h4: begin
					assert (ALU_s == 3'h2);
					assert (RF_W_en == 1'b1);
					assert (current_state == 4'h8);
					assert (next_state == 4'h1);
				end
				4'h5: $stop;
				default: ;
			endcase

			if (opcode != 4'hx && opcode != 4'h5) begin
				assert (RF_Ra_addr == IR_data[11:8]);
				assert (RF_Rb_addr == IR_data[7:4]);
				assert (RF_W_addr == IR_data[3:0]);
			end
			
			@ (negedge clk) old_PC_addr = PC_addr;
		end
	end

	initial
		$monitor("%0t IR_data: 0x%X, current_state: %d, next_state: %d, RF_Ra_addr: 0x%X, RF_Rb_addr: 0x%X, RF_W_addr: 0x%X, RF_s: %b, RF_W_en: %b, ALU_s: %d", $time, IR_data, current_state, next_state, RF_Ra_addr, RF_Rb_addr, RF_W_addr, RF_s, RF_W_en, ALU_s);

endmodule
