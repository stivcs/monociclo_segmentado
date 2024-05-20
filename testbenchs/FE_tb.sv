`timescale 1ns/1ps

module FE_tb;
    logic clk;
    logic NextPCSrc;
    logic [31:0] Adress;
    logic [31:0] inst;

    // Instancia del módulo FE
    FE uut (
        .clk(clk),
        .NextPCSrc(NextPCSrc),
        .Adress(Adress),
        .inst(inst)
    );

    // Generación de la señal de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Período de reloj de 10 unidades de tiempo
    end

    // Inicialización de señales y casos de prueba
    initial begin
        // Inicializar las señales de entrada
        Adress = 32'h0;
        NextPCSrc = 0;

        // Establecer el dump file para ver la simulación en un visualizador de ondas
        $dumpfile("FE_tb.vcd");
        $dumpvars(0, FE_tb);

        // Primer caso de prueba: NextPCSrc = 0, el PC debe incrementarse
        #10;
        NextPCSrc = 0;
        #10;
        
        // Segundo caso de prueba: NextPCSrc = 1, el PC debe ser el valor de Adress
        NextPCSrc = 1;
        Adress = 32'h7c;
        #10;

        // Tercer caso de prueba: otro valor para Adress con NextPCSrc = 1
        Adress = 32'h8;
        #10;

        // Finalizar la simulación
        $finish;
    end
endmodule