`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////



module alu_tb;
    // Parameters
    parameter WIDTH = 32;

    // Testbench Signals
    logic reset_n;
    logic [WIDTH-1:0] op1, op2;
    logic [3:0] alu_ctrl;
    logic [WIDTH-1:0] alu_result;
    logic zero;

    // Instantiate the ALU module
    alu #(WIDTH) uut (
        .reset_n(reset_n),
        .op1(op1),
        .op2(op2),
        .alu_ctrl(alu_ctrl),
        .alu_result(alu_result),
        .zero(zero)
    );

    // Testbench Procedure
    initial begin
        // Initialize signals
        reset_n = 0;
        op1 = 0;
        op2 = 0;
        alu_ctrl = 4'b0000;

        // Reset the ALU
        #10 reset_n = 1;

        // Test ADD operation
        #10 op1 = 32'h0000_000A; op2 = 32'h0000_0005; alu_ctrl = 4'b0000;
        #10 $display("ADD: alu_result=%h, zero=%b", alu_result, zero);

        // Test SUB operation
        #10 op1 = 32'h0000_000A; op2 = 32'h0000_000A; alu_ctrl = 4'b1000;
        #10 $display("SUB: alu_result=%h, zero=%b", alu_result, zero);

        // Test AND operation
        #10 op1 = 32'h0000_FFFF; op2 = 32'h0F0F_0F0F; alu_ctrl = 4'b0111;
        #10 $display("AND: alu_result=%h, zero=%b", alu_result, zero);

        // Test OR operation
        #10 op1 = 32'h0000_FFFF; op2 = 32'hFFFF_0000; alu_ctrl = 4'b0110;
        #10 $display("OR: alu_result=%h, zero=%b", alu_result, zero);

        // Test XOR operation
        #10 op1 = 32'hAAAA_AAAA; op2 = 32'h5555_5555; alu_ctrl = 4'b0100;
        #10 $display("XOR: alu_result=%h, zero=%b", alu_result, zero);

        // Test SLL operation
        #10 op1 = 32'h0000_0001; op2 = 32'h0000_0008; alu_ctrl = 4'b0001;
        #10 $display("SLL: alu_result=%h, zero=%b", alu_result, zero);

        // Test SRL operation
        #10 op1 = 32'h0000_F000; op2 = 32'h0000_0004; alu_ctrl = 4'b0101;
        #10 $display("SRL: alu_result=%h, zero=%b", alu_result, zero);

        // Test SRA operation
        #10 op1 = 32'h8000_0000; op2 = 32'h0000_0004; alu_ctrl = 4'b1101;
        #10 $display("SRA: alu_result=%h, zero=%b", alu_result, zero);

        // Test SLT operation
        #10 op1 = 32'h0000_0005; op2 = 32'h0000_000A; alu_ctrl = 4'b0010;
        #10 $display("SLT: alu_result=%h, zero=%b", alu_result, zero);

        // Test SLTU operation
        #10 op1 = 32'h0000_0005; op2 = 32'hFFFF_FFFF; alu_ctrl = 4'b0011;
        #10 $display("SLTU: alu_result=%h, zero=%b", alu_result, zero);

        // Finish simulation
        #10 $finish;
    end

    // Monitor ALU output
    initial begin
        $monitor($time, " op1=%h, op2=%h, alu_ctrl=%b, alu_result=%h, zero=%b", 
                 op1, op2, alu_ctrl, alu_result, zero);
    end

endmodule
