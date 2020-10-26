`timescale 1ns / 1ps

module tam_memory(
    input wire clk,              // Clock to drive the RAM module
    input wire[9:0]  read_addr,  // 5 bits to address 64 locations
    input wire[6:0]  write_addr, // 6 bits to address 128 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [15:0] read_data

);


endmodule