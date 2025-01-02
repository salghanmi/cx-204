`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

module reg_file(
    input logic reset_n, 
    input logic clk, 
    input logic reg_write, // Write enable signal 
    input logic [4:0] raddr1, 
    input logic [4:0] raddr2, 
    input logic [4:0] waddr, 
    input logic [31:0] wdata, 
    output logic [31:0] rdata1, 
    output logic [31:0] rdata2 

);
    // 32x32 register array
    logic [31:0] reg_array [0:31];
    logic [31:0] rdata1_old, rdata2_old; 
//  always @( negedge clk   , negedge reset_n) begin
//    // Read Logic
//         if (!reset_n) begin
//            // Asynchronous reset: clear all registers
//            rdata1 <= 32'b0;
//            rdata2 <= 32'b0;
//    end else begin 
//             rdata1 <= reg_array[raddr1];
//             rdata2 <= reg_array[raddr2];
//end
//end 
   assign   rdata1_old = reg_array[raddr1];
    assign  rdata2_old = reg_array[raddr2];
    assign rdata1 = (wdata == raddr1 ) ? wdata : rdata1_old;
        assign rdata2 = (wdata == raddr2 ) ? wdata : rdata2_old;
    // Write Logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // Asynchronous reset: clear all registers
            for (int i = 0; i < 32; i++) begin
                reg_array[i] <= 32'b0;
            end
        end else if (reg_write && waddr != 5'b0) begin
            // Write to the specified register (excluding x0)
            reg_array[waddr] <= wdata;
        end
    end

    // Ensure x0 (register 0) is always 0
    always @(posedge clk or negedge reset_n) begin
        reg_array[0] <= 32'b0;
    end
    
     

endmodule
