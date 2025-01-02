`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

module alu#(parameter WIDTH=32)(
    input logic reset_n,
    input logic [WIDTH-1:0] op1, op2, 
    input logic [3:0] alu_ctrl, 
    output logic [WIDTH-1:0] alu_result, 
    output logic zero, 
    output logic less
);

    always_comb begin
       

        case (alu_ctrl)
            4'b0000: alu_result = op1 + op2;                      // ADD
            4'b1000: alu_result = op1 - op2;                      // SUB
            4'b0001: alu_result = op1 << op2[4:0];                // SLL
            4'b0010: begin                                         // SLT (signed)
                alu_result = ($signed(op1) < $signed(op2)) ? {{WIDTH-1{1'b0}}, 1'b1} : {WIDTH{1'b0}};
//                less = ($signed(op1) < $signed(op2));              // Update less for SLT
            end
            4'b0011: begin                                         // SLTU (unsigned)
                alu_result = (op1 < op2) ? {{WIDTH-1{1'b0}}, 1'b1} : {WIDTH{1'b0}};
//                less = (op1 < op2);                                // Update less for SLTU
            end
            4'b0100: alu_result = op1 ^ op2;                      // XOR
            4'b0101: alu_result = op1 >> op2[4:0];                // SRL
            4'b1101: alu_result = $signed(op1) >>> op2[4:0];      // SRA
            4'b0110: alu_result = op1 | op2;                      // OR
            4'b0111: alu_result = op1 & op2;                      // AND
            default: alu_result = {WIDTH{1'b0}};                  // Default case
        endcase

        // Set zero flag
        zero = (alu_result == {WIDTH{1'b0}});
        less = alu_result[0];
    end

endmodule
