//ALU
//Desing
module ALU (A,B,ALUop,ALUS);
  input logic [31:0] A, B; //Bus de datos de 32 bits
  input logic [3:0] ALUop; //Bus de control de 4 bits
  output logic signed [31:0] ALUS; //Bus de salida de 32 bits
  
  always @*
    begin 
      case (ALUop)
        4'b0000: ALUS = A + B; //0 suma
        4'b1000: ALUS = A - B; //1 resta
        4'b0001: ALUS = A << B; //2 shift left
        4'b0010: ALUS = A < B; //3 signed
        4'b0011: ALUS = $unsigned(A) < $unsigned(B); //4(unsigned)
        4'b0100: ALUS = A ^ B; //5 xor
        4'b0101: ALUS = A >> B; //6 shift right
        // B tiene que ser menor que 32
        4'b1101: ALUS = A >>> B[4:0]; //7 
        4'b0110: ALUS = A | B; //8 or
        4'b0111: ALUS = A & B; //9 and
        default: ALUS = 4'b0; // Manejar caso no definido
      endcase
    end

endmodule