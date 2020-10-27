`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2020 14:49:22
// Design Name: 
// Module Name: prepare_line
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
OAM: 2 16-bit addresses 
    8 bit spriteref
    10 bit x pos
    10 bit y pos
    1 bit priority
    1 bit x-flip
    1 bit y-flip
    1 bit enable
*/

/*
BufferArray 2 dim array [index]
0 bit enabled
1-8 bit OAM position
*/

module prepare_line(clk, reset, oam_data, sx, sy, oam_addr, BufferArray, line_prepeared);
    parameter maxObjectPerLine = 32, OAMMaxObjects = 256, OAM_ADDR_SIZE=6;

    input wire clk;
    input wire reset;
    input wire [31:0] oam_data;
    input wire [9:0] sx;
    input wire [9:0] sy; 
    output wire [5:0] oam_addr;
    output logic [maxObjectPerLine - 1 : 0][OAM_ADDR_SIZE:0] BufferArray;
    output logic line_prepeared;

    // Control signals
    logic line_prepared_d, line_prepared_q;
    logic last_sy, sy_changed;
    logic should_write;

    // Counters
    int oam_index_d, oam_index_q, buffer_array_index_d, buffer_array_index_q;

    // Object memory
    logic [OAM_ADDR_SIZE-1:0] oam_index_d, oam_index_q;
    logic [31:0] object;
    int object_ypos;
    assign object_ypos = object[27:18];

    // Sprite calculations
    int sprite_line;
    logic sprite_is_on_line;

    // Output array
    logic [OAM_ADDR_SIZE:0] buffer_array_element_d;
    logic [maxObjectPerLine-1:0][OAM_ADDR_SIZE:0] buffer_array_q;

    // Wire assignments
    assign oam_addr = oam_index_q;

    always_comb begin
        // Datapath
        object = oam_data;

        sprite_line = sy - object_ypos;
        sprite_is_on_line = (sprite_line >= 0 && sprite_line < 16);

        buffer_array_element_d <= {oam_addr, 1};
        oam_index_d = oam_index_q + sprite_is_on_line;

        // Counters
        if (sy_changed) begin
            oam_index_d = 0;
            buffer_array_index_d = 0;
        end else begin
            if (line_prepared_d) begin
                oam_index_d = oam_index_q;
                buffer_array_index_d = buffer_array_index_q;
            end else begin
                oam_index_d = oam_index_q + 1;
                buffer_array_index_d = buffer_array_index_q + 1;
            end
        end

        // Control signals
        sy_changed = last_sy != sy;
        line_prepared_d = ((buffer_array_index_q >= maxObjectPerLine - 1) || (oam_index_q >= OAMMaxObjects - 1))  &&  ~sy_changed;
        should_write = sprite_is_on_line && ~line_prepared_q;
        
        // Output
        line_prepeared = line_prepared_q;
        BufferArray = buffer_array_q;
    end

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            oam_index_q <= 0;
            buffer_array_index_q <= 0;
            buffer_array_q <= 0;
            last_sy <= 0;
            line_prepared_q <= 0;
        end else begin
            oam_index_q <= oam_index_d;
            buffer_array_index_q <= buffer_array_index_d;
            if (should_write) begin
                buffer_array_q[buffer_array_index_d] <= buffer_array_element_d;
            end else if (sy_changed) begin
                buffer_array_q <= 0;
            end
            last_sy <= sy;
            line_prepared_q <= line_prepared_d;
        end
    end
endmodule
