`timescale 1ns / 1ps

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

module prepare_line(clk, reset, oam_data, sx, sy, oam_addr, BufferArray, line_prepared);
    parameter maxObjectPerLine = 32, OAMMaxObjects = 256, OAM_ADDR_SIZE=6;

input wire clk;
input wire reset;
input wire [31:0] oam_data;
input wire [9:0] sx;
input wire [9:0] sy;
output logic [OAM_ADDR_SIZE-1:0] oam_addr;
output logic [maxObjectPerLine - 1 : 0][OAM_ADDR_SIZE:0] BufferArray;
output logic line_prepared;

// Control signals
logic last_object_fetched, writing_to_last_index;
logic [9:0] last_sy;
logic enabled;
logic sy_changed;
logic should_write;
logic object_valid;
logic line_prepared_q;

// Counters
logic [OAM_ADDR_SIZE-1:0] oam_index_d, oam_index_q;
int buffer_array_index_d, buffer_array_index_q;

// Object memory
logic [31:0] object;
int object_ypos;
logic object_enabled;
assign object_ypos = object[27:18];
assign object_enabled = object[31];

// Sprite calculations
int sprite_line;
logic sprite_is_on_line;

// Output array
logic [OAM_ADDR_SIZE:0] buffer_array_element_d;
logic [maxObjectPerLine-1:0][OAM_ADDR_SIZE:0] buffer_array_q;

// Control signals
assign should_write =
            object_enabled
            && sprite_is_on_line
            && object_valid
            && enabled;
assign sy_changed = last_sy != sy;
assign enabled = !line_prepared_q || sy_changed;
assign writing_to_last_index = (buffer_array_index_q >= maxObjectPerLine - 1) && should_write;
assign line_prepared = !enabled;

// Output
assign oam_addr = oam_index_d;
assign object = oam_data;
assign BufferArray = buffer_array_q;

always_comb begin
    sprite_line = sy - object_ypos;
    sprite_is_on_line = (sprite_line >= 0 && sprite_line < 16);

    buffer_array_element_d = {oam_index_q, 1'b1};

    // Counters
    if (sy_changed) begin
        oam_index_d = 0;
        buffer_array_index_d = 0;
    end else begin
        oam_index_d = oam_index_q >= OAMMaxObjects-1 ? oam_index_q : oam_index_q + 1;
        if (writing_to_last_index) begin
            buffer_array_index_d = buffer_array_index_q;
        end else begin
            buffer_array_index_d = buffer_array_index_q + should_write;
        end
    end
end

always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        oam_index_q <= 0;
        buffer_array_index_q <= 0;
        buffer_array_q <= 0;
        last_sy <= -1;
        line_prepared_q <= 0;
        object_valid <= 0;
    end else begin
        // -------- Control signals --------
        last_sy <= sy;
        object_valid <= enabled;
        last_object_fetched <= oam_index_d >= OAMMaxObjects - 1;
        line_prepared_q <= (line_prepared_q || last_object_fetched || writing_to_last_index) && !sy_changed;

        // -------- Counters --------
        oam_index_q <= oam_index_d;
        buffer_array_index_q <= buffer_array_index_d;

        // -------- Write to buffer -------- 
        if (should_write) begin
            buffer_array_q[buffer_array_index_q] <= buffer_array_element_d;
        end else if (sy_changed) begin
            buffer_array_q <= 0;
        end
    end
end
endmodule
