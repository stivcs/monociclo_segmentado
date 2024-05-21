module ForwardingUnit (
	input logic [4:0] rs1_ex,
	input logic [4:0] rs2_ex,
	input logic [4:0] rd_me,
	input logic [4:0] rd_wb,
	input logic RuWr_me,
	input logic RuWr_wb,
	output logic [1:0] mux5_out,
	output logic [1:0] mux6_out
);

always @* begin // funciona sin reloj porque no se necesita 
	if (RUwr_me && !RUwr_wb && (rs1_ex == rd_me)) begin
		mux5_out = 2'b01;
	end
	else if (RUwr_me && !RUwr_wb && (rs2_ex == rd_me)) begin
		mux6_out = 2'b01;
	end
	else if (RUwr_wb && !RUwr_me && (rs1_ex == rd_wb)) begin
		mux5_out = 2'b10;
	end
	else if (RUwr_wb && !RUwr_me && (rs2_ex == rd_wb)) begin
		mux6_out = 2'b10;
	end
	else begin
		mux5_out = 2'b00;
		mux6_out = 2'b00;
	end		
end 

endmodule