`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2020 21:30:49
// Design Name: 
// Module Name: ebi_interface
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


module ebi_interface(
    // Assuming 16-bit bus write only
    input wire [15:0] EBI_AD,
    input wire EBI_ALE,
    input wire EBI_RE,
    input wire EBI_WE,
    input wire reset,
    input wire clk,

    output logic [15:0] address_out,
    output logic [15:0] data_out,
    output logic data_ready
    );

    logic [15:0] A1;
    logic [15:0] A2;
    logic [15:0] D1;
    logic [15:0] D2;
    logic WE_1;
    logic WE_2;
    logic WE_3;
    logic WE_4;

    logic WE_1_2_block;

    always_ff @(posedge clk) begin
        A2 <= A1;
        D2 <= D1;

        address_out <= A2;
        data_out <= D2;

        WE_2 <= WE_1;
        WE_3 <= WE_2;
        WE_4 <= WE_3;
    end

    assign data_ready = ( (~WE_4) & WE_3 );
    assign WE_1_2_block = ( WE_1 ^ WE_2 );

    always @* begin
        if (reset) begin
            D1 = 0;
            
        end
        else if (~EBI_WE) begin
            D1 = EBI_AD[15:0];
            
        end
    end

    always @* begin
        if (reset) begin
            WE_1 = 0;
        end
        else if (~EBI_WE) begin
            WE_1 = 1;
        end
        else if (EBI_WE) begin
            if (~WE_1_2_block) begin
                WE_1 = 0;
            end
        end
    end

    always @* begin
        if (reset) begin
            A1 = 0;
        end
        else if (~EBI_ALE) begin
            A1 = EBI_AD[15:0];
        end 
    end
endmodule
