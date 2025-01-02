`timescale 1ns / 1ps

module program_counter_tb; 

parameter n=32; 

    logic [n-1: 0] next_pc, current_pc;
    logic clk, reset_n; 
    program_counter#(.WIDTH(32))pc_inst(
    .clk(clk),
    .reset_n(reset_n),
    .data_in(next_pc),
    .data_o(current_pc)
    );

    initial begin 
    clk=0;
    forever #5 clk = ~clk; 
    end 
    
    initial begin 
        reset_n=0; 
        next_pc=32'b0;
        #10
        #10 reset_n=1;
        #10 next_pc = 32'hAAAA_AAAA; 
        #10 next_pc = 32'h5555_5555; 
        #10 next_pc = 32'h1234_5678; 

    #10 reset_n = 0; 
    #10 reset_n = 1; 

    #20 $finish;
  end

endmodule