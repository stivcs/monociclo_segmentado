module DataMemory(Address, DataWr, DMWr, DMCtrl, DataRd);
    input logic [31:0] Address, DataWr; //Bus de datos de 32 bits
    input logic DMWr; //Habilitador de escritura
    input logic [2:0] DMCtrl; //Bus de control de 2 bits
    output logic [31:0] DataRd; //Bus de salida de 32 bits
    logic [7:0] memoria [1023:0]; //Memoria de 1024 posiciones de 8 bits
    //inicializa la memoria en cero
    initial begin
        for (int i = 0; i < 1024; i = i + 1) begin
            memoria[i] = 8'b0;
        end
    end
    
    always @* begin
        // en 1 escribe en memoria
        if (DMWr) begin
            case (DMCtrl)
                3'b000: begin // B 8 bits
                    memoria[Address] <= DataWr[7:0];
                end
                3'b001: begin // H 16 bits
                    memoria[Address] <= DataWr[15:8];
                    memoria[Address + 1] <= DataWr[7:0];
                end
                3'b010: begin // W 32 bits
                    memoria[Address] <= DataWr[31:24];
                    memoria[Address + 1] <= DataWr[23:16];
                    memoria[Address + 2] <= DataWr[15:8];
                    memoria[Address + 3] <= DataWr[7:0];
                end
                3'b100: begin // B(u)
                    memoria[Address] <= DataWr[7:0];
                end
                3'b101: begin // H(u)
                    memoria[Address] <= DataWr[15:8];
                    memoria[Address + 1] <= DataWr[7:0];
                end
            endcase
        end
        // en 0 lee de memoria
        else begin
            case (DMCtrl)
                3'b000: begin // B 8 bits
                    DataRd <= {{24{memoria[Address][7]}}, memoria[Address]};
                end
                3'b001: begin // H 16 bits
                    DataRd <= {{16{memoria[Address][7]}}, memoria[Address], memoria[Address + 1]};
                end
                3'b010: begin // W 32 bits
                    DataRd <= {memoria[Address], memoria[Address + 1], memoria[Address + 2], memoria[Address + 3]};
                end
                3'b100: begin // B(u)
                    DataRd <= {{24'b0}, memoria[Address]};
                end
                3'b101: begin // H(u)
                    DataRd <= {{16'b0}, memoria[Address + 1], memoria[Address]};
                end
                default: begin
                    DataRd <= 32'b0;
                end
            endcase
        end
    end
endmodule