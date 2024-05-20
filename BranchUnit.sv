module branchunit(A,B,BrOp,NextPCSrc);
    input logic [31:0] A, B; //Bus de datos de 32 bits
    input logic [4:0] BrOp; //Bus de control de 4 bits
    output logic  NextPCSrc; //Bus de salida de 2 bits

    always @* begin
        if (BrOp[4] == 1'b1)
            NextPCSrc = 1;
        else if (BrOp[3] == 1'b0)
            NextPCSrc = 0;
        else if (BrOp == 5'b01000) begin
            if (A == B)
                NextPCSrc = 1;
            else
                NextPCSrc = 0;
        end
        else if (BrOp == 5'b01001) begin
            if (A != B)
                NextPCSrc = 1;
            else
                NextPCSrc = 0;
        end
        else if (BrOp == 5'b01100) begin
            if (A < B)
                NextPCSrc = 1;
            else
                NextPCSrc = 0;
        end
        else if (BrOp == 5'b01101) begin
            if (A >= B)
                NextPCSrc = 1;
            else
                NextPCSrc = 0;
        end
        else if (BrOp == 5'b01110) begin
            if ($unsigned(A) < $unsigned(B))
                NextPCSrc = 1;
            else
                NextPCSrc = 0;
        end
        else if (BrOp == 5'b01111) begin
            if ($unsigned(A) >= $unsigned(B))
                NextPCSrc = 1;
            else
                NextPCSrc = 0;
        end
    end
    
endmodule