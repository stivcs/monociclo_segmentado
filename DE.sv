//this is the decode stage of the monocicle
`include "modulos/registerUnit.sv"
`include "modulos/ImmGen.sv"
`include "modulos/ControlUnit.sv"

module DE(
    input logic clk,
    input logic [31:0] inst,
    output logic [31:0] ru1,
    output logic [31:0] ru2,
    output logic [31:0] ImmExt,
    output logic AluASrc,
    output logic AluBSrc,
    output logic RuWr,
    output logic DMWr,
    output logic [1:0] RUDataWrSrc,
    output logic [2:0] ImmSrc,
    output logic [3:0] AluOp,
    output logic [4:0] BrOp,
    output logic [2:0] DMCtrl
);

    // Señales de control y salidas de control unit
    logic AluASrc, AluBSrc, RuWr, DMWr;
    logic [1:0] RUDataWrSrc;
    logic [2:0] ImmSrc, DMCtrl;
    logic [3:0] AluOp;
    logic [4:0] BrOp;

    // Instancias de los módulos
    registerUnit ru(
        .RuDataWrite(muxData),
        .rd(inst[11:7]),
        .rs1(inst[19:15]),
        .rs2(inst[24:20]),
        .clk(clk),
        .Ruwr(RuWr),
        .Ru1(ru1),
        .Ru2(ru2)
    );
    ImmGen imm(
        .inst(inst),
        .ImmExt(ImmExt)
    );
    ControlUnit cu(
        .opcode(inst[6:0]),
        .funct3(inst[14:12]),
        .funct7(inst[31:25]),
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