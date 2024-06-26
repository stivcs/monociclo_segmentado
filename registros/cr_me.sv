module controlRegister_ex(
    input logic clk,
	input logic [2:0] DMCtrl_ex,
	input logic [1:0] RUDataWrSrc_ex,
	input logic RuWr_ex,
	input logic DMWr_ex,
	output logic [2:0] DMCtrl_me,
	output logic [1:0] RUDataWrSrc_me,
	output logic RuWr_me,
	output logic DMWr_me
);

    always_ff @(posedge clk) begin
          
        DMCtrl_me <= DMCtrl_ex;
        RUDataWrSrc_me <= RUDataWrSrc_ex;
        RuWr_me <= RuWr_ex;
        DMWr_me <= DMWr_ex;

    end
endmodule