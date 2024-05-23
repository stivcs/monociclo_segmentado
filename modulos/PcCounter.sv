module PcCounter(
    input logic clk,
    input logic [31:0] pc,
    input logic en,
    output logic [31:0] pc_out
);
    initial begin
        pc_out = 32'h0;
    end
    always_ff @(posedge clk) begin
        if (en) begin
         pc_out <= pc;
        end
    end
endmodule