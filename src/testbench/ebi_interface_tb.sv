`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2020 12:30:02
// Design Name: 
// Module Name: ebi_interface_tb
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


module ebi_interface_tb();
    
    logic [15:0] EBI_AD;

    logic EBI_CS;
    logic EBI_ALE;
    logic EBI_RE;
    logic EBI_WE;
    logic reset;

    logic clk;
    logic data_ready;
    
    logic [15:0] address_out;
    logic [15:0] data_out;
    
    ebi_interface u_ebi_interface (
        .reset               (reset),
        .EBI_AD              (EBI_AD),
        .EBI_ALE             (EBI_ALE),
        .EBI_RE              (EBI_RE),
        .EBI_WE              (EBI_WE),
        .clk                 (clk),
        .address_out    (address_out),
        .data_out       (data_out),
        .data_ready         (data_ready)
    );

    
    // generate clock
    always #4 clk = ~clk;

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
        EBI_ALE = 0;
        #2;
        EBI_ALE = 1;
        #2;
        EBI_AD = 50;
        #2;
        EBI_WE = 0;
        #2;
        EBI_WE = 1;
        #2;
        #2;
        EBI_AD = 15;
        #5;
        EBI_ALE = 0;
        #2;
        EBI_ALE = 1;
        #2;
        EBI_AD = 30;
        #2;
        EBI_WE = 0;
        #2;
        EBI_WE = 1;
        #4;
        EBI_CS = 1;
        #30;
        $stop;
    end

endmodule
