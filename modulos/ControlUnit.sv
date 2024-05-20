module ControlUnit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output logic AluASrc,
    output logic AluBSrc,
    output logic RuWr,
    output logic [2:0] ImmSrc,
    output logic [3:0] ALUOp,
    output logic [4:0] BrOp,
    output logic DMWr,
    output logic [2:0] DMCtrl,
    output logic [1:0] RUDataWrSrc
);

    always @* begin
        AluASrc = opcode[6];
        case (opcode)
            7'b0110011: begin // instrucciones tipo R
                AluBSrc = 0;
                RuWr = 1;
                ImmSrc = 3'b000; // no se usa
                ALUOp = {funct7[5],funct3};
                BrOp = 5'b00000;
                DMWr = 0;
                DMCtrl = 3'b000; // no se usa
                RUDataWrSrc = 2'b00;
            end
            7'b0010011: begin // instrucciones tipo I
                AluBSrc = 1;
                RuWr = 1;
                ImmSrc = 3'b000;
                ALUOp = {1'b0,funct3}; //no hay manera de reconer el srai
                BrOp = 5'b00000;
                DMWr = 0;
                DMCtrl = 3'b000;
                RUDataWrSrc = 2'b00;
            end
            7'b0000011: begin // instrucciones tipo I de carga
                AluBSrc = 1;
                RuWr = 1;
                ImmSrc = 3'b000;
                ALUOp = 4'b0000;
                BrOp = 5'b00000;
                DMWr = 0;
                DMCtrl = {funct3};
                RUDataWrSrc = 2'b01;
            end
            7'b0100011: begin // instrucciones tipo S
                AluBSrc = 1;
                RuWr = 0;
                ImmSrc = 3'b001;
                ALUOp = 4'b000;
                BrOp = 5'b00000;
                DMWr = 1;
                DMCtrl = {funct3};
                RUDataWrSrc = 2'b00; // no se usa
            end
            7'b1100011: begin // instrucciones tipo B
                AluBSrc = 1;
                RuWr = 0;
                ImmSrc = 3'b101;
                ALUOp = 4'b000;
                BrOp = {2'b01, funct3};
                DMWr = 0;
                DMCtrl = 3'b000; // no se usa
                RUDataWrSrc = 2'b00; // no se usa
            end
            7'b1101111: begin // instrucciones tipo JAL
                AluBSrc = 1;
                RuWr = 1;
                ImmSrc = 3'b110;
                ALUOp = 4'b000;
                BrOp = 5'b10000;
                DMWr = 0;
                DMCtrl = 3'b000; // no se usa
                RUDataWrSrc = 2'b10;
            end
            7'b1100111: begin // instrucciones tipo JALR
                AluBSrc = 1;
                RuWr = 1;
                ImmSrc = 3'b110;
                ALUOp = 4'b000;
                BrOp = 5'b10000;
                DMWr = 0;
                DMCtrl = 3'b000; // no se usa
                RUDataWrSrc = 2'b10;
            end
    endcase
end

endmodule
