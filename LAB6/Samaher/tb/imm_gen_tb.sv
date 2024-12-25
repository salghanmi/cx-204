`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 02:54:57 PM
// Design Name: 
// Module Name: imm_gen_tb
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


module imm_gen_tb;

      logic [31:0] inst;
      logic [31:0] imm;
imm_gen dut(

   inst, 
     imm

);
initial begin
    
    inst = 32'hF0A00293;#10
    inst = 32'h00C00D93;#10
    inst = 32'hFFC00263;#10
     $finish;
     end
endmodule