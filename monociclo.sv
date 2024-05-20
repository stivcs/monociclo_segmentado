`include "modulos/PcCounter.sv"
`include "modulos/InstructionMemory.sv"
`include "modulos/registerUnit.sv"
`include "modulos/ImmGen.sv"
`include "modulos/ALU.sv"
`include "modulos/DataMemory.sv"
`include "modulos/branchunit.sv"
`include "modulos/ControlUnit.sv"

module monociclo;
    logic [31:0] pc; //entrada de pc counter
    logic [31:0] pc_out; //salida de pc counter
    logic [31:0] inst; //salida de instruction memory
    logic [31:0] ru1, ru2; //salida de register unit 
    logic [31:0] A,B ; //entrada alu
    logic [31:0] ImmExt; //salida de ImmGen
    logic [31:0] alu_out; //salida de alu
    logic [31:0] DataRd; //salida de DataMemory
    logic NextPCSrc; //salida de branch unit
    logic [31:0] muxData; //entrada de DataWrite en la register unit 
    logic [31:0] pc4; //pc + 4
    //señales de control y salidas de control unit
    logic AluASrc,AluBSrc,RuWr,DMWr;
    logic [1:0] RUDataWrSrc;
    logic [2:0] ImmSrc,DMCtrl;
    logic [3:0] AluOP;
    logic [4:0] BrOp;

    logic clk = 0; 
    // Generación de clock
    always #15 clk = ~clk;

    // Inicialización de señales
    initial begin
        $dumpfile("monociclo.vcd");
        $dumpvars(0, monociclo);
        pc = 32'h0;
        #900; // tiempo que se demora en recorrer todas las instrucciones
        $finish;
        // Otros valores de señales de entrada necesarios para la simulación
    end

    //instancias de los modulos
    PcCounter pc_counter(
        .clk(clk),
        .pc(pc),
        .pc_out(pc_out)
    );
    InstructionMemory inst_mem(
        .Adress(pc_out),
        .Inst(inst)
    );
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
    ImmGen imm_gen(
        .Inst(inst[31:7]),
        .ImmScr(ImmSrc),
        .ImmExt(ImmExt)
    );
    ALU alu1(
        .A(A),
        .B(B),
        .ALUop(AluOP),
        .ALUS(alu_out)
    );
    DataMemory data_mem(
        .Address(alu_out),
        .DataWr(ru2),
        .DMWr(DMWr),
        .DMCtrl(DMCtrl),
        .DataRd(DataRd)
    );
    branchunit branch_unit(
        .A(ru1),
        .B(ru2),
        .BrOp(BrOp),
        .NextPCSrc(NextPCSrc)
    );
    ControlUnit control_unit(
        .opcode(inst[6:0]),
        .funct3(inst[14:12]),
        .funct7(inst[31:25]),
        .AluASrc(AluASrc),
        .AluBSrc(AluBSrc),
        .RuWr(RuWr),
        .ImmSrc(ImmSrc),
        .ALUOp(AluOP),
        .BrOp(BrOp),
        .DMWr(DMWr),
        .DMCtrl(DMCtrl),
        .RUDataWrSrc(RUDataWrSrc)
    );
    

    always @* begin
        pc4 = pc_out + 32'h4;
        case(AluASrc)
            1'b0: A = ru1;
            1'b1: A = pc_out;
        endcase
        case(AluBSrc)
            1'b0: B = ru2;
            1'b1: B = ImmExt;
        endcase
        case(NextPCSrc)
            1'b0: pc = pc4;
            1'b1: pc = alu_out;
        endcase
        case(RUDataWrSrc)
            2'b10: muxData = pc4;
            2'b01: muxData = DataRd;
            2'b00: muxData = alu_out;
        endcase   
    end

     
    
endmodule