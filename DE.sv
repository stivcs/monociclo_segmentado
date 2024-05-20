//this is the decode stage of the monocicle
`include "modulos/registerUnit.sv"
`include "modulos/ImmGen.sv"
`include "modulos/ControlUnit.sv"

module DE(
    input logic clk,
    input logic [31:0] inst_de,
    input logic [31:0] muxData, //entrada de DataWrite en la register unit salida de writeback
    input logic RuWr_wb, //de writeback stage
    output logic [31:0] ru1, //salida de register unit
    output logic [31:0] ru2, //salida de register unit
    output logic [31:0] ImmExt, //salida de ImmGen
    output logic AluASrc, //salida de control unit
    output logic AluBSrc, //salida de control unit
    output logic RuWr, //salida de control unit
    output logic DMWr, //salida de control unit
    output logic [1:0] RUDataWrSrc, //salida de control unit
    output logic [3:0] AluOp, //salida de control unit
    output logic [4:0] BrOp, //salida de control unit
    output logic [2:0] DMCtrl //salida de control unit
);

    logic [2:0] ImmSrc; //salida de control unit  se usa en esta etapa

    // Instancias de los módulos
    registerUnit ru(
        .RuDataWrite(muxData),
        .rd(inst_de[11:7]),
        .rs1(inst_de[19:15]),
        .rs2(inst_de[24:20]),
        .clk(clk),
        .Ruwr(RuWr_wb),
        .Ru1(ru1),
        .Ru2(ru2)
    );

    ImmGen imm(
        .Inst(inst_de[31:7]),
        .ImmScr(ImmSrc),
        .ImmExt(ImmExt)
    );

    ControlUnit cu(
        .opcode(inst_de[6:0]),
        .funct3(inst_de[14:12]),
        .funct7(inst_de[31:25]),
        .ALUOp(AluOp),
        .ImmSrc(ImmSrc),
        .BrOp(BrOp),
        .DMCtrl(DMCtrl),
        .RUDataWrSrc(RUDataWrSrc),
        .RuWr(RuWr),
        .DMWr(DMWr),
        .AluASrc(AluASrc),
        .AluBSrc(AluBSrc)
    );

endmodule