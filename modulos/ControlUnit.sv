module ControlUnit(
	input logic [6:0] opcode,
	input logic [2:0] funct3,
	input logic [6:0] funct7,
	output logic [3:0] ALUOp,
	output logic [2:0] ImmSrc,
	output logic [4:0] BrOp,
	output logic [2:0] DMCtrl,
	output logic [1:0] RUDataWrSrc,
	output logic RuWr,
	output logic DMWr,
	output logic AluASrc,
	output logic AluBSrc
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
				RuWr = 1'b1;
				ImmSrc = 3'b000; // no se usa
				BrOp = 5'b00000;
				ALUOp = {funct7[5], funct3};
				DMCtrl = 3'b000; // no se usa
				DMWr = 1'b0;
				RUDataWrSrc = 2'b00;
				AluASrc = 1'b0;
				AluBSrc = 1'b0;
			end
		I:	begin
				RuWr = 1'b1;
				ImmSrc = 3'b000;
				BrOp = 5'b00000;
				if(funct3 == 3'b000)
					ALUOp <= {funct7[5], funct3};
				else
					ALUOp <= {1'b0, funct3};
				DMCtrl = 3'b000; // no se usa
				DMWr = 1'b0;
				RUDataWrSrc = 2'b00;
				AluASrc = 1'b0;
				AluBSrc = 1'b1;
			end
		L:	begin
				RuWr = 1'b1;
				ImmSrc = 3'b000;
				BrOp = 5'b00000;
				ALUOp = 4'b0000;
				DMCtrl = funct3;
				DMWr = 1'b0;
				RUDataWrSrc = 2'b01;
				AluASrc = 1'b0;
				AluBSrc = 1'b1;
			end
		S: 	begin
				RuWr = 1'b0;
				ImmSrc = 3'b001;
				BrOp = 5'b00000;
				ALUOp = 4'b0000;
				DMCtrl = funct3;
				DMWr = 1'b1;
				RUDataWrSrc = 2'b01;
				AluASrc = 1'b0;
				AluBSrc = 1'b1;
			end
			

		B:	begin
				RuWr = 1'b0;
				ImmSrc = 3'b101;
				BrOp = { 2'b01, funct3 };
				ALUOp = 4'b0000;
				DMCtrl = 3'b000; // no se usa
				DMWr = 1'b0;
				RUDataWrSrc = 2'b00; // no se usa
				AluASrc = 1'b1;
				AluBSrc = 1'b1;
			end
		LUI: begin
			RuWr = 1'b1;
			ImmSrc = 3'b010;
			BrOp = 5'b00000;
			ALUOp = 4'b1111;
			DMCtrl = 3'b000; // no se usa
			DMWr = 1'b0;
			RUDataWrSrc = 2'b00;
			AluASrc = 1'b0; // no se usa
			AluBSrc = 1'b1;
		end

		AUIPC:
			begin
				RuWr = 1'b1;
				ImmSrc = 3'b010;
				BrOp = 5'b00000;
				ALUOp = 4'b0000;
				DMCtrl = 3'b000; // no se usa
				DMWr = 1'b0;
				RUDataWrSrc = 2'b00;
				AluASrc = 1'b1;
				AluBSrc = 1'b1;
			end

		J:	begin
				RuWr = 1'b1;
				ImmSrc = 3'b110;
				BrOp = 5'b10000;
				ALUOp = 4'b0000;
				DMCtrl = 3'b000; // no se usa
				DMWr = 1'b0;
				RUDataWrSrc = 2'b10;
				AluASrc = 1'b1;
				AluBSrc = 1'b1;
			end

		JR:	begin
				RuWr = 1'b1;
				ImmSrc = 3'b000;
				BrOp = 5'b10000;
				ALUOp = 4'b0000;
				DMCtrl = 3'b000; // no se usa
				DMWr = 1'b0;
				RUDataWrSrc = 2'b10;
				AluASrc = 1'b1;
				AluBSrc = 1'b1;
			end

		default: begin
				RuWr = 1'b1;
				ImmSrc = 3'b000; // no se usa
				BrOp = 5'b00000; 
				ALUOp = 4'b0000; 
				DMCtrl = 3'b000;
				DMWr = 1'b0;
				RUDataWrSrc = 2'b00;
				AluASrc = 1'b0;
				AluBSrc = 1'b0;
			end
	endcase
endmodule
