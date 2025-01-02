`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module ID_EX_REG (
    input logic clk, 
    input logic reset_n, 
    input logic [31:0] pc_in, 
    input logic [31:0] imm_in,
    input logic [31:0] read_data_1_in, 
    input logic [31:0] read_data_2_in,
    input logic [31:0] pc_plus_4_in,
    input logic [3:0] alu_op_in,
    input logic [2:0] fun3_in,
    input logic func7_5_in,
    input logic jump_in,
    input logic uilu_in,
    input logic reg_write_in, 
    input logic branch_in, 
    input logic mem_write_in, 
    input logic alu_src_in, 
    input logic mem_to_reg_in,
    input logic [4:0] write_reg_in,
    input logic [4:0]rs1_in,
    input logic [4:0]rs2_in,
    input logic do_branch, 
    
    output logic [31:0] pc_out, 
    output logic [31:0] imm_out,
    output logic [31:0] read_data_1_out, 
    output logic [31:0] read_data_2_out,
    output logic [31:0] pc_plus_4_out,
    output logic [3:0] alu_op_out,
    output logic [2:0] fun3_out,
    output logic func7_5_out,
    output logic jump_out,
    output logic uilu_out,
    output logic reg_write_out, 
    output logic branch_out, 
    output logic mem_write_out, 
    output logic alu_src_out, 
    output logic mem_to_reg_out,
    output logic [4:0] write_reg_out,
    output logic [4:0] rs1_out,  
    output logic [4:0] rs2_out
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n | do_branch ) begin
            pc_out <= 32'b0;
            imm_out <= 32'b0;
            read_data_1_out <= 32'b0;
            read_data_2_out <= 32'b0;
            pc_plus_4_out <= 32'b0;
            alu_op_out <= 4'b0;
            fun3_out <= 3'b0;
            func7_5_out <= 1'b0;
            jump_out <= 1'b0;
            uilu_out <= 1'b0;
            reg_write_out <= 1'b0;
            branch_out <= 1'b0;
            mem_write_out <= 1'b0;
            alu_src_out <= 1'b0;
            mem_to_reg_out <= 1'b0;
            write_reg_out <= 5'b0;
            rs1_out<=5'b0;
            rs2_out<=5'b0;
        end else begin
            pc_out <= pc_in;
            imm_out <= imm_in;
            read_data_1_out <= read_data_1_in;
            read_data_2_out <= read_data_2_in;
            pc_plus_4_out <= pc_plus_4_in;
            alu_op_out <= alu_op_in;
            fun3_out <= fun3_in;
            func7_5_out <= func7_5_in;
            jump_out <= jump_in;
            uilu_out <= uilu_in;
            reg_write_out <= reg_write_in;
            branch_out <= branch_in;
            mem_write_out <= mem_write_in;
            alu_src_out <= alu_src_in;
            mem_to_reg_out <= mem_to_reg_in;
            write_reg_out <= write_reg_in;
            rs1_out<=rs1_in;
            rs2_out<=rs2_in;
        end
    end
endmodule