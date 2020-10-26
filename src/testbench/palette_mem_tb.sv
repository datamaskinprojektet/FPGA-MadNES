`timescale 1ns / 1ps

module palette_memory_tb(

    );
    
    logic clk;
    logic[7:0] write_addr;
    logic [8:0] read_addr;
    logic write_enable;
    logic [15:0] write_data;
    
    logic [23:0] ram_data_out;
    
    palette_memory mem(
        .clk(clk),
        .write_enable(write_enable),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_addr(read_addr),
        .read_data(ram_data_out)
    );
    
    initial begin
        clk = 0;
        
        read_addr    = 0;
        write_addr   = 0;
        write_enable = 1;
        write_data   = 16'h1234;

        #10
        write_addr = 1;
        write_data = 16'h56;

        #10

        write_addr = 2;
        write_data = 16'h9876;

        #10
        write_addr = 3;
        write_data = 16'h54;
        
        #5
        read_addr = 1;
    
    end
    
    always #5 clk = ~clk;
endmodule
