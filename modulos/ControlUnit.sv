module ControlUnit(
	input logic [6:0] opcode,
	input logic [2:0] function3,
	input logic [6:0] function7,
	output logic [3:0] alu_op,
	output logic [2:0] imm_src,
	output logic [4:0] bu_op,
	output logic [2:0] dm_ctrl,
	output logic [1:0] RU_DM_write_src,
	output logic RUwrite,
	output logic dm_wr,
	output logic alu_a_src,
	output logic alu_b_src
);

parameter R = 7'b0110011;
parameter I = 7'b0010011;
parameter L = 7'b0000011;
parameter S = 7'b0100011;
parameter B = 7'b1100011;
parameter LUI = 7'b0110111;
parameter AUIPC = 7'b0010111;
parameter J = 7'b1101111;
parameter JR = 7'b1100111;



always@(*)
	case (opcode)
		R: begin
				RUwrite = 1'b1;
				imm_src = 3'bxxx;
				bu_op = 5'b00xxx;
				alu_op = {function7[5], function3};
				dm_ctrl = 3'bxxx;
				dm_wr = 1'b0;
				RU_DM_write_src = 2'b00;
				alu_a_src = 1'b0;
				alu_b_src = 1'b0;
			end
		I:	begin
				RUwrite = 1'b1;
				imm_src = 3'b000;
				bu_op = 5'b00xxx;
				if(function3 == 3'b000)
					alu_op <= {function7[5], function3};
				else
					alu_op <= {1'b0, function3};
				dm_ctrl = 3'bxxx;
				dm_wr = 1'b0;
				RU_DM_write_src = 2'b00;
				alu_a_src = 1'b0;
				alu_b_src = 1'b1;
			end
		L:	begin
				RUwrite = 1'b1;
				imm_src = 3'b000;
				bu_op = 5'b00xxx;
				alu_op = 4'b0000;
				dm_ctrl = function3;
				dm_wr = 1'b0;
				RU_DM_write_src = 2'b01;
				alu_a_src = 1'b0;
				alu_b_src = 1'b1;
			end
		S: 	begin
				RUwrite = 1'b0;
				imm_src = 3'b001;
				bu_op = 5'b00xxx;
				alu_op = 4'b0000;
				dm_ctrl = function3;
				dm_wr = 1'b1;
				RU_DM_write_src = 2'b01;
				alu_a_src = 1'b0;
				alu_b_src = 1'b1;
			end
			

		B:	begin
				RUwrite = 1'b0;
				imm_src = 3'b101;
				bu_op = { 2'b01, function3 };
				alu_op = 4'b0000;
				dm_ctrl = 3'bxxx;
				dm_wr = 1'b0;
				RU_DM_write_src = 2'bxx;
				alu_a_src = 1'b1;
				alu_b_src = 1'b1;
			end
		LUI: begin
			RUwrite = 1'b1;
			imm_src = 3'b010;
			bu_op = 5'b00xxx;
			alu_op = 4'b1111;
			dm_ctrl = 3'bxxx;
			dm_wr = 1'b0;
			RU_DM_write_src = 2'b00;
			alu_a_src = 1'bx;
			alu_b_src = 1'b1;
		end

		AUIPC:
			begin
				RUwrite = 1'b1;
				imm_src = 3'b010;
				bu_op = 5'b00xxx;
				alu_op = 4'b0000;
				dm_ctrl = 3'bxxx;
				dm_wr = 1'b0;
				RU_DM_write_src = 2'b00;
				alu_a_src = 1'b1;
				alu_b_src = 1'b1;
			end

		J:	begin
				RUwrite = 1'b1;
				imm_src = 3'b110;
				bu_op = 5'b1xxxx;
				alu_op = 4'b0000;
				dm_ctrl = 3'bxxx;
				dm_wr = 1'b0;
				RU_DM_write_src = 2'b10;
				alu_a_src = 1'b1;
				alu_b_src = 1'b1;
			end

		JR:	begin
				RUwrite = 1'b1;
				imm_src = 3'b000;
				bu_op = 5'b1xxxx;
				alu_op = 4'b0000;
				dm_ctrl = 3'bxxx;
				dm_wr = 1'b0;
				RU_DM_write_src = 2'b10;
				alu_a_src = 1'b1;
				alu_b_src = 1'b1;
			end

		default: begin
				RUwrite = 1'b0;
				imm_src = 3'bxxx;
				bu_op = 5'b00xxx;
				alu_op = 4'bxxxx;
				dm_ctrl = 3'bxxx;
				dm_wr = 1'b0;
				RU_DM_write_src = 2'bxx;
				alu_a_src = 1'bx;
				alu_b_src = 1'bx;
			end
	endcase
endmodule
