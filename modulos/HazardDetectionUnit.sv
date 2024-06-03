module HazardDetectionUnit(
	input logic [4:0] rs1_de,
	input logic [4:0] rs2_de,
	input logic [4:0] rd_ex,
	input logic DMRd_ex, //para saber si va a leer en la data memori, 0 si lee en memoria
	input logic clk,
	output logic clr,
	output logic en_pc_inc_de, // eneblo de pc_inc
	output logic en_pc_fe // eneblo de pc_fe
);

	always_ff @(posedge clk)
		if (!DMRd_ex && ((rs1_de == rd_ex) || (rs2_de == rd_ex)))
			begin
				clr = 1'b1;
				en_pc_inc_de = 1'b0;
				en_pc_fe = 1'b0;
			end
		else
			begin
				clr = 1'b0;
				en_pc_inc_de = 1'b1;
				en_pc_fe = 1'b1;
			end
	
endmodule