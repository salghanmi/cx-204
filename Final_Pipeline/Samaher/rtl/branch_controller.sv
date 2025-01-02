`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 01:59:03 PM
// Design Name: 
// Module Name: branch_controller
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


module branch_controller(
    input logic [2:0] fun3, 
    input logic zero, 
    input logic branch, 
    input logic less, jump, 
    output logic pc_sel, 
    output logic do_branch
    );

    //logic do_branch;
    always_comb begin
 
        if (branch) begin
            case (fun3)
                3'b000: do_branch = zero;           // BEQ: Branch if equal
                3'b001: do_branch = ~zero;          // BNE: Branch if not equal
                3'b100: do_branch = less;           // BLT: Branch if less than
                3'b101: do_branch = ~less;          // BGE: Branch if greater or equal
                3'b110: do_branch = less;           // BLTU: Branch if less than (unsigned)
                3'b111: do_branch = ~less;          // BGEU: Branch if greater or equal (unsigned)
                default: do_branch = 1'b0;          // Default: No branch
            endcase
        end else begin
            do_branch = 1'b0; // No branch if branch signal is not enabled
        end
    end

    assign pc_sel = jump | do_branch; 
    
endmodule




