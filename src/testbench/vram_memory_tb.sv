`timescale 1ns/1ps
// Testbench for the class vram_sprite_memory

module vram_memory_tb ();

logic clk;               // Clock to drive the RAM module
logic [11:0] read_addr;  // 12 bits to address 2048 sprite lines
logic [14:0] write_addr; // 15 bits to address 32768 pixel pairs
logic [15:0] write_data;
logic write_enable;
logic [127:0] read_data;

vram_16b_x_8_x_4096 sprites (
    .clk(clk),
    .write_addr(write_addr),
    .write_data(write_data),
    .write_enable(write_enable),
    .read_addr(read_addr),
    .read_data(read_data)
);

logic [127:0] spriteline;

initial begin
    clk = 1;
    forever begin
        #1 clk = ~clk;
    end
end

initial begin
    for (int j=0; j < 128; j++) begin
        std::randomize(spriteline);
        write_enable = 1;
        read_addr = j;
        @(posedge clk);
        #0.1;
        for(int i=0; i<8; i++) begin
            write_addr = 8*j + i;
            write_data = spriteline[16*i+15 -: 16];
            @(posedge clk);
            #0.1;
        end
        write_enable = 0;
        @(posedge clk);
        #0.1;
        writereadcorrect: assert (read_data == spriteline)
            else $error("Assertion writereadcorrect %d failed!", j);
    end
    #1;
    $finish;
end

endmodule

