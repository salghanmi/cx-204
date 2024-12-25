`timescale 1ns / 1ps

module main_control_tb;

    // Testbench signals
    logic [6:0] opcode;
    logic branch, mem_write, mem_to_reg, alu_src, reg_write, jump;
    logic [1:0] alu_op;

    // Instantiate the DUT (Device Under Test)
    main_control dut (
        .opcode(opcode),
        .branch(branch),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .reg_write(reg_write),
        .jump(jump)
    );

    // Test sequence
    initial begin
        // Test Case 1: R-type (opcode = 7'b0110011)
        opcode = 7'b0110011; #10;
        $display("Test Case 1: R-type: opcode = %b, branch = %b, mem_write = %b, mem_to_reg = %b, alu_src = %b, alu_op = %b, reg_write = %b, jump = %b", 
                 opcode, branch, mem_write, mem_to_reg, alu_src, alu_op, reg_write, jump);

        // Test Case 2: I-type (opcode = 7'b0010011)
        opcode = 7'b0010011; #10;
        $display("Test Case 2: I-type: opcode = %b, branch = %b, mem_write = %b, mem_to_reg = %b, alu_src = %b, alu_op = %b, reg_write = %b, jump = %b", 
                 opcode, branch, mem_write, mem_to_reg, alu_src, alu_op, reg_write, jump);

        // Test Case 3: Load (opcode = 7'b0000011)
        opcode = 7'b0000011; #10;
        $display("Test Case 3: Load: opcode = %b, branch = %b, mem_write = %b, mem_to_reg = %b, alu_src = %b, alu_op = %b, reg_write = %b, jump = %b", 
                 opcode, branch, mem_write, mem_to_reg, alu_src, alu_op, reg_write, jump);

        // Test Case 4: Store (opcode = 7'b0100011)
        opcode = 7'b0100011; #10;
        $display("Test Case 4: Store: opcode = %b, branch = %b, mem_write = %b, mem_to_reg = %b, alu_src = %b, alu_op = %b, reg_write = %b, jump = %b", 
                 opcode, branch, mem_write, mem_to_reg, alu_src, alu_op, reg_write, jump);

        // Test Case 5: BEQ (opcode = 7'b1100011)
        opcode = 7'b1100011; #10;
        $display("Test Case 5: BEQ: opcode = %b, branch = %b, mem_write = %b, mem_to_reg = %b, alu_src = %b, alu_op = %b, reg_write = %b, jump = %b", 
                 opcode, branch, mem_write, mem_to_reg, alu_src, alu_op, reg_write, jump);

        // Test Case 6: Jump (opcode = 7'b1100111)
        opcode = 7'b1100111; #10;
        $display("Test Case 6: Jump: opcode = %b, branch = %b, mem_write = %b, mem_to_reg = %b, alu_src = %b, alu_op = %b, reg_write = %b, jump = %b", 
                 opcode, branch, mem_write, mem_to_reg, alu_src, alu_op, reg_write, jump);

        // Test Case 7: Default (unknown opcode)
        opcode = 7'b1111111; #10;
        $display("Test Case 7: Default: opcode = %b, branch = %b, mem_write = %b, mem_to_reg = %b, alu_src = %b, alu_op = %b, reg_write = %b, jump = %b", 
                 opcode, branch, mem_write, mem_to_reg, alu_src, alu_op, reg_write, jump);

        // Finish simulation
        $finish;
    end

endmodule
