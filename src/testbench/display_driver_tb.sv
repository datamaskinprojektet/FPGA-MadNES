`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2020 11:43:30
// Design Name: 
// Module Name: display_driver_tb
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


module display_driver_tb();

    logic [15:0] EBI_AD;

    logic EBI_ALE;
    logic EBI_CS;
    logic EBI_RE;
    logic EBI_WE;
    logic reset;

    logic vga_hsync;  
    logic vga_vsync;
    logic [3:0] vga_r;
    logic [3:0] vga_g;
    logic [3:0] vga_b;

    logic clk;
    always #1 clk = ~clk;

    display_driver dut_display_driver (
    .clk_100m                   (clk),
    .btn_rst                    (reset),                             
    .EBI_AD                     (EBI_AD),
    .EBI_ALE                    (EBI_ALE),
    .EBI_CS                     (EBI_CS),
    .EBI_RE                     (EBI_RE),
    .EBI_WE                     (EBI_WE),

    .vga_hsync                  (vga_hsync),
    .vga_vsync                  (vga_vsync),
    .vga_r                      (vga_r),
    .vga_g                      (vga_g),
    .vga_b                      (vga_b)
    );

        initial begin
        clk = 1;
        reset = 1;
        EBI_ALE = 1;
        EBI_WE = 1;
        EBI_RE = 1;
        EBI_CS = 1;

        #10;
        reset = 0;
        EBI_CS = 0;
        EBI_AD = 5;
        #20;
        EBI_ALE = 0;
        #20;
        EBI_ALE = 1;
        #20;
        EBI_AD = 50;
        #20;
        EBI_WE = 0;
        #20;
        EBI_WE = 1;
        #20;
        #20;
        EBI_AD = 15;
        #50;
        EBI_ALE = 0;
        #20;
        EBI_ALE = 1;
        #20;
        EBI_AD = 30;
        #20;
        EBI_WE = 0;
        #20;
        EBI_WE = 1;
        #40;
        EBI_CS = 1;
        #5000;
        $stop;
    end

endmodule
