module registerUnit (
  input logic [31:0] RuDataWrite, //datos a escribir
  input logic [4:0] rd,  			//donde escribir
  input logic [4:0] rs1,			//que registro leer
  input logic [4:0] rs2,			//que registro leer
  input logic clk,					//reloj
  input logic Ruwr,					//habilitador de escritura
  output logic [31:0] Ru1,				//salida de registro que se lee
  output logic [31:0] Ru2				//salida de registro que se lee
);

  logic [31:0] reg_file [31:0];		//vector que contiene los registros
  initial begin
    for (int i = 0; i < 32; i++) begin
      reg_file[i] = 32'h00000000;
    end
  end
  always_ff @(posedge clk) begin
    //el registro en la posicion 0 siempre es 0
    if (Ruwr && rd != 5'b00000) reg_file[rd] <= RuDataWrite;
  end

  always @* begin
    Ru1 = reg_file[rs1];
    Ru2 = reg_file[rs2];
  end

endmodule