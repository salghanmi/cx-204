`timescale 1ns / 1ps
//////////////////
module imm_gen(

    input logic [31:0] inst, 
    output logic [31:0] imm

);

always_comb begin 
    imm = 32'b0; // Initialize imm to zero
    
    case (inst[6:2]) // Determine the instruction type based on opcode field
        5'b00100, 5'b00000: begin // I-Type (e.g., ADDI, LOAD)
            imm[11:0] = inst[31:20];
            imm[31:12] = {20{inst[31]}}; // Sign extension
        end

        5'b01000: begin // S-Type (e.g., STORE)
            imm[4:0] = inst[11:7];
            imm[11:5] = inst[31:25];
            imm[31:12] = {20{inst[31]}}; // Sign extension
        end

        5'b11000: begin // B-Type (e.g., BEQ, BNE)
            imm[0] = 1'b0; // Immediate always aligned
            imm[4:1] = inst[11:8];
            imm[10:5] = inst[30:25];
            imm[11] = inst[7];
            imm[12] = inst[31];
            imm[31:13] = {19{inst[31]}}; // Sign extension
        end

        5'b01101, 5'b00101: begin // U-Type (e.g., LUI, AUIPC)
            imm[31:12] = inst[31:12];
        end

        5'b11011: begin // J-Type (e.g., JAL)
            imm[0] = 1'b0; // Immediate always aligned
            imm[10:1] = inst[30:21];
            imm[11] = inst[20];
            imm[19:12] = inst[19:12];
            imm[20] = inst[31];
            imm[31:21] = {11{inst[31]}}; // Sign extension
        end

        default: begin
            imm = 32'b0; // Default to zero for unsupported instructions
        end
    endcase
end 

endmodule
