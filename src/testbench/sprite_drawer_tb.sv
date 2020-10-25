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
logic [DISPLAY_WIDTH-1:0][2:0][COLOR_DEPTH-1:0] line_buffer;

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
    clk = 0;
    forever begin
        #2 clk = ~clk;
    end
end

initial begin
    $display("*** sprite_drawer_tb.sv ***");
    $display("Initializing signals...");
    rst=1;
    enable=0;
    line_number=0;
    second_array = {32{0}};
    $display("Starting simulation!");
    #2
    rst=0;
    enable=1;
    #1600
    $stop;
end

endmodule
