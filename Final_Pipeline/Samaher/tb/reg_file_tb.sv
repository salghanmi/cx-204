
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

module reg_file_tb;
    logic clk, reset_n, reg_write;
    logic [4:0] raddr1, raddr2, waddr;
    logic [31:0] wdata, rdata1, rdata2;

    reg_file uut (
        .clk(clk),
        .reset_n(reset_n),
        .reg_write(reg_write),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .waddr(waddr),
        .wdata(wdata),
        .rdata1(rdata1),
        .rdata2(rdata2)
    );

    initial begin
        clk = 0; reset_n = 0; reg_write = 0;
        raddr1 = 0; raddr2 = 0; waddr = 0; wdata = 0;
        #5 reset_n = 1;

        // Write to register 1 and 2
        #10 reg_write = 1; waddr = 5'd1; wdata = 32'hAAAA_BBBB;
        #10 waddr = 5'd2; wdata = 32'hCCCC_DDDD;

        // Read back registers
        #10 reg_write = 0; raddr1 = 5'd1; raddr2 = 5'd2;

        // Attempt to write to register 0 (should not change)
        #10 reg_write = 1; waddr = 5'd0; wdata = 32'hFFFF_FFFF;

        // Read register 0 and confirm it remains 0
        #10 reg_write = 0; raddr1 = 5'd0;

        #50 $finish;
    end

    always #5 clk = ~clk;

    // Monitor outputs
    initial begin
        $monitor($time, " raddr1=%d rdata1=%h | raddr2=%d rdata2=%h",
                 raddr1, rdata1, raddr2, rdata2);
    end
endmodule
