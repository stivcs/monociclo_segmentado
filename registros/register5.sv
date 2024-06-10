module register5(
    input logic clk,
    input logic [4:0] entrada,
    output logic [4:0] salida
);
    always_ff @(posedge clk) begin
        salida <= entrada;
    end

endmodule