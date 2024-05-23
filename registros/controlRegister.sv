module controlRegister_de(
    input logic clk,
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
        ALUOp_ex <= ALUOp_de;
        BrOp_ex <= BrOp_de;
        DMCtrl_ex <= DMCtrl_de;
        RUDataWrSrc_ex <= RUDataWrSrc_de;
        RuWr_ex <= RuWr_de;
        DMWr_ex <= DMWr_de;
        AluASrc_ex <= AluASrc_de;
        AluBSrc_ex <= AluBSrc_de;
    end
endmodule