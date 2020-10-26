`timescale 1ns / 1ps

module vram_sprite_memory(
    input wire clk,              // Clock to drive the RAM module
    input wire[11:0]  read_addr,  // 5 bits to address 64 locations
    input wire[14:0]  write_addr, // 6 bits to address 128 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [127:0] read_data
);


endmodule