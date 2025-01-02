`timescale 1ns / 1ps

module control_unit_tb;

    // Testbench signals
    logic [6:0] opcode;
    logic fun7_5;
    logic [2:0] fun3;
    logic zero, less;
    logic pc_sel;
    logic reg_write, mem_write, mem_to_reg, alu_src, branch, jump;
    logic [3:0] alu_ctrl;

    // Instantiate the DUT (Device Under Test)
    control_unit dut (
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
        .jump(jump),
        .alu_ctrl(alu_ctrl)
    );

    // Test sequence
    initial begin
        // Test Case 1: R-type ADD (opcode = 7'b0110011, fun3 = 3'b000, fun7_5 = 0)
        opcode = 7'b0110011; fun3 = 3'b000; fun7_5 = 1'b0; zero = 0; less = 0; #10;
        $display("Test Case 1: R-type ADD: opcode = %b, fun3 = %b, fun7_5 = %b, pc_sel = %b, reg_write = %b, alu_ctrl = %b", opcode, fun3, fun7_5, pc_sel, reg_write, alu_ctrl);

        // Test Case 2: I-type ADDI (opcode = 7'b0010011, fun3 = 3'b000)
        opcode = 7'b0010011; fun3 = 3'b000; fun7_5 = 1'b0; zero = 0; less = 0; #10;
        $display("Test Case 2: I-type ADDI: opcode = %b, fun3 = %b, fun7_5 = %b, pc_sel = %b, reg_write = %b, alu_ctrl = %b", opcode, fun3, fun7_5, pc_sel, reg_write, alu_ctrl);

        // Test Case 3: Branch BEQ (opcode = 7'b1100011, fun3 = 3'b000, zero = 1)
        opcode = 7'b1100011; fun3 = 3'b000; fun7_5 = 1'b0; zero = 1; less = 0; #10;
        $display("Test Case 3: Branch BEQ: opcode = %b, fun3 = %b, fun7_5 = %b, pc_sel = %b, reg_write = %b, alu_ctrl = %b", opcode, fun3, fun7_5, pc_sel, reg_write, alu_ctrl);

        // Test Case 4: Branch BLT (opcode = 7'b1100011, fun3 = 3'b100, less = 1)
        opcode = 7'b1100011; fun3 = 3'b100; fun7_5 = 1'b0; zero = 0; less = 1; #10;
        $display("Test Case 4: Branch BLT: opcode = %b, fun3 = %b, fun7_5 = %b, pc_sel = %b, reg_write = %b, alu_ctrl = %b", opcode, fun3, fun7_5, pc_sel, reg_write, alu_ctrl);

        // Test Case 5: Load (opcode = 7'b0000011, fun3 = 3'b010)
        opcode = 7'b0000011; fun3 = 3'b010; fun7_5 = 1'b0; zero = 0; less = 0; #10;
        $display("Test Case 5: Load: opcode = %b, fun3 = %b, fun7_5 = %b, pc_sel = %b, reg_write = %b, alu_ctrl = %b", opcode, fun3, fun7_5, pc_sel, reg_write, alu_ctrl);

        // Test Case 6: Store (opcode = 7'b0100011, fun3 = 3'b010)
        opcode = 7'b0100011; fun3 = 3'b010; fun7_5 = 1'b0; zero = 0; less = 0; #10;
        $display("Test Case 6: Store: opcode = %b, fun3 = %b, fun7_5 = %b, pc_sel = %b, reg_write = %b, alu_ctrl = %b", opcode, fun3, fun7_5, pc_sel, reg_write, alu_ctrl);

        // Finish simulation
        $finish;
    end

endmodule
