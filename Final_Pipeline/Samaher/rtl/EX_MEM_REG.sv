`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module EX_MEM_REG (
    input logic clk, 
    input logic reset_n, 
    input logic [31:0] pc_in,
    input logic [31:0] alu_result_in, 
    input logic [31:0] write_data_in,
    input logic [31:0] imm_in,
    input logic [31:0] pc_plus_4_in,
    input logic zero_in,
    input logic less_in,
    input logic jump_in,
    input logic uilu_in,
    input logic reg_write_in, 
    input logic branch_in, 
    input logic mem_write_in, 
    input logic mem_to_reg_in,
    input logic [2:0] fun3_in,
    input logic do_branch , 
    
    output logic [31:0] pc_out,
    output logic [31:0] alu_result_out, 
    output logic [31:0] write_data_out,
    output logic [31:0] imm_out,
    output logic [31:0] pc_plus_4_out,
    output logic zero_out,
    output logic less_out,
    output logic jump_out,
    output logic uilu_out,
    output logic reg_write_out, 
    output logic branch_out, 
    output logic mem_write_out, 
    output logic mem_to_reg_out,
    output logic [2:0] fun3_out,
        input logic [4:0] write_reg_in, 
    output logic [4:0] write_reg_out
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n | do_branch ) begin
            pc_out <= 32'b0;
            alu_result_out <= 32'b0;
            write_data_out <= 32'b0;
            imm_out <= 32'b0;
            pc_plus_4_out <= 32'b0;
            zero_out <= 1'b0;
            less_out <= 1'b0;
            jump_out <= 1'b0;
            uilu_out <= 1'b0;
            reg_write_out <= 1'b0;
            branch_out <= 1'b0;
            mem_write_out <= 1'b0;
            mem_to_reg_out <= 1'b0;
            fun3_out <= 3'b0; 
                                    write_reg_out <= 5'b0;
        end else begin
            pc_out <= pc_in;
            alu_result_out <= alu_result_in;
            write_data_out <= write_data_in;
            imm_out <= imm_in;
            pc_plus_4_out <= pc_plus_4_in;
            zero_out <= zero_in;
            less_out <= less_in;
            jump_out <= jump_in;
            uilu_out <= uilu_in;
            reg_write_out <= reg_write_in;
            branch_out <= branch_in;
            mem_write_out <= mem_write_in;
            mem_to_reg_out <= mem_to_reg_in;
            fun3_out <= fun3_in;
           write_reg_out <= write_reg_in;
        end
    end
endmodule

