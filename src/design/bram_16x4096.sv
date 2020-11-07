`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2020 16:55:18
// Design Name: 
// Module Name: bram_16x4096
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


module bram_16x4096(
    input clk,
    input [11:0] write_addr,
    input [15:0] write_data,
    input write_enable,
    input [11:0] read_addr,
    output reg [15:0] read_data
);

(* ram_style = "block" *)
reg [15:0] memory [4095:0];

always_ff @(posedge clk) begin
    if (write_enable) begin
        memory [write_addr] <= write_data;
    end
    read_data <= memory [read_addr];
end

endmodule
