`include "modulos/ALU.sv"
`include "modulos/branchunit.sv"
`include "modulos/ForwardingUnit.sv"

module EX(
    input logic clk,
    input logic [31:0] pc_ex,
    input logic [31:0] ru1_ex,
    input logic [31:0] ru2_ex,
    input logic [31:0] ImmExt_ex,
    input logic AluASrc_ex,
    input logic AluBSrc_ex,
    input logic [3:0] AluOp_ex,
    input logic [4:0] BrOp_ex,
    input logic [31:0] muxData,
    input logic [31:0] alu_out_me,
    input logic [4:0] rs1_ex,
    input logic [4:0] rs2_ex,
    input logic [4:0] rd_me,
    input logic [4:0] rd_wb,
    input logic RuWr_me,
    input logic RuWr_wb,
    output logic [31:0] alu_out,
    output logic NextPCSrc

);
    //cables de entrada
    logic [31:0] A,B ; //entrada alu
    logic [1:0] mux5, mux6; //salida de forwarding unit
    //cables de salida
    logic [1:0] mux5_out,mux6_out; //salida de mux de la fu(ForwardingUnit)

    //instancias de los modulos
    ALU alu1(
        .A(A),
        .B(B), 
        .ALUop(AluOp_ex),
        .ALUS(alu_out)
    );

    branchunit branch_unit(
        .A(mux5_out),
        .B(mux6_out),
        .BrOp(BrOp_ex),
        .NextPCSrc(NextPCSrc)
    );
    ForwardingUnit fu(
	.rs1_ex(rs1_ex),
	.rs2_ex(rs2_ex),
	.rd_me(rd_me),
	.rd_wb(rd_wb),
	.RuWr_me(RuWr_me),
	.RuWr_wb(RuWr_wb),
	.mux5_out(mux5),
	.mux6_out(mux6)
);

    //logica de control y mux de execute
    always @* begin
        //mux de ru1 de execute
        case(mux5)
            2'b11: mux5_out = rd_wb;
            2'b01: mux5_out = alu_out_me;
            2'b00: mux5_out = ru1_ex;
        endcase
        //mux de ru2 de execute
        case(mux6)
            2'b11: mux6_out = rd_wb;
            2'b01: mux6_out = alu_out_me;
            2'b00: mux6_out = ru2_ex;
        endcase
        //mux de la entrada A de la alu
        case(AluASrc_ex)
            1'b0: A = mux5_out;
            1'b1: A = pc_ex;
        endcase
        //mux de la entrada B de la alu
        case(AluBSrc_ex)
            1'b0: B = mux6_out;
            1'b1: B = ImmExt_ex;
        endcase
    end

endmodule