`timescale 1ns / 1ps


module interrupt_gen_tb(

);


logic blank;
logic clk;
logic interrupt;


interrupt_gen IGEN(
    .clk(clk),
    .blank(blank),
    .interrupt(interrupt)
);

initial begin
    clk = 0;
    blank = 0;

    #40
    
    #15
    blank = 1;

    #20
    blank = 0;
end

always #20 clk = ~clk;


endmodule
