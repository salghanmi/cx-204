`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module MEM_WB_REG (
    input logic clk, 
    input logic reset_n, 
    input logic [31:0] alu_result_in, 
    input logic [31:0] read_data_in,
    input logic [31:0] imm_in,
    input logic [31:0] pc_plus_4_in,
    input logic reg_write_in, 
    input logic mem_to_reg_in, 
    input logic jump_in, 
    input logic uilu_in,
    
    output logic [31:0] alu_result_out, 
    output logic [31:0] read_data_out,
    output logic [31:0] imm_out,
    output logic [31:0] pc_plus_4_out,
    output logic reg_write_out, 
    output logic mem_to_reg_out, 
    output logic jump_out, 
    output logic uilu_out, 
    input logic [4:0] write_reg_in, 
    output logic [4:0] write_reg_out
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            alu_result_out <= 32'b0;
            read_data_out <= 32'b0;
            imm_out <= 32'b0;
            pc_plus_4_out <= 32'b0;
            reg_write_out <= 1'b0;
            mem_to_reg_out <= 1'b0;
            jump_out <= 1'b0;
            uilu_out <= 1'b0;
            write_reg_out <= 5'b0; 
        end else begin
            alu_result_out <= alu_result_in;
            read_data_out <= read_data_in;
            imm_out <= imm_in;
            pc_plus_4_out <= pc_plus_4_in;
            reg_write_out <= reg_write_in;
            mem_to_reg_out <= mem_to_reg_in;
            jump_out <= jump_in;
            uilu_out <= uilu_in;
                        write_reg_out <= write_reg_in;
        end
    end
endmodule

