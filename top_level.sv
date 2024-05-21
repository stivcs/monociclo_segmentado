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

module top_level;
    //cables

endmodule