`timescale 1ns / 1ps

/*
OAM: 2 16-bit words
    8 bit spriteref
    10 bit x pos
    10 bit y pos
    1 bit priority
    1 bit x-flip
    1 bit y-flip
    1 bit enable
*/

module sprite_drawer #(
    parameter VRAM_ADDR_SIZE=12,
    parameter VRAM_DATA_SIZE=128,
    parameter SECOND_ARRAY_SIZE=32,
    parameter OAM_ADDR_SIZE=8,
    parameter OAM_DATA_SIZE=32,
    parameter COLOR_DEPTH=8,
    parameter DISPLAY_WIDTH=600,
    parameter DISPLAY_HEIGHT=480,
    parameter int LINE_NUMBER_WIDTH = $clog2(DISPLAY_HEIGHT)
)(
    input wire clk,
    input wire rst,
    input wire enable,
    output logic done,
    output logic [OAM_ADDR_SIZE-1:0] oam_a,
    input wire   [OAM_DATA_SIZE-1:0] oam_d,
    output logic [VRAM_ADDR_SIZE-1:0] vram_a,
    input wire   [VRAM_DATA_SIZE-1:0] vram_d,
    input wire   [SECOND_ARRAY_SIZE-1:0][OAM_ADDR_SIZE:0] second_array, // [OAM_ADDR_SIZE:1] is address, [0] is active/inactive
    input wire   [LINE_NUMBER_WIDTH-1:0] line_number,
    output logic [DISPLAY_WIDTH-1:0][7:0] line_buffer
);

localparam int SECOND_ARRAY_INDEX_WIDTH = $clog2(SECOND_ARRAY_SIZE);

logic priority_d, priority_q;
logic [SECOND_ARRAY_INDEX_WIDTH-1:0] array_index_d, array_index_q;
logic last_object_is_fetched, last_spriteline_is_drawn, sprite_line_valid_q, object_valid_q;

logic [7:0] object_address;
logic object_exists;
assign object_address = second_array[array_index_q][OAM_ADDR_SIZE:1];
assign object_exists = second_array[array_index_q][0];

// Fetched object
logic [OAM_DATA_SIZE-1:0] object;
logic [7:0] object_spriteref;
logic [9:0] object_xpos;
logic [9:0] object_ypos;
logic object_priority;
logic object_xflip;
logic object_yflip;
logic object_enable;
assign object_spriteref = object[7:0];
assign object_xpos      = object[17:8];
assign object_ypos      = object[27:18];
assign object_priority  = object[28];
assign object_xflip     = object[29];
assign object_yflip     = object[30];
assign object_enable    = object[31];

// Shifted object properties for spriteline use
logic [9:0] sprite_xpos;
logic sprite_xflip;

logic [15:0][7:0] sprite_line;
logic [3:0] sprite_row_index;

always_comb begin
    priority_d = priority_q;

    if(enable) begin
        oam_a = object_address;
        sprite_row_index = line_number - object_ypos;
        vram_a = {object_spriteref, sprite_row_index};
        object = oam_d;
        if (!last_object_is_fetched && !done) begin
            array_index_d = array_index_q + 1;
        end else begin
            array_index_d = array_index_q;
        end
        sprite_line = vram_d;
        last_object_is_fetched = (~object_exists) | (array_index_q >= SECOND_ARRAY_SIZE-1);
    end else begin
        priority_d = 0;
        sprite_row_index = 0;
        array_index_d = 0;
        object = 0;
        sprite_line = 0;
        last_object_is_fetched = 0;
        oam_a = 0;
        vram_a = 0;
    end
end

always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
        priority_q <= 0;
        array_index_q <= 0;
        done <= 0;
        line_buffer <= 0;
        sprite_line_valid_q <= 0;
    end else begin
        priority_q <= priority_d;
        array_index_q <= array_index_d;

        // -------- Pipeline control signals --------
        // Startup
        object_valid_q <= enable;
        sprite_line_valid_q <= object_valid_q;

        // End
        last_spriteline_is_drawn <= last_object_is_fetched;
        done <= last_spriteline_is_drawn;

        // -------- Shift object properties used when writing spriteline --------
        sprite_xpos <= object_xpos;
        sprite_xflip <= object_xflip;

        // -------- Draw to linebuffer --------
        if (enable) begin
            if (!done && sprite_line_valid_q) begin
                for (int i=0; i<16; i++) begin
                    line_buffer[sprite_xpos+i] <= sprite_line[i];
                end
            end
        end else begin
            line_buffer <= 0;
        end
    end
end
endmodule
