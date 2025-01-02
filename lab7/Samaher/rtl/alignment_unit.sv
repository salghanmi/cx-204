`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2024 06:04:42 PM
// Design Name: 
// Module Name: alignment_unit
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 11:05:45 AM
// Design Name: 
// Module Name: alignment_unit
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


module alignment_unit(
    input logic  clk,
    input logic reset_n,
    input logic mem_write,
    input logic [31:0] addr,
    input logic [2:0] funct3,
    output logic [3:0] wsel,
    output logic W, 
    output logic HW, 
    output logic unsign   
     );
     
     //reg B,HW,W,sign;
    
  
    always_comb  begin 
    
       HW=funct3[0];
       W=funct3[1];
       unsign=~funct3[2]; // if 1 = unsigned 
       
        if(funct3[1])
        wsel = 4'b1111;
         else begin 
         if(funct3[2]&funct3[0]) //unsigned half word 101
         wsel =(addr[1])? 4'b1100:4'b0011;
         if(funct3[2]&~funct3[0]) //unsigned byte
        case(addr[1:0])
         00:begin
         wsel = 4'b0001;
         end 
         01:begin
         wsel = 4'b0010;
         end 
         10:begin
         wsel = 4'b0100;
         end
         11:begin
         wsel = 4'b1000;
         end 
        default: 
        wsel = 4'b0000;
         endcase
        end
    end 
endmodule
 // if (mem_write) begin
     //assign wsel = addr[1:0]; 
//    case(funct3)
//    000: begin 
//    HW=0;
//    W=0; 
//    sign=1;
//    end 
//    001: begin 
//    HW=1;
//    W=0; 
//    sign=1;
//    end 
//    010: begin
//    HW=0;
//    W=1; 
//    sign=0;
//    wsel = 4'b1111;
//    end 
//    100:begin 
//    HW=0;
//    W=0; 
//    sign=0;
//    end 
//    101: begin 
//    HW=1;
//    W=0; 
//    sign=0;
//    end 
//    default: begin 
//    W=0; 
//    sign=0;
//    HW=0;
//    end 
//    endcase
