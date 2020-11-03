`timescale 1ns / 1ps

module bram_16x256(
    input clk,
    input [7:0] write_addr,
    input [15:0] write_data,
    input write_enable,
    input [7:0] read_addr,
    output reg [15:0] read_data
);

(* ram_style = "block" *)
reg [15:0] memory [255:0];

always_ff @(posedge clk) begin
    if (write_enable) begin
        memory [write_addr] <= write_data;
    end
    read_data <= memory [read_addr];
end
endmodule
