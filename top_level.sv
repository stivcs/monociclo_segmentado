//-------------------------------------
// aqui van tods los registros de las diferentes etapas del procesador
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
`include "registros/pcinc_re.sv" // registro con eneble de pc_inc
`include "registros/controlRegister.sv"
`include "registros/register5.sv"
`include "registros/cr_me.sv"


module top_level;
    //cables
    logic clk,NextPCSrc;
    logic [31:0] pc_int,inst,pc_out,pcInc,alu_out; //cables de fetch
    //cable de decode
    logic [31:0] pcInc_de,pc_de,inst_de; //cables de los registros de decode
    logic en_pc_fe,en_pc_inc_de,clr; //cables de hazard detection unit
    logic [31:0] ru1,ru2,ImmExt; //salida de decode
    logic [4:0] rs1_de,rs2_de,rd_de; //salida de decode
    logic [3:0] ALUOp_de;
	logic [4:0] BrOp_de;
	logic [2:0] DMCtrl_de;
	logic [1:0] RUDataWrSrc_de;
	logic RuWr_de;
	logic DMWr_de;
	logic AluASrc_de;
	logic AluBSrc_de;
    logic [2:0] ImmSrc_de;
    //cables de execute
    logic [31:0] pc_ex,ru1_ex,ru2_ex,ImmExt_ex; //cabes de los registros de execute
    logic [3:0] ALUOp_ex;
    logic [4:0] BrOp_ex;
    logic [2:0] DMCtrl_ex;
    logic [1:0] RUDataWrSrc_ex;
    logic RuWr_ex;
    logic DMWr_ex;
    logic AluASrc_ex;
    logic AluBSrc_ex;
    //cables de memory
    logic [31:0] alu_out_me,ru2_me; //cables de los registros de memory
    logic [2:0] DMCtrl_me;
    logic [1:0] RUDataWrSrc_me;
    logic RuWr_me;
    logic DMWr_me;
    logic [31:0] dataRd; //cable de data memory
    //cables de writeback
    //instancia de los modulos
    FE fetch(
        .clk(clk),
        .en_pc_fe(en_pc_fe),
        .pc(pc_int),
        .inst(inst),
        .pc_out(pc_out)
    );
    //registros de la etapa de fetch o las entradas de decode
    pcinc_re PcInc_de(
        .clk(clk),
        .en(en_pc_inc_de),
        .NextPCSrc(NextPCSrc),
        .entrada(pcInc),
        .salida(pcInc_de)
    );
    register32 Pc_o_de(  //pc_de
        .clk(clk),
        .entrada(pc_out),
        .salida(pc_de)
    );
    register32 Inst_de(
        .clk(clk),
        .entrada(inst),
        .salida(inst_de)
    );
    //inicio decode
    DE decode(
        .clk(clk),
        .inst_de(inst_de),
        .muxData(),  // lo que se escribe en la unidad de registros o datawrite  //!falta
        .RuWr_wb(),  // de writeback stage de la unidad de control si se escribe o no //!falta
        .DMRd_ex(DMWr_ex), // si se va a leer en la data memory //? no se si es correcto revisar
        .ru1(ru1), 
        .ru2(ru2), 
        .ImmExt(ImmExt),
        .clr(clr),
        .en_pc_inc_de(en_pc_inc_de),
        .en_pc_fe(en_pc_fe), 
        .AluASrc(AluASrc_de), 
        .AluBSrc(AluBSrc_de), 
        .RuWr(RuWr_de), 
        .DMWr(DMWr_de), 
        .RUDataWrSrc(RUDataWrSrc_de), 
        .AluOp(ALUOp_de),
        .BrOp(BrOp_de), 
        .DMCtrl(DMCtrl_de), 
        .rs1_de(rs1_de),
        .rs2_de(rs2_de),
        .rd_de(rd_de)
    );
    controlRegister_de cr_ex(
    .clk(clk),
    .clr(clr),
    .NextPCSrc(NextPCSrc),
    .ALUOp_de(ALUOp_de),
	.BrOp_de(BrOp_de),
	.DMCtrl_de(DMCtrl_de),
	.RUDataWrSrc_de()RUDataWrSrc_de,
	.RuWr_de(RuWr_de),
	.DMWr_de(DMWr_de),
	.AluASrc_de(AluASrc_de),
	.AluBSrc_de(AluBSrc_de),
    .ALUOp_ex(AluOp_ex),
	.BrOp_ex(BrOp_ex),
	.DMCtrl_ex(DMCtrl_ex),
	.RUDataWrSrc_ex(RUDataWrSrc_ex),
	.RuWr_ex(RuWr_ex),
	.DMWr_ex(DMWr_ex),
	.AluASrc_ex(AluASrc_ex),
	.AluBSrc_ex(AluBSrc_ex)
     );
    register32 PcInc_ex(
        .clk(clk),
        .entrada(pcInc_de),
        .salida(pcInc_ex)
    );
    register32 Pc_o_ex(  //pc_de
        .clk(clk),
        .entrada(pc_de),
        .salida(pc_ex)
    );
    register32 Ru1_ex(
        .clk(clk),
        .entrada(ru1),
        .salida(ru1_ex)
    );
    register32 Ru2_ex(
        .clk(clk),
        .entrada(ru2),
        .salida(ru2_ex)
    );
    register32 ImmExt_ex(
        .clk(clk),
        .entrada(ImmExt),
        .salida(ImmExt_ex)
    );
    register5 rs1_ex(
        .clk(clk),
        .entrada(rs1_de),
        .salida(rs1_ex)
    );
    register5 rs2_ex(
        .clk(clk),
        .entrada(rs2_de),
        .salida(rs2_ex)
    );
    register5 rd_ex(
        .clk(clk),
        .entrada(rd_de),
        .salida(rd_ex)
    );
    
    EX execute(
        .clk(clk),
        .pc_ex(pc_ex),
        .ru1_ex(ru1_ex),
        .ru2_ex(ru2_ex),
        .ImmExt_ex(ImmExt_ex),
        .AluASrc_ex(AluASrc_ex),
        .AluBSrc_ex(AluBSrc_ex),
        .AluOp_ex(AluOp_ex),
        .BrOp_ex(BrOp_ex),
        .muxData(), //mux de datos de la unidad de registros o datawrite //!falta
        .alu_out_me(),
        .rs1_ex(rs1_ex),
        .rs2_ex(rs2_ex),
        .rd_me(rd_me), 
        .rd_wb(), //!falta
        .RuWr_me(RuWr_me), 
        .RuWr_wb(), //!falta
        .alu_out(alu_out),
        .NextPCSrc(NextPCSrc)
    );
    controlRegister_ex cr_ex(
    .clk(clk),
	.DMCtrl_ex(DMCtrl_ex),
	.RUDataWrSrc_ex(RUDataWrSrc_ex),
	.RuWr_ex(RuWr_ex),
	.DMWr_ex(DMWr_ex),
	.DMCtrl_me(DMCtrl_me),
	.RUDataWrSrc_me(RUDataWrSrc_me),
	.RuWr_me(RuWr_me),
	.DMWr_me(DMWr_me)
    );
    register32 PcInc_me(
        .clk(clk),
        .entrada(pcInc_ex),
        .salida(pcInc_me)
    );
    register32 alu_res_me(
        .clk(clk),
        .entrada(alu_out),
        .salida(alu_out_me)
    );
    register32 ru2_me(
        .clk(clk),
        .entrada(ru2_ex),
        .salida(ru2_me)
    );
    register5 rd_me(
        .clk(clk),
        .entrada(rd_ex),
        .salida(rd_me)
    );
    ME memory(
        .alu_out_me(alu_out_me),
        .ru2_me(ru2_me),
        .DMWr_me(DMWr_me),
        .DMCtrl_me(DMCtrl_me),
        .DataRd_me(dataRd)
    );
    register32 alu_out_wb(
        .clk(clk),
        .entrada(alu_out),
        .salida(alu_out_wb)
    );
    register32 pc_wb(
        .clk(clk),
        .entrada(pc_ex),
        .salida(pc_wb)
    );
    register32 DataRd_wb(
        .clk(clk),
        .entrada(dataRd),
        .salida(DataRd_wb)
    );
    register5 rd_wb(
        .clk(clk),
        .entrada(rd_me),
        .salida(rd_wb)
    );
    WB writeback(
    .alu_out_wb(),
    .pc4_wb(),
    .DataRd_wb(),
    .RUDataWrSrc_wb(),
    .muxData_wb()
    );
    
    always @* begin
        pcInc = pc_out + 4;
        //mux de fetch
        if (NextPCSrc == 0) begin
            pc_int = pcInc;
        end
        else begin
            pc_int = alu_out;
        end

    end

endmodule