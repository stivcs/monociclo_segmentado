
module WB(
    input logic [31:0] alu_out_wb,
    input logic [31:0] pc4_wb,
    input logic [31:0] DataRd_wb,
    input logic [1:0] RUDataWrSrc_wb,
    output logic [31:0] muxData_wb
);
    always @* begin
        case(RUDataWrSrc_wb)
            2'b10: muxData_wb = pc4_wb;
            2'b01: muxData_wb = DataRd_wb;
            2'b00: muxData_wb = alu_out_wb;
        endcase
end   
endmodule