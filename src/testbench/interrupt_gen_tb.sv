`timescale 1ns / 1ps


module interrupt_gen_tb(

);


logic interrupt_trigger;
logic clk;
logic interrupt;


interrupt_gen IGEN(
    .clk(clk),
    .interrupt_trigger(interrupt_trigger),
    .interrupt(interrupt)
);

initial begin
    clk = 0;
    interrupt_trigger = 0;

    #40
    
    #15
    interrupt_trigger = 1;

    #20
    interrupt_trigger = 0;
end

always #20 clk = ~clk;


endmodule
