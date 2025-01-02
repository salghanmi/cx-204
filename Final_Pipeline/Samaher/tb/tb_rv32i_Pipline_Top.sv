`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2024 03:45:53 PM
// Design Name: 
// Module Name: tb_rv32i_Pipline_Top
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


module tb_rv32i_Pipline_Top;

    // Testbench signals
    logic clk;
    logic reset_n;

    // Instantiate the rv32i_top module
    rv32i_Pipline_top#(.WIDTH(32)) uut (
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
        #2 reset_n = 1;


        // Finish simulation
        #100 $finish;
    end

endmodule

