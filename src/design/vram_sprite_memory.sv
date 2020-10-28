`timescale 1ns / 1ps

module vram_16b_x_8_x_4096 (
    input wire clk,               // Clock to drive the RAM module
    input wire [11:0] read_addr,  // 12 bits to address 2048 sprite lines
    input wire [14:0] write_addr, // 15 bits to address 32768 pixel pairs
    input wire [15:0] write_data,
    input wire write_enable,
    output reg [255:0] read_data
);

generate;
    genvar i;
    (* RAM_STYLE="BLOCK" *)
    reg [15:0] SPRITE_RAM [7:0][4095:0];
endgenerate

always_ff @(posedge clk) begin
    if(write_enable) begin
        SPRITE_RAM[write_addr[2:0]][write_addr[14:3]] <= write_data;
    end
end

always_comb begin
    read_data = {
        SPRITE_RAM[7][read_addr],
        SPRITE_RAM[6][read_addr],
        SPRITE_RAM[5][read_addr],
        SPRITE_RAM[4][read_addr],
        SPRITE_RAM[3][read_addr],
        SPRITE_RAM[2][read_addr],
        SPRITE_RAM[1][read_addr],
        SPRITE_RAM[0][read_addr]
    };
end
endmodule
