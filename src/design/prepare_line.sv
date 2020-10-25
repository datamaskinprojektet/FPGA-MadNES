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


module prepare_line(clk, reset, oam_data, sx, sy, oam_addr, BufferArray, line_prepeared);
    parameter maxObject = 4, OAMObjectBitSize = 40, OAMMaxObjects = 4;
    parameter Start = 0, LineCheck = 1, Increment = 2, End = 3;

    input wire clk;
    input wire reset;
    input wire [31:0] oam_data;
    input wire [9:0] sx;
    input wire [9:0] sy; 
    output wire [5:0] oam_addr;
    output logic [8:0] BufferArray [maxObject - 1 : 0];
    output logic line_prepeared;

    logic [7:0] BufferArrayIndex, BufferArrayIndexBuffer;
    logic [7:0] OAMIndex, OAMIndexBuffer;
    logic [2:0] state;
    logic changeIny;
    wire  [9:0] SpriteLineIndex;
    wire  [0:0] SpriteOnLine;
    logic [9:0] lastY;
    logic line_prepeared_buffer;

    /*

SpriteLineIndex = CurrentLine - OAM.y_pos
SpriteOnLine = SpriteLineIndex >= 0 && SpriteLineIndex < 16

    */

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

    assign oam_addr = OAMIndex;
    assign SpriteLineIndex = sy - oam_data[27:17];
    assign SpriteOnLine = (SpriteLineIndex >= 0) && (SpriteLineIndex < 16);

    always_ff @ (posedge clk or posedge reset) begin
        OAMIndex <= OAMIndexBuffer;
        BufferArrayIndex <= BufferArrayIndexBuffer;
        lastY <= sy;
        line_prepeared <= line_prepeared_buffer;
        if (reset || lastY != sy) begin
            state <= LineCheck;
            BufferArrayIndex <= 0;
            BufferArrayIndexBuffer <= 0;
            OAMIndex <= 0;
            OAMIndexBuffer <= 0;
            line_prepeared <= 0;
            line_prepeared_buffer <= 0;
            foreach ( BufferArray[i] ) begin
                BufferArray[i] = 0;
            end
        end
        else begin
            case (state)
            LineCheck:
                if (OAMIndex == OAMMaxObjects) begin
                    state <= End;
                end
                else begin
                    if (BufferArrayIndex < maxObject || OAMIndex < OAMMaxObjects ) begin
                        line_prepeared_buffer <= 0;
                        if (oam_data[31:31] == 1 && SpriteOnLine == 1) begin
                            BufferArray[BufferArrayIndex][8:1] <= OAMIndex;
                            BufferArray[BufferArrayIndex][0:0] <= 1;
                            BufferArrayIndexBuffer++;
                        end
                        OAMIndexBuffer++;
                    end
                    else begin
                        state <= End;
                    end
                end
            End:
                begin
                    state <= End;
                    line_prepeared_buffer <= 1;
                    OAMIndexBuffer <= 'bz;
                end
            endcase
        end
    end
endmodule
