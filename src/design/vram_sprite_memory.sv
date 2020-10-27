`timescale 1ns / 1ps

module vram_sprite_memory(
    input wire clk,              // Clock to drive the RAM module
    input wire[11:0]  read_addr,  // 12 bits to address 2048 sprite lines
    input wire[14:0]  write_addr, // 15 bits to address 32768 pixel pairs
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [255:0] read_data
);

reg [15:0] SPRITE_RAM[32767:0];

logic[3:0] write_count;
logic[3:0] count_next;

logic[14:0] actual_read_addr;

assign actual_read_addr = read_addr << 4;


    always_ff @(posedge clk) begin

        if(write_enable) begin
            SPRITE_RAM[write_addr] <= write_data;
        end
    end

    always_comb begin
        read_data = { 
            SPRITE_RAM[actual_read_addr],
            SPRITE_RAM[actual_read_addr+1],
            SPRITE_RAM[actual_read_addr+2],
            SPRITE_RAM[actual_read_addr+3],
            SPRITE_RAM[actual_read_addr+4],
            SPRITE_RAM[actual_read_addr+5],
            SPRITE_RAM[actual_read_addr+6],
            SPRITE_RAM[actual_read_addr+7],
            SPRITE_RAM[actual_read_addr+8],
            SPRITE_RAM[actual_read_addr+9],
            SPRITE_RAM[actual_read_addr+10],
            SPRITE_RAM[actual_read_addr+11],
            SPRITE_RAM[actual_read_addr+12],
            SPRITE_RAM[actual_read_addr+13],
            SPRITE_RAM[actual_read_addr+14],
            SPRITE_RAM[actual_read_addr+15]
        };
    end

endmodule
