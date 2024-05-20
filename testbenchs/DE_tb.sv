`timescale 1ns/1ps

module DE_tb;
    logic clk;
    logic [31:0] inst_de;
    logic [31:0] muxData;
    logic [31:0] ru1;
    logic [31:0] ru2;
    logic [31:0] ImmExt;
    logic AluASrc;
    logic AluBSrc;
    logic RuWr;
    logic DMWr;
    logic [1:0] RUDataWrSrc;
    logic [3:0] AluOp;
    logic [4:0] BrOp;
    logic [2:0] DMCtrl;

    // Instancia del módulo DE
    DE uut (
        .clk(clk),
        .inst_de(inst_de),
        .muxData(muxData),
        .ru1(ru1),
        .ru2(ru2),
        .ImmExt(ImmExt),
        .AluASrc(AluASrc),
        .AluBSrc(AluBSrc),
        .RuWr(RuWr),
        .DMWr(DMWr),
        .RUDataWrSrc(RUDataWrSrc),
        .AluOp(AluOp),
        .BrOp(BrOp),
        .DMCtrl(DMCtrl)
    );

    // Generación de la señal de reloj
    initial begin
        clk = 0;
        forever #15 clk = ~clk;  // Período de reloj de 30 nanosegundos (15 ns alto, 15 ns bajo)
    end

    // Inicialización de señales y casos de prueba
    initial begin
        // Inicializar las señales de entrada
        inst_de = 32'h00000000;
        muxData = 32'h00000000;

        // Establecer el dump file para ver la simulación en un visualizador de ondas
        $dumpfile("DE_tb.vcd");
        $dumpvars(0, DE_tb);

        // Caso de prueba 1
        #30;
        inst_de = 32'h00540413;  // Ejemplo de instrucción addi x8,x8,5
        muxData = 32'h00000005;  // Valor de x8

        // Caso de prueba 2
        #30;
        inst_de = 32'h008904b3;  // Otro ejemplo de instrucción add x9,x18,x8
        muxData = 32'h87654321; // Valor de x18 = 87654321 EN DECIMAL 2252298273

        // Caso de prueba 3
        #30;
        inst_de = 32'h013909b3;  // Otro ejemplo de instrucción add x19,x18,x19
        muxData = 32'h0F0F0F0F; // Valor de x19 = 0F0F0F0F EN DECIMAL 252645135

        // Finalizar la simulación
        #30;
        $finish;
    end
endmodule