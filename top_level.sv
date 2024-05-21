//-------------------------------------
// aqui van tod0s los registros de las diferentes etapas del procesador
// en fetch stage falta  los registros de pcInc_de, pc_de y inst_de
// en decode stage falta los registros de ru1_ex, ru2_ex, ImmExt_ex, AluASrc_ex, AluBSrc_ex, RuWr_ex, DMWr_ex, RUDataWrSrc_ex, AluOp_ex, BrOp_ex, DMCtrl_ex
//ru2_ex y ru_me esta aca en el top level
//-------------------------------------
`include "FE.sv"
`include "DE.sv"
`include "EX.sv"
`include "ME.sv"
`include "WB.sv"
`include "registros/register32.sv"

module top_level;
    //cables
    input logic clk,NextPCSrc;
    input logic [31:0] Adress,pc,inst,pc_out;
    //instancia de los modulos
    FE fetch(
        .clk(clk),
        .NextPCSrc(),
        .Adress(),
        .pc(),
        .inst(),
        .pc_out()
    );
    DE decode(
        .clk(clk),
        .inst_de(),
        .muxData(), 
        .RuWr_wb(), 
        .ru1(), 
        .ru2(), 
        .ImmExt(), 
        .AluASrc(), 
        .AluBSrc(), 
        .RuWr(), 
        .DMWr(), 
        .RUDataWrSrc(), 
        .AluOp(),
        .BrOp(), 
        .DMCtrl(), 
        .rs1_de(),
        .rs2_de(),
        .rd_de()
    );
    EX execute(
        .clk(clk),
        .pc_ex(),
        .ru1_ex(),
        .ru2_ex(),
        .ImmExt_ex(),
        .AluASrc_ex(),
        .AluBSrc_ex(),
        .AluOp_ex(),
        .BrOp_ex(),
        .muxData(),
        .alu_out_me(),
        .rs1_ex(),
        .rs2_ex(),
        .rd_me(),
        .rd_wb(),
        .RuWr_me(),
        .RuWr_wb(),
        .alu_out(),
        .NextPCSrc()
    );
    ME memory(
        .alu_out_me(),
        .ru2_me(),
        .DMWr_me(),
        .DMCtrl_me(),
        .DataRd_me()
    );
    WB writeback(
    .alu_out_wb(),
    .pc4_wb(),
    .DataRd_wb(),
    .RUDataWrSrc_wb(),
    .muxData_wb()
    );
    //registros
    register32 PcInc_de(
        .clk(clk),
        .entrada(),
        .salida()
    );
    register32 Pc_o_de(  //pc_de
        .clk(clk),
        .entrada(),
        .salida()
    );
    register32 Inst_de(
        .clk(clk),
        .entrada(),
        .salida()
    );

endmodule