`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2020 13:04:53
// Design Name: 
// Module Name: prepare_line_tb
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


module prepare_line_tb();

    logic           reset;
    logic           clk;
    logic [31:0]    oam_data;
    logic [9:0]     sx;
    logic [9:0]     sy; 
    logic [5:0]    oam_addr;
    logic [8:0] BufferArray [4 - 1 : 0];
    logic line_prepeared;

    prepare_line u_prepare_line (
        .clk                    (clk),
        .reset                  (reset),
        .oam_data               (oam_data),
        .sx                     (sx),
        .sy                     (sy),
        .oam_addr               (oam_addr),
        .BufferArray    (BufferArray),
        .line_prepeared (line_prepeared)
    );

    always #2 clk = ~clk; 

    initial begin
    foreach ( BufferArray[i] ) begin
        BufferArray[i] = 0;
    end
    reset = 1;
    clk = 1;
    sx = 0;
    sy = 0;
    //oam_data = 2'b00000000 0000000000 0000000000 0 0 0 1;
    oam_data = 0;
    oam_data[31] = 1;
    #2;
    reset = 0;
    #10;

    //sy = 15;
    #50;
    sy = 16;
    #5;
    //sy = 17;
    #5;
    //sy = 18;
    #50;
    sy = 15;
    #100;
    $stop;
        
    end

endmodule
