`timescale 1ns / 1ps
//////////////////
module imm_gen(

    input logic [31:0] inst, 
    output logic [31:0] imm

);

always_comb begin 
    imm=0;
    
    if(~inst[5])//i type 
    begin 
    imm[11:0]= inst[31:20];
    imm[31:12]=imm[11];//sign extention msb
    end 
    else
        begin
        imm[4:1]= inst[11:8];
        imm[10:5]=inst[30:25];
        imm[11]=inst[7];
        imm[12]=inst[31];
        end 
    end 

endmodule