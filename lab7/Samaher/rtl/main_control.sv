`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module main_control(
    input logic [6:0] opcode, 
    output logic branch, 
    output logic mem_write, 
    output logic mem_to_reg, 
    output logic alu_src, 
    output logic [1:0] alu_op,
    output logic reg_write,
    output logic jump ,
    output logic uilu
); 

always @(*) begin 
        case (opcode)
            7'b0110011: begin    // R-type 
                reg_write = 1'b1;
                mem_write = 1'b0; 
                mem_to_reg = 1'b0;
                alu_op = 2'b10;
                alu_src = 1'b0;
                branch = 1'b0; 
                jump= 1'b0;
                uilu= 1'b0; 
            end  
            7'b0010011: begin    // I-type 
                reg_write = 1'b1;
                mem_write = 1'b0; 
                mem_to_reg = 1'b0;
                alu_op = 2'b11;
                alu_src = 1'b1;
                branch = 1'b0; 
                jump=1'b0;  
               uilu= 1'b0; 

            end  
            7'b0000011: begin    // Load 
                reg_write = 1'b1;
                mem_write = 1'b0; 
                mem_to_reg = 1'b1;
                alu_op = 2'b00;
                alu_src = 1'b1;
                branch = 1'b0;                 
                jump=1'b0; 
                                uilu= 1'b0; 
 
            end  
            7'b0100011: begin    // Store 
                reg_write = 1'b0;
                mem_write = 1'b1; 
                mem_to_reg = 1'bx;
                alu_op = 2'b00;
                alu_src = 1'b1;
                branch = 1'b0; 
                jump=1'b0;  
                                uilu= 1'b0; 

            end  
            7'b1100011: begin    // BEQ
                reg_write = 1'b0;
                mem_write = 1'b0; 
                mem_to_reg = 1'bx;
                alu_op = 2'b01;
                alu_src = 1'b0;
                branch = 1'b1;
                jump=1'b0;  
                                uilu= 1'b0; 

            end  
            7'b1100111: begin    // ===============Jump (JALR)
                reg_write = 1'b1;
                mem_write = 1'b0; 
                mem_to_reg = 1'b1;
                alu_op = 2'b00;
                alu_src = 1'b0;
                branch = 1'b0; 
                jump= 1'b1; 
                                uilu= 1'b0; 

            end  
            7'b1101111: begin    // ===============Jump (JAL) 
                reg_write = 1'b1;
                mem_write = 1'b0; 
                mem_to_reg = 1'b1;
                alu_op = 2'b00;
                alu_src = 1'b0;
                branch = 1'b0; 
                jump= 1'b1;
                 uilu= 1'b0; 

                end
                
              7'b1101111: begin    // ===============U type  
                reg_write = 1'b1;
                mem_write = 1'b0; 
                mem_to_reg = 1'b1;
                alu_op = 2'b00;
                alu_src = 1'b0;
                branch = 1'b0; 
                jump= 1'b0;
                 uilu= 1'b1; 

                end
            default: begin       // Default case for unknown opcodes
                reg_write = 1'b0;
                mem_write = 1'b0;
                mem_to_reg = 1'b0;
                alu_op = 2'b00;
                alu_src = 1'b0;
                branch = 1'b0;
                jump= 1'b0; 
                                 uilu= 1'b0; 


            end
        endcase
    end

endmodule



 