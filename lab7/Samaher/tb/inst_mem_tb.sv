`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 12:24:51 PM
// Design Name: 
// Module Name: inst_mem_tb
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


module inst_mem_tb;
logic [31:0] address,instruction;
inst_mem
dut
(
    address, 
   instruction 
);

initial begin 
address=0;#10
address=1;#10
address=2;#10
address=3;#10
address=4;#10
address=5;#10
address=6;#10
$finish;
end 
endmodule