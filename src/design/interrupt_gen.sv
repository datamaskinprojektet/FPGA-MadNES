`timescale 1ns / 1ps

/**
* Interrupt Generator Module
* ============================================================
* This module generates an interrupt signals that lasts for three (3)
* clock cycles.
*
* This is achieved with the help from three back-to-back registers through
* which the signal is propagated, moving from one register to the next at
* every positive edge of the clock signal.
**/
module interrupt_gen(
    input wire clk, 
    input wire interrupt_trigger,

    output wire interrupt
);

    reg interrupt1;
    reg interrupt2;
    reg interrupt3;


    assign interrupt = interrupt1 | interrupt2 | interrupt3;


    always_ff @(posedge clk) begin
        interrupt1 <= interrupt_trigger;
        interrupt2 <= interrupt1;
        interrupt3 <= interrupt2;
    end

endmodule
