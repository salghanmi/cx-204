`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module IF_ID_REG (
    input logic clk, 
    input logic reset_n, 
    input logic IF_IDWrite, 
    input logic [31:0] pc_in, 
    input logic [31:0] instruction_in,
    input logic [31:0] pc_plus_4_in,
    input logic do_branch, 
    output logic [31:0] pc_out, 
    output logic [31:0] instruction_out,
    output logic [31:0] pc_plus_4_out
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n ) begin
            pc_out <= 32'b0;
            instruction_out <= 32'b0;
            pc_plus_4_out <= 32'b0;
        end else begin
        if(IF_IDWrite )begin 
            pc_out <= pc_in;
            instruction_out <= instruction_in;
            pc_plus_4_out <= pc_plus_4_in;
            end 
        end
    end
endmodule
