`timescale 1ns / 1ps
//////////////////
module data_mem #(
    parameter DEPTH = 1024,  
    parameter WIDTH=32 
  )(
    input clk,
    input reset_n,
    input mem_write,
    input [31:0] addr,
    input [31:0] wdata,
    input [2:0] funct3,
    output reg [31:0] rdata
    );
    
    logic [WIDTH -1:0] dmem [0:DEPTH-1]; // dmem[0] = {byte3, byte2, byte1, byte0},
    // address 4,                       // addr = ....00100
    logic [3:0] wsel;
    logic W,HW,unsign;
    alignment_unit alignment_unit_inst(
    .clk(clk),
    .reset_n(reset_n),
    .mem_write(mem_write),
    .addr(addr),
 
    .funct3(funct3),
    .wsel(wsel),
 
    .W(W),
    .HW(HW),
    .unsign(unsign)  
     );
    always @(posedge clk, negedge reset_n) 
    begin
        if (!reset_n) 
        begin   
            integer i;
            for (i = 0; i < DEPTH; i = i + 1) 
            begin
                dmem[i] <= {WIDTH{1'b0}};  //Each location in memory is  filled 0
            end
         end 
        
            else 
            begin 
                if (mem_write) 
                begin
             //       if(wsel==4'b1111)
              //      dmem[addr[31:2]][31:0] <= wdata; // Write (store word)
             //   else begin 
                    if(wsel[0])
                    dmem[addr[31:2]][7:0] <= wdata[7:0]; // Write (store byte0)
                    if(wsel[1])
                    dmem[addr[31:2]][15:8] <= wdata[15:8]; // Write (store byte1)
                    if(wsel[2])
                    dmem[addr[31:2]][23:16] <= wdata[23:16]; // Write (store byte2)
                    if(wsel[3])
                    dmem[addr[31:2]][31:24] <= wdata[31:24]; // Write (store byte3)
             //       end
                end
            end
     end 
        
      // logic [31:0] dmem_o;
      // assign dmem_o = dmem[addr[31:2]];
       
       // example sign extnesion
       //assign dmem_o = {{24{rdata[7]}},rdata[7:0]};
       
       
     //  assign rdata =(W)? dmem[addr]:((sign)? ((HW)?{{16{dmem[15]}},dmem[addr]}:{dmem[addr]}):dmem[addr]) ; // Read (load)
    // assign dmem_o =dmem[addr[31:2]];
     //  sign extnesion
     //assign rdata =(W)? dmem_o:((unsign)?dmem_o:((HW)?{{16{dmem_o[15]}},dmem_o[15:0]}:{{24{dmem_o[7]}},dmem_o[7:0]})); // Read (load) 
      logic [31:0] dmem_o;
      logic [7:0] selected_byte;
      logic [15:0] selected_halfword;
    assign dmem_o = dmem[addr[31:2]];
   
    always_comb begin
    //selected_byte
    case (addr[1:0])
            2'b00: selected_byte =dmem_o[7:0]; // 0 byte
            2'b01: selected_byte =dmem_o[15:8]; // 1 byte
            2'b10: selected_byte =dmem_o[23:16]; // 2 byte
            2'b11: selected_byte =dmem_o[31:24]; // 3 byte
            default: selected_byte =dmem_o[7:0]; // Default case
        endcase
        //selected_halfword
      selected_halfword=(addr[1])?dmem_o[31:16]:dmem_o[15:0];
      
      
    if (W) begin
            rdata = dmem_o; // Full word override for W
        end
        else begin
        case ({unsign, HW})
            2'b10: rdata ={24'b0, selected_byte}; // Unsigned byte
            2'b11: rdata = {16'b0, selected_halfword}; // Unsigned half word
            2'b00: rdata = {{24{selected_byte[7]}}, selected_byte}; // Signed byte
            2'b01: rdata = {{16{selected_halfword[15]}}, selected_halfword}; // Signed half word
            default: rdata = 32'b0; // Default case
        endcase
    end
    
    
    // addr
    // ..0000
    // ..0001
    // ..0010
    // ..0011
        
    end
    
    endmodule 