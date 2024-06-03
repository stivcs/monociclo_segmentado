module pcinc_re(
    input logic clk,
    input logic en,
    input logic NextPCSrc
    input logic [31:0] entrada,
    output logic [31:0] salida
);
    always_ff @(posedge clk) begin
        if (en || !NextPCSrc) begin
            salida <= entrada;    
        end
    end

endmodule