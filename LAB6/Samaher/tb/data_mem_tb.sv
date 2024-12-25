`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 01:49:16 PM
// Design Name: 
// Module Name: data_mem_tb
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


module data_mem_tb; 
    logic clk;                     
    logic reset_n;                  
    logic [31:0] address;           
    logic [31:0] data_in;           
    logic Wen;                     
    logic [31:0] data_out;  

    data_mem #(     
        .WIDTH(32),   
        .DEPTH(1024)    
    ) dut (
        .clk(clk),
        .reset_n(reset_n),
        .addr(address),
        .wdata(data_in),
        .mem_write(Wen),
        .rdata(data_out)
    );
  initial begin
    clk = 0; 
    forever #5 clk = ~clk; 
end
initial begin
    
   reset_n = 0; #10;
   reset_n = 1; 
     //read
     Wen = 0;
     address = 32'b000;#10;
     address = 32'b001;#10;
     
 // Write
    Wen = 1;
    address = 32'b010; data_in = 32'b10101010; #10;
    address = 32'b011; data_in = 32'b11001100; #10;
    address = 32'b100; data_in = 32'b11110000; #10;
     $finish;
     end
     
endmodule