`timescale 1ns / 1ps

module vram_tile_memory(

    input wire clk,              // Clock to drive the RAM module
    input wire[11:0]  read_addr,  // 5 bits to address 64 locations
    input wire[14:0]  write_addr, // 6 bits to address 128 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [255:0] read_data
);

reg [15:0] TILE_RAM[32767:0];

logic[14:0] actual_read_addr;
assign actual_read_addr = read_addr << 4;

    always_ff @(posedge clk) begin
        if(write_enable) begin
            TILE_RAM[write_addr] <= write_data;
        end
    end


    always_comb begin
        read_data = { 
            TILE_RAM[actual_read_addr],
            TILE_RAM[actual_read_addr+1],
            TILE_RAM[actual_read_addr+2],
            TILE_RAM[actual_read_addr+3],
            TILE_RAM[actual_read_addr+4],
            TILE_RAM[actual_read_addr+5],
            TILE_RAM[actual_read_addr+6],
            TILE_RAM[actual_read_addr+7],
            TILE_RAM[actual_read_addr+8],
            TILE_RAM[actual_read_addr+9],
            TILE_RAM[actual_read_addr+10],
            TILE_RAM[actual_read_addr+11],
            TILE_RAM[actual_read_addr+12],
            TILE_RAM[actual_read_addr+13],
            TILE_RAM[actual_read_addr+14],
            TILE_RAM[actual_read_addr+15]
        };
    end


endmodule
