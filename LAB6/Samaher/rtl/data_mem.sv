`timescale 1ns / 1ps
//////////////////

module data_mem #(
    parameter DEPTH = 1024,  
    parameter WIDTH=32 
  )(
    input clk,
    input reset_n,
    input mem_write,
    input [31:0] addr,
    input [31:0] wdata, 
    output [31:0] rdata
    );
    
    logic [WIDTH -1:0] dmem [0:DEPTH-1];
    always @(posedge clk, negedge reset_n) 
    begin
        if (!reset_n) 
        begin   
            integer i;
            for (i = 0; i < DEPTH; i = i + 1) 
            begin
                dmem[i] <= {WIDTH{1'b0}};  //Each location in memory is  filled 0
            end
         end 
        
            else 
            begin 
                if (mem_write) 
                begin
                    dmem[addr] <= wdata; // Write
                end
            end
     end 
        
       
       assign rdata = dmem[addr]; // Read
       
  
    
endmodule