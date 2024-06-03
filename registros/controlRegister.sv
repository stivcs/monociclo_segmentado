module controlRegister_de(
    input logic clk,
	input logic clr,
	input logic NextPCSrc,
    input logic [3:0] ALUOp_de,
	input logic [4:0] BrOp_de,
	input logic [2:0] DMCtrl_de,
	input logic [1:0] RUDataWrSrc_de,
	input logic RuWr_de,
	input logic DMWr_de,
	input logic AluASrc_de,
	input logic AluBSrc_de,
    output logic [3:0] ALUOp_ex,
	output logic [4:0] BrOp_ex,
	output logic [2:0] DMCtrl_ex,
	output logic [1:0] RUDataWrSrc_ex,
	output logic RuWr_ex,
	output logic DMWr_ex,
	output logic AluASrc_ex,
	output logic AluBSrc_ex
);

    always_ff @(posedge clk) begin
       if (clr || NextPCSrc) begin  // se genera el nop
			ALUOp_ex <= 4'b0000;
			BrOp_ex <= 5'b00000;
			DMCtrl_ex <= 3'b000;
			RUDataWrSrc_ex <= 2'b00;
			RuWr_ex <= 1'b0;
			DMWr_ex <= 1'b0;
			AluASrc_ex <= 1'b0;
			AluBSrc_ex <= 1'b1;
	   end
	   else begin
		 	ALUOp_ex <= ALUOp_de;	
			BrOp_ex <= BrOp_de;
			DMCtrl_ex <= DMCtrl_de;
			RUDataWrSrc_ex <= RUDataWrSrc_de;
			RuWr_ex <= RuWr_de;
			DMWr_ex <= DMWr_de;
			AluASrc_ex <= AluASrc_de;
			AluBSrc_ex <= AluBSrc_de;
	   end
    end
endmodule