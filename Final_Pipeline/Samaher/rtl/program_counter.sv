`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module program_counter#
(parameter WIDTH=32 )
(
    input logic reset_n, 
    input logic clk,
    input logic [WIDTH-1:0] data_in, 
    output logic [WIDTH-1:0] data_o
    );
    
    always_ff @ (posedge clk, negedge reset_n)begin 
    if(!reset_n)
    data_o <= 0; 
    else  
    data_o <= data_in;
    end 
endmodule