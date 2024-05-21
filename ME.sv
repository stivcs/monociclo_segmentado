`include "modulos/DataMemory.sv"

module ME(
    input logic [31:0] alu_out_me,
    input logic [31:0] ru2_me,
    input logic DMWr_me,
    input logic [2:0] DMCtrl_me,
    output logic [31:0] DataRd_me
);

    DataMemory data_mem(
        .Address(alu_out_me),
        .DataWr(ru2_me),
        .DMWr(DMWr_me),
        .DMCtrl(DMCtrl_me),
        .DataRd(DataRd_me)
    );


endmodule