`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module data_path_tb;



  // Testbench Signals
  parameter WIDTH = 32;

  logic clk;
  logic reset_n;
  logic reg_write;
  logic alu_src;
  logic [3:0] alu_ctrl;
  logic mem_write;
  logic memtoreg;
  logic branch;

  // Instantiate the Data Path module
  data_path #(.WIDTH(WIDTH)) uut (
    .clk(clk),
    .reset_n(reset_n),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .alu_ctrl(alu_ctrl),
    .mem_write(mem_write),
    .memtoreg(memtoreg),
    .branch(branch)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Test sequence
  initial begin
  
    // Initialize inputs
     reset_n = 0;
    #10 reset_n = 1;

    reg_write = 1;
    alu_src =1;
    alu_ctrl = 4'b0000;
    mem_write = 0;
    memtoreg = 0;
    branch = 0;

//    // Apply Reset
//    #10 reset_n = 1;

    // Test Case 1: Load 10 into t0 (addi t0, x0, 10)
    #10 reg_write = 1;
        alu_src = 1;
        alu_ctrl = 4'b0000; // ADD operation
        mem_write = 0;
        memtoreg = 0;
        branch = 0;

    // Test Case 2: Load 5 into t1 (addi t1, x0, 5)
    #10 reg_write = 1;
        alu_src = 0;
        alu_ctrl = 4'b0000; // ADD operation
        mem_write = 0;
        memtoreg = 0;
        branch = 0;
        // Simulated instruction: addi t1, x0, 5
        #10;

    // Test Case 3: Add t2 = t0 + t1 (add t2, t0, t1)
//    #10 reg_write = 1;
//        alu_src = 0; // Use register data for second operand
//        alu_ctrl = 4'b0010; // ADD operation
//        mem_write = 0;
//        memtoreg = 0;
//        branch = 0;
//        // Simulated instruction: add t2, t0, t1
//        #10;

    // End simulation
    #50 $finish;
  end
  
  
  initial begin 
    #40;
    for(int i=0; i<32;i = i+1) begin 
        $display("reg[%d] = %d", i, uut.reg_file_inst.reg_array[i]);
    end
    
  end

  // Monitor Outputs
  initial begin
    $monitor($time, " reg_write=%b, alu_src=%b, alu_ctrl=%b, mem_write=%b, memtoreg=%b, branch=%b",
             reg_write, alu_src, alu_ctrl, mem_write, memtoreg, branch);
  end

endmodule

