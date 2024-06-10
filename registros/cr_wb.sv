module controlRegister_wb(
    input logic clk,
	input logic [1:0] RUDataWrSrc_me,
	input logic RuWr_me,
	output logic [1:0] RUDataWrSrc_wb,
	output logic RuWr_wb
);

    always_ff @(posedge clk) begin

        RUDataWrSrc_wb <= RUDataWrSrc_me;
        RuWr_wb <= RuWr_me;

    end
endmodule