`timescale 1ns/1ps
// Testbench for the class vram_sprite_memory

module vram_memory_tb ();

logic [127:0] spriteline;

initial begin
    clk = 1;
    forever begin
        #1 clk = ~clk;
    end
end

initial begin
    std::randomize(spriteline)
end

endmodule

