`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module rv32i_top(
    input logic clk, 
    input logic reset_n 
    );

    logic reg_write , mem_write, alu_src, mem_to_reg, branch, zero, less , pc_sel; 
    logic [3:0] alu_ctrl;
    logic [6:0] opcode; 
    logic fun7_5, jump, uilu;
    logic [2:0] fun3; 
    
    

    
 control_unit Cont_unit_inst( 
    .opcode(opcode), 
    .fun7_5(fun7_5),
    .fun3(fun3), 
    .zero(zero), 
    .less(less),
    .pc_sel(pc_sel),
    .reg_write(reg_write), 
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg), 
    .alu_src(alu_src), 
    .branch(branch),
    .alu_ctrl(alu_ctrl), .jump(jump), .uilu(uilu)
);
    

 data_path#(
    .WIDTH(32))DP_inst(
    .clk(clk), 
    .reset_n(reset_n), 
    .reg_write(reg_write), 
    .alu_src(alu_src), 
    .alu_ctrl(alu_ctrl),
    .mem_write(mem_write), 
    .mem_to_reg(mem_to_reg), 
    .branch(branch),
    .pc_sel(pc_sel),
    .opcode(opcode), 
    .fun7_5(fun7_5), 
    .fun3(fun3) , .zero(zero), .less(less), .jump(jump), .uilu(uilu)
    
    );

endmodule 