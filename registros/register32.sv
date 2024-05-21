module register32(
    input logic clk,
    input logic [31:0] entrada,
    output logic [31:0] salida
);
    always_ff @(posedge clk) begin
        salida <= entrada;
    end

endmodule