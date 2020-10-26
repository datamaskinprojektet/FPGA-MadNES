`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2020 19:23:20
// Design Name: 
// Module Name: sprite_drawer_tb
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


module sprite_drawer_tb();

parameter VRAM_ADDR_SIZE=12;
parameter VRAM_DATA_SIZE=128;
parameter SECOND_ARRAY_SIZE=32;
parameter OAM_ADDR_SIZE=8;
parameter OAM_DATA_SIZE=32;
parameter COLOR_DEPTH=8;
parameter PALETTE_SIZE=256;
parameter DISPLAY_WIDTH=600;
parameter DISPLAY_HEIGHT=480;
parameter int LINE_NUMBER_WIDTH=$clog2(DISPLAY_WIDTH);

logic clk;
logic rst;
logic enable;
logic done;
logic [OAM_ADDR_SIZE-1:0] oam_a;
logic [OAM_DATA_SIZE-1:0] oam_d;
logic [VRAM_ADDR_SIZE-1:0] vram_a;
logic [VRAM_DATA_SIZE-1:0] vram_d;
logic [SECOND_ARRAY_SIZE-1:0][OAM_ADDR_SIZE:0] second_array; // [OAM_ADDR_SIZE:1] is address, [0] is active/inactive
logic [LINE_NUMBER_WIDTH-1:0] line_number;
logic [DISPLAY_WIDTH-1:0][7:0] line_buffer;

logic [31:0] objects [SECOND_ARRAY_SIZE/2];
int x_pos, y_pos;
logic [127:0] sprites [SECOND_ARRAY_SIZE/2];

sprite_drawer UUT (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .done(done),
    .oam_a(oam_a),
    .oam_d(oam_d),
    .vram_a(vram_a),
    .vram_d(vram_d),
    .second_array(second_array),
    .line_number(line_number),
    .line_buffer(line_buffer)
);

initial begin
    clk = 1;
    forever begin
        #1 clk = ~clk;
    end
end

initial begin
    #1600
    $stop;
end

initial begin
    $display("*** sprite_drawer_tb.sv ***");
    $display("Initializing signals...");
    rst=1;
    enable=0;
    line_number=0;
    second_array = {32{9'b000000000}};
    for (int i=0; i < SECOND_ARRAY_SIZE/2; i++) begin
        second_array[i] = {i[7:0], 1'd1};
        x_pos = (20*i);
        y_pos = line_number;
        objects[i] = {
            4'b0,
            y_pos[9:0],
            x_pos[9:0],
            i[7:0]
        };
        sprites[i] = {
            $urandom(),
            $urandom(),
            $urandom(),
            $urandom()
        };
    end
    $display("second_array = %p", second_array);
    $display("Starting simulation!");
    #1;
    rst=0;
    #1.5;
    enable=1;
    #0.5;
    for (int i=0; i < SECOND_ARRAY_SIZE/2 + 1; i++) begin
        if (i<SECOND_ARRAY_SIZE/2) begin
            puts_correct_oam_a: assert (oam_a == i) else begin
                $error("Assertion puts_correct_oam_a failed on i=%d!", i);
            end
            oam_d = objects[i];
        end
        if (i>0) begin
            puts_correct_vram_a: assert (vram_a[11:4] == objects[i-1][7:0]) else begin
                $error("Assertion puts_correct_vram_a failed!");
            end
            vram_d = sprites[i-1];
        end
        #2;
    end
    #2;
    done_high: assert (done)
        else $error("Assertion done_high failed!");
    for (int i=0; i < $size(objects); i++) begin
        final_result_correct: assert (line_buffer[(20*i) +: 16] == sprites[i])
            else $error("Assertion final_result_correct failed on i=%d!", i);
    end
    #2;
    enable = 0;
end

endmodule
