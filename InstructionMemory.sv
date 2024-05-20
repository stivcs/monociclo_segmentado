module InstructionMemory(
    input logic [31:0] Adress,
    output logic [31:0] Inst
);
    /*
     Defino una matriz llamada mem que contiene los datos de la memoria de instrucciones., 
     cada uno de los cuales es un byte (8 bits) de datos. Esta matriz es
     para tiene que ser de un tamaño en el que quepan todas las instrucciones si no salta un warning
    */
    logic [7:0] mem [0:1023];
    // Leo mi archivo memfile
    initial begin
        $readmemh("memfile2.mem",mem); 
    end
    always @* begin
        Inst = {mem[Adress],mem[Adress + 1],mem[Adress + 2],mem[Adress + 3]};
    end

endmodule