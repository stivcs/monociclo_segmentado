// this is the fetch stage of the monocicle

`include "modulos/PcCounter.sv"
`include "modulos/InstructionMemory.sv"

module FE(
    input logic clk,
    input logic NextPCSrc,
    input logic [31:0] Adress,
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

    always @* begin
        if (!NextPCSrc) begin
            pc = pc_out + 4;
        end
        else begin
            pc = Adress;
        end
    end
endmodule