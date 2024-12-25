`timescale 1ns / 1ps

module alu_control_tb;

    // Testbench signals
    logic [1:0] alu_op;
    logic [2:0] func3;
    logic func7_5;
    logic [3:0] alu_ctrl;

    // Instantiate the DUT (Device Under Test)
    alu_control dut (
        .alu_op(alu_op),
        .func3(func3),
        .func7_5(func7_5),
        .alu_ctrl(alu_ctrl)
    );

    // Test sequence
    initial begin
        // Test Case 1: R-type ADD (alu_op = 2'b10, func3 = 3'b000, func7_5 = 0)
        alu_op = 2'b10; func3 = 3'b000; func7_5 = 1'b0; #10;
        $display("Test Case 1: R-type ADD: alu_op = %b, func3 = %b, func7_5 = %b, alu_ctrl = %b", alu_op, func3, func7_5, alu_ctrl);

        // Test Case 2: R-type SUB (alu_op = 2'b10, func3 = 3'b000, func7_5 = 1)
        alu_op = 2'b10; func3 = 3'b000; func7_5 = 1'b1; #10;
        $display("Test Case 2: R-type SUB: alu_op = %b, func3 = %b, func7_5 = %b, alu_ctrl = %b", alu_op, func3, func7_5, alu_ctrl);

        // Test Case 3: I-type ADDI (alu_op = 2'b11, func3 = 3'b000)
        alu_op = 2'b11; func3 = 3'b000; func7_5 = 1'b0; #10;
        $display("Test Case 3: I-type ADDI: alu_op = %b, func3 = %b, func7_5 = %b, alu_ctrl = %b", alu_op, func3, func7_5, alu_ctrl);

        // Test Case 4: Branch BEQ (alu_op = 2'b01, func3 = 3'b000)
        alu_op = 2'b01; func3 = 3'b000; func7_5 = 1'b0; #10;
        $display("Test Case 4: Branch BEQ: alu_op = %b, func3 = %b, func7_5 = %b, alu_ctrl = %b", alu_op, func3, func7_5, alu_ctrl);

        // Test Case 5: Branch BLT (alu_op = 2'b01, func3 = 3'b100)
        alu_op = 2'b01; func3 = 3'b100; func7_5 = 1'b0; #10;
        $display("Test Case 5: Branch BLT: alu_op = %b, func3 = %b, func7_5 = %b, alu_ctrl = %b", alu_op, func3, func7_5, alu_ctrl);

        // Test Case 6: Load/Store ADD (alu_op = 2'b00)
        alu_op = 2'b00; func3 = 3'b000; func7_5 = 1'b0; #10;
        $display("Test Case 6: Load/Store ADD: alu_op = %b, func3 = %b, func7_5 = %b, alu_ctrl = %b", alu_op, func3, func7_5, alu_ctrl);

        // Finish simulation
        $finish;
    end

endmodule
