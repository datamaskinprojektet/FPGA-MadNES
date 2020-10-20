`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2020 17:20:37
// Design Name: 
// Module Name: simple_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


/*
Verilog Example

This example shows how to create a 16x16 (16 words
16 bits per word) synchronous, dual-port RAM.
*/

module ram_16x12d_infer (data_out, write_enable, data_inn, read_address, write_address, clk);
parameter d_width = 12, addr_width = 16;

output logic [d_width - 1:0] data_out;
input logic write_enable, clk;
input logic [d_width - 1:0] data_inn;
input logic [addr_width - 1:0] read_address, write_address;

reg [d_width - 1:0] mem [(1 << addr_width) - 1:0];

always @(posedge clk)
if (write_enable)
mem[write_address] = data_inn;

always_comb
data_out = mem[read_address];

endmodule 
