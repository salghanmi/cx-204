`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 11:44:48 AM
// Design Name: 
// Module Name: data_path
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_path#(
    parameter WIDTH=32)(
    input logic clk, 
    input logic reset_n, 
    input logic reg_write, 
    input logic alu_src, 
    input logic [3:0] alu_ctrl,
    input logic  mem_write, 
    input logic mem_to_reg, jump, 
    input logic branch, 
    input logic pc_sel, input logic uilu,  
    output logic [6:0] opcode, 
    output logic fun7_5, 
    output logic [2:0] fun3 , 
    output logic zero, less 
    );
    
    logic [WIDTH-1: 0] next_pc, current_pc, inst,reg_wdata_2, reg_rdata2, reg_rdata1, reg_wdata, imm,alu_op2,alu_result,mem_rdata, pc_plus_4;
;
    logic [4:0] rs1, rs2,rd; 
//    logic zero;
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd = inst[11:7];
    assign opcode = inst[6:0];
    assign fun7_5 = inst[29];
    assign fun3 = inst[14:12];
    // ============ Program Counter 
    program_counter#(.WIDTH(WIDTH))pc_inst(
    .clk(clk),
    .reset_n(reset_n),
    .data_in(next_pc),
    .data_o(current_pc)
    );
    
    // ========== Instruction Memory 
    
    inst_mem inst_Mem_inst(
    .address(current_pc),
    .instruction(inst)
    );
    
    
    // =========Reg_ file 
    
     reg_file reg_file_inst(
    .reset_n(reset_n), 
    .clk(clk), 
    .reg_write(reg_write), // Write enable signal 
    .raddr1(rs1), 
    .raddr2(rs2), 
    .waddr(rd), 
    .wdata(reg_wdata), 
    .rdata1(reg_rdata1), 
    .rdata2(reg_rdata2) );
    
    //============= IMM 
     imm_gen imm_inst(
     .inst(inst), 
    .imm(imm));
    
    //============ Mux before the alu 
    
    assign alu_op2 = alu_src? imm : reg_rdata2;
    
    // ============ ALU
    
 alu#(.WIDTH(32)) alu_inst(
    .reset_n(reset_n), 
    .op1(reg_rdata1), .op2(alu_op2), 
    .alu_ctrl(alu_ctrl), 
    .alu_result(alu_result), 
    .zero(zero),
    .less(less)
      );
    
    //=========== Data memory 
     data_mem #(
    .DEPTH(1024),  
    .WIDTH(32) 
  )data_mem_inst(
    .clk(clk),
    .reset_n(reset_n),
    .mem_write(mem_write),
    .addr(alu_result),
    .wdata(reg_rdata2), 
    .funct3(fun3), 
    .rdata(mem_rdata)
    );
    

    
    //==============
    assign reg_wdata_2= mem_to_reg? mem_rdata : alu_result;//mux 1
    // logic reg_wdata__3  ;
     logic [31:0] pc_jump,reg_wdata__3;
    assign pc_jump = imm + current_pc; 
    assign pc_plus_4 = current_pc +4; 
    assign next_pc = pc_sel? pc_jump : pc_plus_4;
    assign reg_wdata__3 = jump ? (current_pc+4) : reg_wdata_2; //mux 2
    assign reg_wdata = uilu ? imm : reg_wdata__3; //mux 3
    
endmodule
