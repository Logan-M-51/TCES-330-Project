/*
 * Zachary Pratt, Logan Miller
 * TCES 330 Final Project
 *
 * Module StateMachine
 *
 * Handles instructions from the IR module and updates the state of the
 * processor accordingly, along with update signals for each state.
 * Includes states for fetching, decoding, and all programable instructions.
 */

module StateMachine(
    input clk,
    input n_rst,
    input [15:0] IR,
    input zero_flag,
    output [7:0] D_addr,
    output logic PC_clr,
    output logic [7:0] PC_up,
    output logic IR_ld,
    output logic D_wr,
    output logic RF_s,
    output [3:0] RF_W_addr,
    output logic RF_W_en,
    output [3:0] RF_Ra_addr,
    output [3:0] RF_Rb_addr,
    output logic [2:0] ALU_s,
    output [3:0] State,
    output [3:0] NextState
);

    typedef enum logic [3:0] { INIT, FETCH, DECODE, NOOP, LOADA, LOADB, STORE, ADD, SUB, JMP, JNZA, JNZB, HALT } state_t;

    state_t current_state;
    state_t next_state;

    assign State = current_state;
    assign NextState = next_state;

    assign RF_Ra_addr = IR[11:8] ;
    assign RF_Rb_addr = IR[7:4];
    assign RF_W_addr = IR[3:0];
    assign D_addr = current_state == STORE ? IR[7:0] : IR[11:4];

    always_comb begin
        PC_clr = '0;
        PC_up = '0;
        IR_ld = '0;
        D_wr = '0;
        RF_s = '0;
        RF_W_en = '0;
        ALU_s = '0;
        case (current_state)
            INIT: begin
                next_state = NOOP;
                PC_clr = 1'b1;
            end
            
            FETCH: begin
                next_state = DECODE;
                PC_up = 8'd1;
                IR_ld = 1'b1;
            end
            
            DECODE: begin
                case (IR[15:12])
                    4'h0: next_state = NOOP;
                    4'h1: next_state = STORE;
                    4'h2: next_state = LOADA;
                    4'h3: next_state = ADD;
                    4'h4: next_state = SUB;
                    4'h5: next_state = HALT;
                    4'h6: next_state = JMP;
                    4'h7: next_state = JNZA;
                    default: next_state = NOOP;
                endcase
            end
            
            NOOP: next_state = FETCH;
            
            LOADA: begin
                next_state = LOADB;
                RF_s = 1'b1;
            end
            
            LOADB: begin
                next_state = FETCH;
                RF_s = 1'b1;
                RF_W_en = 1'b1;
            end
            
            STORE: begin
                next_state = FETCH;
                D_wr = 1;
            end
            
            ADD: begin
                next_state = FETCH;
                RF_W_en = 1'b1;
                ALU_s = 3'h1;
            end
            
            SUB: begin
                next_state = FETCH;
                RF_W_en = 1'b1;
                ALU_s = 3'h2;
            end
            
            JMP: begin
                next_state = NOOP;
                PC_up = IR[7:0];
            end
            
            JNZA: begin
                next_state = JNZB;
                ALU_s = 3'h3;
            end
            
            JNZB: begin
                if (!zero_flag) begin
                    next_state = NOOP;
                    PC_up = IR[7:0];
                end else
                    next_state = FETCH;
            end
            
            HALT: next_state = HALT;
        endcase
    end

    always_ff @ (posedge clk)
        current_state <= (!n_rst) ? INIT : next_state;

endmodule

module StateMachine_tb;

    logic clk;
    logic n_rst;
    logic [15:0] IR;
    logic zero_flag;
    logic [7:0] D_addr;
    logic PC_clr;
    logic [7:0] PC_up;
    logic IR_ld;
    logic D_wr;
    logic RF_s;
    logic [3:0] RF_W_addr;
    logic RF_W_en;
    logic [3:0] RF_Ra_addr;
    logic [3:0] RF_Rb_addr;
    logic [2:0] ALU_s;
    logic [3:0] State;
    logic [3:0] NextState;

	StateMachine dut (clk, n_rst, IR, zero_flag, D_addr, PC_clr, PC_up, IR_ld, D_wr, RF_s, RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, ALU_s, State, NextState);

	initial begin
		clk = 1'b0;
		n_rst = 1'b1;
		IR = '0;
		zero_flag = 1'b0;
	end

	always
		#10 clk = ~clk;

	initial begin
		@ (negedge clk) n_rst = 1'b0;
		@ (negedge clk) n_rst = 1'b1;

		assert (State == 4'h0);
		@ (negedge clk) assert (State == 4'h3);

		IR = 16'h1000;
		IR[11:0] = $urandom();
		@ (negedge clk) assert (State == 4'h1);
		@ (negedge clk) assert (State == 4'h2);
		@ (negedge clk) assert (State == 4'h6);

		IR = 16'h2000;
		IR[11:0] = $urandom();
		@ (negedge clk) assert (State == 4'h1);
		@ (negedge clk) assert (State == 4'h2);
		@ (negedge clk) assert (State == 4'h4);
		@ (negedge clk) assert (State == 4'h5);

		IR = 16'h3000;
		IR[11:0] = $urandom();
		@ (negedge clk) assert (State == 4'h1);
		@ (negedge clk) assert (State == 4'h2);
		@ (negedge clk) assert (State == 4'h7);

		IR = 16'h4000;
		IR[11:0] = $urandom();
		@ (negedge clk) assert (State == 4'h1);
		@ (negedge clk) assert (State == 4'h2);
		@ (negedge clk) assert (State == 4'h8);

		IR = 16'h6000;
		IR[11:0] = $urandom();
		@ (negedge clk) assert (State == 4'h1);
		@ (negedge clk) assert (State == 4'h2);
		@ (negedge clk) assert (State == 4'h9);
		@ (negedge clk) assert (State == 4'h3);

		IR = 16'h7000;
		IR[11:0] = $urandom();
		@ (negedge clk) assert (State == 4'h1);
		@ (negedge clk) assert (State == 4'h2);
		@ (negedge clk) assert (State == 4'hA);
		@ (negedge clk) assert (State == 4'hB);
		@ (negedge clk) assert (State == 4'h3);

		IR[11:0] = $urandom();
		zero_flag = 1'b1;
		@ (negedge clk) assert (State == 4'h1);
		@ (negedge clk) assert (State == 4'h2);
		@ (negedge clk) assert (State == 4'hA);
		@ (negedge clk) assert (State == 4'hB);

		IR = 16'h5000;
		IR[11:0] = $urandom();
		@ (negedge clk) assert (State == 4'h1);
		@ (negedge clk) assert (State == 4'h2);
		@ (negedge clk) assert (State == 4'hC);
		@ (negedge clk) assert (State == 4'hC);
		@ (negedge clk) assert (State == 4'hC);

		$stop;
	end

	initial
		$monitor("%0t IR = %h, State = %h, NextState = %h, RF_W_addr = %h, RF_Ra_addr = %h, RF_Rb_addr = %h", $time, IR, State, NextState, RF_W_addr, RF_Ra_addr, RF_Rb_addr);

endmodule
