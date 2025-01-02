`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module rv32i_Pipline_top#(parameter WIDTH =32)(
    input logic clk, 
    input logic reset_n 
);

    logic reg_write, mem_write, alu_src, mem_to_reg, branch, zero, less, pc_sel; 
    logic [3:0] alu_ctrl;
    logic [6:0] opcode; 
//    logic [31:0] pc_in, pc_out, instruction, write_data, read_data;
//    logic [31:0] imm_gen, read_data_1, read_data_2, mem_read_data;
    logic fun7_5, jump, uilu, ID_EX_fun7_5;
    logic [2:0] fun3, EX_MEM_fun3,ID_EX_fun3; 
    logic [1:0] alu_op, ID_EX_alu_op;
    logic [WIDTH-1: 0] next_pc, current_pc, inst,reg_wdata_2, reg_rdata2, reg_rdata1, reg_wdata;
    logic [WIDTH-1: 0] imm,alu_op2,alu_result,mem_rdata, pc_plus_4;
//    logic [4:0] rs1, rs2,rd,ID_EX_rd, MEM_WB_rd, EX_MEM_rd; 
        logic [4:0] rs1, rs2,rd,ID_EX_rd,ID_EX_rs1,ID_EX_rs2,MEM_WB_rd,EX_MEM_rd; 

    logic [31:0] pc_jump,reg_wdata__3;
    logic LoadSignal; 
    logic PCWrite , IF_IDWrite , Stall, do_branch; 
    // ============ Program Counter done
    program_counter#(.WIDTH(WIDTH))pc_inst(
    .clk(clk),
    .reset_n(reset_n),
    .data_in(next_pc),
    .data_o(current_pc)
    );
    assign pc_plus_4 = current_pc +4; 
        // ========== Instruction Memory Done    
    inst_mem inst_Mem_inst(
    .address(current_pc),
    .instruction(inst)
    );
    
        //================= Pipeline Register: IF/ID ================= Done 
    logic [31:0] IF_ID_pc_out, IF_ID_instruction, IF_ID_pc_plus_4;
    
    IF_ID_REG IF_ID_REG_inst(
        .clk(clk), //+++
        .reset_n(reset_n),
        .pc_in(current_pc),                     // PC from IF stage
        .instruction_in(inst),       // Instruction fetched
        .pc_out(IF_ID_pc_out),              // Pass to ID stage
        .instruction_out(IF_ID_instruction), // Pass to ID stage
        .pc_plus_4_in(pc_plus_4),
        .pc_plus_4_out(IF_ID_pc_plus_4), 
        .IF_IDWrite(IF_IDWrite),
        .do_branch(do_branch)
    );
    //=========================== Hazard Detection Unit ==================

    
    Hazard_Detection_Unit HDU(
        .clk(clk),
        .reset(reset_n),
        .LoadSignal(LoadSignal),         // Indicates if the EX stage instruction is a load
        .ID_EX_RegisterRd(ID_EX_rd),      // Destination register in EX stage
        .IF_ID_RegisterRs1(rs1),     // Source register 1 in ID stage
        .IF_ID_RegisterRs2(rs2),     // Source register 2 in ID stage
        .PCWrite(PCWrite),              // Control to allow/disallow PC update
        .IF_IDWrite(IF_IDWrite),           // Control to allow/disallow IF/ID register update
        .Stall(Stall)                 // Signal to stall the pipeline
);
    //================= Control Unit ================= Done 
    main_control main_control_inst(
        .opcode(opcode), 
        .branch(branch), 
        .mem_write(mem_write), 
        .mem_to_reg(mem_to_reg), 
        .alu_src(alu_src), 
        .alu_op(alu_op),
        .reg_write(reg_write), 
        .jump(jump), 
        .uilu(uilu),
        .LoadSignal(LoadSignal), 
        .Stall(Stall) 
    ); 


//    logic zero;
    assign rs1 = IF_ID_instruction[19:15];
    assign rs2 = IF_ID_instruction[24:20];
    assign rd = IF_ID_instruction[11:7];
    assign opcode = IF_ID_instruction[6:0];
    assign fun7_5 = IF_ID_instruction[29];
    assign fun3 = IF_ID_instruction[14:12];
    

   //================= Pipeline Register: ID/EX ================= done
    logic [31:0] ID_EX_pc, ID_EX_imm, ID_EX_read_data_1, ID_EX_read_data_2, ID_EX_pc_plus_4;
//    logic [3:0] ID_EX_alu_ctrl;
    logic ID_EX_reg_write, ID_EX_uilu, ID_EX_jump,ID_EX_branch, ID_EX_mem_write, ID_EX_alu_src, ID_EX_mem_to_reg;
    ID_EX_REG ID_EX_REG_inst(
        .clk(clk), 
        .reset_n(reset_n), 
        .pc_in(IF_ID_pc_out),              // PC from IF/ID
        .imm_in(imm),                  // Immediate from Imm Gen
        .read_data_1_in(reg_rdata1),      // Read data 1 from Register File
        .read_data_2_in(reg_rdata2),      // Read data 2 from Register File
        .jump_in(jump), 
        .reg_write_in(reg_write), 
        .branch_in(branch), 
        .mem_write_in(mem_write),
        .alu_src_in(alu_src),
        .mem_to_reg_in(mem_to_reg),
        .write_reg_in(rd),
        .jump_out(ID_EX_jump), 
        .uilu_in(uilu),
        .uilu_out(ID_EX_uilu), 
        .pc_out(ID_EX_pc),                 // Pass to EX stage
        .imm_out(ID_EX_imm), 
        .read_data_1_out(ID_EX_read_data_1),
        .read_data_2_out(ID_EX_read_data_2),
        .reg_write_out(ID_EX_reg_write), 
        .branch_out(ID_EX_branch), 
        .mem_write_out(ID_EX_mem_write),
        .alu_src_out(ID_EX_alu_src),
        .mem_to_reg_out(ID_EX_mem_to_reg),
        .write_reg_out(ID_EX_rd), 
        .alu_op_in(alu_op), 
        .alu_op_out(ID_EX_alu_op), 
        .fun3_in(fun3),
        .fun3_out(ID_EX_fun3),
        .func7_5_in(fun7_5),          // 5th bit of func7
        .func7_5_out(ID_EX_fun7_5),          // 5th bit of func7
        .pc_plus_4_in(IF_ID_pc_plus_4),
        .pc_plus_4_out(ID_EX_pc_plus_4),
                .rs1_in(rs1),
        .rs1_out(ID_EX_rs1),
        .rs2_in(rs2),
        .rs2_out(ID_EX_rs2), 
        .do_branch(do_branch)
        

    );
    //================= ALU Control ================= done 
    alu_control alu_cont_inst(
        .alu_op(ID_EX_alu_op),           // ALU operation from Main Control
        .func3(ID_EX_fun3),              // Instruction field func3
        .func7_5(ID_EX_fun7_5),          // 5th bit of func7
        .alu_ctrl(alu_ctrl)        // ALU control signal
    );


 
    

    

    
    //============= IMM  done 
     imm_gen imm_inst(
     .inst(IF_ID_instruction), 
    .imm(imm));
    
    //============ Mux before the alu done
    
//    assign alu_op2 = ID_EX_alu_src? ID_EX_imm : ID_EX_read_data_2;
    
    // ============ ALU done
    
// alu#(.WIDTH(32)) alu_inst(
//    .reset_n(reset_n), 
//    .op1(ID_EX_read_data_1), .op2(alu_op2), 
//    .alu_ctrl(alu_ctrl), 
//    .alu_result(alu_result), 
//    .zero(zero),
//    .less(less)
//      );
        //================= Pipeline Register: EX/MEM ================= Done
            logic [31:0] aluop1,aluop2, F;

    logic [31:0] EX_MEM_imm, EX_MEM_pc, EX_MEM_alu_result, EX_MEM_write_data,EX_MEM_pc_plus_4;
    logic EX_MEM_uilu, EX_MEM_read_data_2,EX_MEM_less,EX_MEM_jump,EX_MEM_zero, EX_MEM_reg_write, EX_MEM_branch, EX_MEM_mem_write, EX_MEM_mem_to_reg;
    EX_MEM_REG EX_MEM_REG_inst(
        .clk(clk), 
        .reset_n(reset_n), 
        .pc_in(pc_jump),                  // PC from ID/EX
        .alu_result_in(alu_result),        // ALU result from EX stage
        .write_data_in(aluop2), // Write data for memory  // == aluop2
        .zero_in(zero),                    // Zero flag from ALU
        .reg_write_in(ID_EX_reg_write),        
        .branch_in(ID_EX_branch), 
        .jump_in(ID_EX_jump), 
        .mem_write_in(ID_EX_mem_write),
        .mem_to_reg_in(ID_EX_mem_to_reg), .less_in(less), 
        .less_out(EX_MEM_less), 
        .pc_out(EX_MEM_pc),                // Pass to MEM stage
        .jump_out(EX_MEM_jump),
        .alu_result_out(EX_MEM_alu_result),
        .write_data_out(EX_MEM_write_data), //=== Value I need to store in mem 
        .zero_out(EX_MEM_zero),
        .reg_write_out(EX_MEM_reg_write),        
        .branch_out(EX_MEM_branch), 
        .mem_write_out(EX_MEM_mem_write),
        .mem_to_reg_out(EX_MEM_mem_to_reg),
         .uilu_in(ID_EX_uilu),
        .uilu_out(EX_MEM_uilu) , 
        .imm_in(ID_EX_imm), 
        .imm_out(EX_MEM_imm),
         .fun3_in(ID_EX_fun3),
        .fun3_out(EX_MEM_fun3),
        .pc_plus_4_in(ID_EX_pc_plus_4),
        .pc_plus_4_out(EX_MEM_pc_plus_4),
        .write_reg_in(ID_EX_rd), 
        .write_reg_out(EX_MEM_rd),
        .do_branch(do_branch)


    );
    
   //================= Branch Controller =================done
    branch_controller branch_cont_inst(
        .fun3(EX_MEM_fun3), 
        .zero(EX_MEM_zero), 
        .branch(EX_MEM_branch), 
        .less(EX_MEM_less), 
        .pc_sel(pc_sel), 
        .jump(EX_MEM_jump), 
        .do_branch(do_branch)
    );
    
    //=========== Data memory done
     data_mem #(
    .DEPTH(1024),  
    .WIDTH(32) 
  )data_mem_inst(
    .clk(clk),
    .reset_n(reset_n),
    .mem_write(EX_MEM_mem_write),
    .addr(EX_MEM_alu_result),
    .wdata(EX_MEM_write_data), 
    .funct3(EX_MEM_fun3), 
    .rdata(mem_rdata)
    );
    


    //================= Pipeline Register: MEM/WB ================= Done
    logic [31:0] MEM_WB_alu_result, MEM_WB_mem_rdata, MEM_WB_imm,MEM_WB_pc_plus_4;
    logic MEM_WB_uilu,MEM_WB_reg_write, MEM_WB_mem_to_reg, MEM_WB_jump;
    MEM_WB_REG MEM_WB_REG_inst(
        .clk(clk), 
        .reset_n(reset_n), 
        .alu_result_in(EX_MEM_alu_result),    // ALU result from EX/MEM
        .read_data_in(mem_rdata),        // Data read from memory
        .reg_write_in(EX_MEM_reg_write),        
        .mem_to_reg_in(EX_MEM_mem_to_reg),
        .jump_in(EX_MEM_jump), 
        .jump_out(MEM_WB_jump), 
        .alu_result_out(MEM_WB_alu_result),  // Pass to WB stage
        .read_data_out(MEM_WB_mem_rdata),
        .reg_write_out(MEM_WB_reg_write),        
        .mem_to_reg_out(MEM_WB_mem_to_reg), 
        .uilu_in(EX_MEM_uilu),
        .uilu_out(MEM_WB_uilu),
        .imm_in(EX_MEM_imm), 
        .imm_out(MEM_WB_imm),
        .pc_plus_4_in(EX_MEM_pc_plus_4),
        .pc_plus_4_out(MEM_WB_pc_plus_4),
        .write_reg_in(EX_MEM_rd), 
        .write_reg_out(MEM_WB_rd)

    );
    // =========Reg_ file done 
    
     reg_file reg_file_inst(
    .reset_n(reset_n), 
    .clk(clk), 
    .reg_write(MEM_WB_reg_write), // Write enable signal 
    .raddr1(rs1), 
    .raddr2(rs2), 
    .waddr(MEM_WB_rd), 
    .wdata(reg_wdata), 
    .rdata1(reg_rdata1), 
    .rdata2(reg_rdata2) );
    
    //==============
    assign reg_wdata_2= MEM_WB_mem_to_reg? MEM_WB_mem_rdata : MEM_WB_alu_result;//mux 1
    assign pc_jump = ID_EX_imm + ID_EX_pc; 
    assign next_pc = (PCWrite ) ? ((pc_sel? EX_MEM_pc : pc_plus_4)): current_pc;
    assign reg_wdata__3 = MEM_WB_jump ? MEM_WB_pc_plus_4 : reg_wdata_2; //mux 2
    assign reg_wdata = MEM_WB_uilu ? MEM_WB_imm : reg_wdata__3; //mux 3
    
    
        
    //============ forwarding unit 
 logic [1:0] forwardA, forwardB;

// Forwarding Unit
always @(*) begin
//    if (!reset_n) begin
//        forwardA = 2'b00;
//        forwardB = 2'b00;
//    end else begin
        // Default values
        forwardA = 2'b00;
        forwardB = 2'b00;

        // EX Hazard
        if (EX_MEM_reg_write && (EX_MEM_rd != 0)) begin
            if (EX_MEM_rd == ID_EX_rs1)
                forwardA = 2'b10;
            if (EX_MEM_rd == ID_EX_rs2)
                forwardB = 2'b10;
        end

        // MEM Hazard
         if (MEM_WB_reg_write && (MEM_WB_rd != 0)) begin
            if (!(EX_MEM_reg_write && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs1)) && (MEM_WB_rd == ID_EX_rs1))
                forwardA = 2'b01;
            if (!(EX_MEM_reg_write && (EX_MEM_rd != 0) && (EX_MEM_rd == ID_EX_rs2)) && (MEM_WB_rd == ID_EX_rs2))
                forwardB = 2'b01;
        end
    end



    //============== Mux for pipline 

//     assign F = forwardA[0]? reg_wdata :ID_EX_read_data_1;
//      assign aluop1=forwardA[1]? EX_MEM_alu_result :F;
//      assign aluop2=forwardB[1]? EX_MEM_alu_result :(forwardB[0]? reg_wdata :alu_op2);
//          assign aluop1 = forwardA == 2'b10 ? EX_MEM_alu_result : 
//                forwardA == 2'b01 ? reg_wdata :
//                ID_EX_read_data_1;
//      assign aluop2 = forwardB == 2'b10 ? EX_MEM_alu_result : 
//                forwardB == 2'b01 ? reg_wdata : 
//                              alu_op2;
      assign aluop1 = forwardA == 2'b10 ? EX_MEM_alu_result : 
                forwardA == 2'b01 ? reg_wdata :
                ID_EX_read_data_1;
      assign aluop2 = forwardB == 2'b10 ? EX_MEM_alu_result : 
                forwardB == 2'b01 ? reg_wdata : 
                ID_EX_read_data_2;
      assign alu_op2 = ID_EX_alu_src? ID_EX_imm : aluop2;
    //============ Mux before the alu done
    
    
    
    // ============ ALU done
  
 alu#(.WIDTH(32)) alu_inst(
    .reset_n(reset_n), 
    .op1(aluop1), 
    .op2(alu_op2), 
    .alu_ctrl(alu_ctrl), 
    .alu_result(alu_result), 
    .zero(zero),
    .less(less)
      );
      
  

    
endmodule

