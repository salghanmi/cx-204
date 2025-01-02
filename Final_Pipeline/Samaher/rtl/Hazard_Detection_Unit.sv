`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2025 09:23:32 AM
// Design Name: 
// Module Name: Hazard_Detection_Unit
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


module Hazard_Detection_Unit(
    input logic              clk,
    input logic              reset,
    input logic              LoadSignal,         // Indicates if the EX stage instruction is a load
    input logic [4:0]        ID_EX_RegisterRd,   // Destination register in EX stage
    input logic [4:0]        IF_ID_RegisterRs1,  // Source register 1 in ID stage
    input logic [4:0]        IF_ID_RegisterRs2,  // Source register 2 in ID stage
    output logic             PCWrite,           // Control to allow/disallow PC update
    output logic             IF_IDWrite,        // Control to allow/disallow IF/ID register update
    output logic             Stall              // Signal to stall the pipeline
);

    always_comb begin
        // Default values (no hazard detected)
        PCWrite = 1;
        IF_IDWrite = 1;
        Stall = 0;

        // Detect load-use hazard
        if (LoadSignal && ((ID_EX_RegisterRd == IF_ID_RegisterRs1) ||
                           (ID_EX_RegisterRd == IF_ID_RegisterRs2))) begin
            // Stall the pipeline
            PCWrite = 0;
            IF_IDWrite = 0;
            Stall = 1;
        end
    end

endmodule

