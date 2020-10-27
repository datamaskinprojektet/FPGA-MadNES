`timescale 1ns / 1ps

/**
 * Memory Module to contain TAM entries for tilemaps 
 *
 * One TAM-entry is 16-bits.
 **/
module tam_memory(
    input wire clk,              // Clock to drive the RAM module
    input wire[10:0]  read_addr,  // 11 bits to address up to 2048 locations
    input wire[10:0]  write_addr, // 11 bits to address up to 2048 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [15:0] read_data
);

(* RAM_STYLE="BLOCK" *)
reg[15:0] TAM_RAM [1199:0];

    always_ff @(posedge clk) begin
        if(write_enable) begin
            TAM_RAM[write_addr] <= write_data;
        end
    end

    always_comb begin
        read_data = { TAM_RAM[read_addr] };
    end

endmodule
