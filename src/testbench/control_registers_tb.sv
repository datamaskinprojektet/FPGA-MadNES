`timescale 1ns / 1ps

module control_registers_tb(

);

    logic clk;
    logic[2:0] read_addr;
    logic[2:0] write_addr; 
    logic[7:0] write_data;
    logic[0:0] write_enable;

    logic[7:0] read_data;

    control_registers CTRL(
       .clk(clk),
       .read_addr(read_addr),
       .write_addr(write_addr),
       .write_data(write_data),
       .write_enable(write_enable),
       .read_data(read_data)
    );


    initial begin

        clk = 0;
        read_addr = 0;
        write_addr = 0;
        write_data = 0;
        write_enable = 1;

        #40
        write_data = 1;

        #40
        write_data = 2;

        #40
        write_data = 3;

        #40
        write_data = 4;

        #40
        write_data = 5;

        #40
        write_data = 6;

        #40
        write_data = 7;

        #40
        write_addr = 3'b001;
        write_data = 0;

        #40
        write_data = 1;

        #40
        read_addr = 3'b001;

    end


    always #20 clk = ~clk;


endmodule
