`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module control_unit(
    input logic [6:0] opcode, 
    input logic fun7_5,
    input logic [2:0] fun3,
    input logic zero, 
    input logic less, 
    output logic pc_sel,
    output logic reg_write, 
    output logic mem_write, 
    output logic mem_to_reg, 
    output logic alu_src, 
    output logic branch , jump ,output logic uilu,
    output logic [3:0] alu_ctrl);

logic [1:0] alu_op;

 main_control main_control_inst(
    .opcode(opcode), 
    .branch(branch), 
    .mem_write(mem_write), 
    .mem_to_reg(mem_to_reg), 
    .alu_src(alu_src), 
    .alu_op(alu_op),
    .reg_write(reg_write), .jump(jump), .uilu(uilu)
); 

alu_control alu_cont_int(
    .alu_op(alu_op),          // ALU operation from Main Control
    .func3(fun3),           // Instruction field func3
    .func7_5(fun3),               // 5th bit of func7
    .alu_ctrl(alu_ctrl)        // ALU control signal
);



 branch_controller branch_cont_inst(
    .fun3(fun3),           // Instruction field func3
    .zero(zero), 
    .branch(branch), 
    .less(less), 
    .pc_sel(pc_sel), 
    .jump(jump)
    );
    
endmodule 