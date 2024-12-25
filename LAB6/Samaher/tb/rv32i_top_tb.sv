
`timescale 1ns / 1ps

module rv32i_top_tb;

    // Testbench signals
    logic clk;
    logic reset_n;

    // Instantiate the rv32i_top module
    rv32i_top uut (
        .clk(clk),
        .reset_n(reset_n)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        reset_n = 0;

        // Apply reset
        #10 reset_n = 1;

//        // Test Case 1: R-type ADD (opcode = 7'b0110011, func3 = 3'b000, func7_5 = 0)
//        #10 uut.DP_inst.opcode = 7'b0110011;
//            uut.DP_inst.fun3 = 3'b000;
//            uut.DP_inst.fun7_5 = 1'b0;
//        #10;

//        // Test Case 2: I-type ADDI (opcode = 7'b0010011, func3 = 3'b000)
//        #10 uut.DP_inst.opcode = 7'b0010011;
//            uut.DP_inst.fun3 = 3'b000;
//            uut.DP_inst.fun7_5 = 1'b0;
//        #10;

//        // Test Case 3: BEQ (opcode = 7'b1100011, func3 = 3'b000)
//        #10 uut.DP_inst.opcode = 7'b1100011;
//            uut.DP_inst.fun3 = 3'b000;
//            uut.DP_inst.fun7_5 = 1'b0;
//        #10;

//        // Test Case 4: Load (opcode = 7'b0000011, func3 = 3'b010)
//        #10 uut.DP_inst.opcode = 7'b0000011;
//            uut.DP_inst.fun3 = 3'b010;
//            uut.DP_inst.fun7_5 = 1'b0;
//        #10;

//        // Test Case 5: Store (opcode = 7'b0100011, func3 = 3'b010)
//        #10 uut.DP_inst.opcode = 7'b0100011;
//            uut.DP_inst.fun3 = 3'b010;
//            uut.DP_inst.fun7_5 = 1'b0;
//        #10;

        // Finish simulation
        #100 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor($time, " clk=%b reset_n=%b opcode=%b fun3=%b fun7_5=%b alu_ctrl=%b reg_write=%b mem_write=%b mem_to_reg=%b alu_src=%b branch=%b",
                 clk, reset_n, uut.DP_inst.opcode, uut.DP_inst.fun3, uut.DP_inst.fun7_5, uut.Cont_unit_inst.alu_ctrl,
                 uut.Cont_unit_inst.reg_write, uut.DP_inst.mem_write, uut.DP_inst.mem_to_reg,
                 uut.DP_inst.alu_src, uut.DP_inst.branch);
    end

endmodule
