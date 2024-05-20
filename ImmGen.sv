module ImmGen(Inst, ImmScr, ImmExt);
    input logic[24:0] Inst;
    input logic[2:0] ImmScr;
    output logic[31:0] ImmExt;
    
    // I 000 S 001 B 101 U 010 J 110
    always @* begin //cambia con cualquier cambio en las entradas
        case(ImmScr)
            3'b000: ImmExt = {{20{Inst[24]}}, Inst[24:13]}; // Rango completo de ImmExt
            3'b001: ImmExt = {{9{Inst[24]}}, Inst[24:18], Inst[4:0]}; // Rango completo de ImmExt
            3'b101: ImmExt = {{9{Inst[24]}}, Inst[0], Inst[23:18], Inst[4:1], 1'b0}; // Rango completo de ImmExt
            3'b010: ImmExt = {Inst[24:5],12'b0}; // Rango completo de ImmExt
            3'b110: ImmExt = {Inst[24], Inst[12:5], Inst[13], Inst[23:14],1'b0}; // Rango completo de ImmExt
            default: ImmExt = 32'b0;
        endcase
    end
endmodule

