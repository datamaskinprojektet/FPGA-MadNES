`timescale 1ns / 1ps

module vram_tile_memory(

    input wire clk,              // Clock to drive the RAM module
    input wire[11:0]  read_addr,  // 5 bits to address 64 locations
    input wire[14:0]  write_addr, // 6 bits to address 128 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [255:0] read_data
);

reg [255:0] TILE_RAM[2047:0];

logic[3:0] write_count;
logic[3:0] count_next;

reg[15:0] buffer0;
reg[15:0] buffer1;
reg[15:0] buffer2;
reg[15:0] buffer3;
reg[15:0] buffer4;
reg[15:0] buffer5;
reg[15:0] buffer6;
reg[15:0] buffer7;
reg[15:0] buffer8;
reg[15:0] buffer9;
reg[15:0] buffer10;
reg[15:0] buffer11;
reg[15:0] buffer12;
reg[15:0] buffer13;
reg[15:0] buffer14;

assign count_next = write_count + 1;

    always_ff @(posedge clk) begin

        if(!write_enable) write_count = 0;

        if(write_enable) begin
            case(write_count)
                0: buffer0 <= write_data;
                1: buffer1 <= write_data;
                2: buffer2 <= write_data;
                3: buffer3 <= write_data;
                4: buffer4 <= write_data;
                5: buffer5 <= write_data;
                6: buffer6 <= write_data;
                7: buffer7 <= write_data;
                8: buffer8 <= write_data;
                9: buffer9 <= write_data;
                10: buffer10 <= write_data;
                11: buffer11 <= write_data;
                12: buffer12 <= write_data;
                13: buffer13 <= write_data;
                14: buffer14 <= write_data;
                15: begin
                    TILE_RAM[write_addr >> 4] = {
                        buffer0,
                        buffer1,
                        buffer2,
                        buffer3,
                        buffer4,
                        buffer5,
                        buffer6,
                        buffer7,
                        buffer8,
                        buffer9,
                        buffer10,
                        buffer11,
                        buffer12,
                        buffer13,
                        buffer14,
                        write_data
                    };
                end
            endcase
            if(write_count == 15) write_count = 0;
            else write_count = count_next;
        end // write_enable
    end

    always_comb begin
        read_data <= TILE_RAM[read_addr];
    end


endmodule
