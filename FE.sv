// this is the fetch stage of the monocicle

`include "modulos/PcCounter.sv"
`include "modulos/InstructionMemory.sv"

module FE(
    input logic clk,
    input logic [31:0] pc,
    output logic [31:0] inst,
    output logic [31:0] pc_out
);
    // Instancias de los módulos
    PcCounter pcc(
        .clk(clk),
        .pc(pc),
        .pc_out(pc_out)
    );
    InstructionMemory im(
        .Adress(pc_out),
        .Inst(inst)
    );

endmodule