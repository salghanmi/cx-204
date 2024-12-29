`timescale 1ns / 1ps
//////////////////
module inst_mem(
    input  [31:0] address,
    output [31:0] instruction
    );
    logic [31:0] memory [0:255]; 

    initial begin
       $readmemh("/home/it/Samaher/memo.hex", memory); // For Binary File 
         
    end
    assign instruction = memory[address[31:2]]; // Out instruction 
endmodule