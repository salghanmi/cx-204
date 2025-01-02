`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module alu_control(
    input logic [1:0] alu_op,          // ALU operation from Main Control
    input logic [2:0] func3,           // Instruction field func3
    input logic func7_5,               // 5th bit of func7
    output logic [3:0] alu_ctrl        // ALU control signal
);

    always_comb begin
        case (alu_op)
            2'b10: begin // R-type
                case ({func7_5, func3})
                    4'b0000: alu_ctrl = 4'b0000; // ADD
                    4'b1000: alu_ctrl = 4'b1000; // SUB
                    4'b0001: alu_ctrl = 4'b0001; // SLL
                    4'b0010: alu_ctrl = 4'b0010; // SLT
                    4'b0011: alu_ctrl = 4'b0011; // SLTU
                    4'b0100: alu_ctrl = 4'b0100; // XOR
                    4'b0101: alu_ctrl = 4'b0101; // SRL
                    4'b1101: alu_ctrl = 4'b1101; // SRA
                    4'b0110: alu_ctrl = 4'b0110; // OR
                    4'b0111: alu_ctrl = 4'b0111; // AND
                    default: alu_ctrl = 4'b0000; // Default to ADD
                endcase
            end
            2'b11: begin // I-type
                case (func3)
                    3'b000: alu_ctrl = 4'b0000; // ADDI
                    3'b010: alu_ctrl = 4'b0010; // SLTI
                    3'b011: alu_ctrl = 4'b0011; // SLTIU
                    3'b100: alu_ctrl = 4'b0100; // XORI
                    3'b110: alu_ctrl = 4'b0110; // ORI
                    3'b111: alu_ctrl = 4'b0111; // ANDI
                    default: alu_ctrl = 4'b0000; // Default to ADDI
                endcase
            end
            2'b01: 
                case (func3)
                    3'b000: alu_ctrl = 4'b1000; // BEQ
                    3'b001: alu_ctrl = 4'b1010; // BNE
                    3'b100: alu_ctrl = 4'b0010; // BLT
                    3'b101: alu_ctrl = 4'b0010; // BGE
                    3'b110: alu_ctrl = 4'b0011; // BLTU
                    3'b111: alu_ctrl = 4'b0011; // BGEU
                    default: alu_ctrl = 4'b0000; // Default to ADDI
            endcase 
            
            2'b00: alu_ctrl = 4'b0000; // Load/Store (ADD)
            default: alu_ctrl = 4'b0000; // Default to ADD
        endcase
    end

endmodule
