module hdu(
	input logic [4:0] rs1_de,
	input logic [4:0] rs2_de,
	input logic [4:0] rd_ex,
	input logic DMRd_ex,
	input logic clk,
	output logic clr,
	output logic pc_inc_de,
	output logic pc_fe
);

always_ff @(posedge clk)
	if (DMRd_ex && ((rs1_de == rd_ex) || (rs2_de == rd_ex)))
		begin
			clr = 1'b1;
			pc_inc_de = 1'b0;
			pc_fe = 1'b0;
		end
	else
		begin
			clr = 1'b0;
			pc_inc_de = 1'b1;
			pc_fe = 1'b1;
		end
	
endmodule