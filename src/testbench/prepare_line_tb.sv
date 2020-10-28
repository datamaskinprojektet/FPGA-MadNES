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

    parameter int maxObjectPerLine = 32;
    parameter int OAM_ADDR_SIZE = 6;
    parameter int OAM_MAX_OBJECTS = 256;

    logic           reset;
    logic           clk;
    logic [31:0]    oam_data;
    logic [9:0]     sx;
    logic [9:0]     sy; 
    logic [5:0]    oam_addr;
    wire  [maxObjectPerLine - 1 : 0][OAM_ADDR_SIZE:0] BufferArray;
    logic line_prepeared;

    // Testbench parameters
    logic [64:0] clk_count;
    logic [maxObjectPerLine - 1 : 0][OAM_ADDR_SIZE:0] BufferArrayCheck;
    logic [64:0] bufferIncrement;

    prepare_line #(
        .maxObjectPerLine(maxObjectPerLine), 
        .OAMMaxObjects(256),
        .OAM_ADDR_SIZE(OAM_ADDR_SIZE)
        ) u_prepare_line (
        .clk            (clk),
        .reset          (reset),
        .oam_data       (oam_data),
        .sx             (sx),
        .sy             (sy),
        .oam_addr       (oam_addr),
        .BufferArray    (BufferArray),
        .line_prepeared (line_prepeared)
    );

    always #1 clk = ~clk;

    always @(posedge clk) begin
        clk_count++;
    end


    task test_empty_buffer_array();
    fork : f
        begin
            // Timeout check
            #(2*(u_prepare_line.OAMMaxObjects + 10));
            $display("%t : timeout", $time);
            $error("Expected test to be finished in %d cycles", (u_prepare_line.OAMMaxObjects + 10));
            $stop;
            disable f;
        end
        begin
            // Wait on signal
            @(posedge line_prepeared);
            #0.1;
            $display("%t : posedge line_prepeared", $time);
            $display("Used %d on %d objects", clk_count, u_prepare_line.OAMMaxObjects);
            for (int i=0; i<maxObjectPerLine; i++) begin
                bufferArrayEmpty: assert (BufferArray[i] == BufferArrayCheck[i])
                    else $error("Assertion bufferArrayEmpty[%d] failed!\nBuffer=%d, Check=%d", i, BufferArray[i], BufferArrayCheck[i]);
            end
            disable f;
        end
    join
    endtask


    task test_full_buffer_array();
    fork : f
        begin
            // Timeout check
            #(2*(u_prepare_line.maxObjectPerLine + 10));
            $display("%t : timeout", $time);
            $error("Expected test to be finished in %d cycles", (u_prepare_line.maxObjectPerLine + 10));
            $stop;
            disable f;
        end
        begin
            // Wait on signal
            @(posedge line_prepeared);
            #0.1;
            $display("%t : posedge line_prepeared", $time);
            $display("Used %d on %d objects", clk_count, u_prepare_line.OAMMaxObjects);
            bufferArrayEmpty: assert (BufferArray == BufferArrayCheck)
                else $error("Assertion bufferArrayEmpty failed!");
            disable f;
        end
    join
    endtask

    task resetModule();
        reset = 1;
        clk = 1;
        sx = 0;
        sy = 0;
        oam_data = 0;
        #1;
        reset = 0;
        clk_count = 0;
    endtask

    initial begin
    resetModule();
    $display("prepare_line Unit Test");
    $display("prepare_line Testing empty buffer array");
    foreach (BufferArrayCheck[i]) begin
        BufferArrayCheck[i] = {
            i,
            1'b1
        };
    end
    test_empty_buffer_array();
    $display("prepare_line Testing empty buffer array Done");

    #4;

    resetModule();
    $display("prepare_line Testing full buffer array");
    bufferIncrement = 0;
    oam_data[31] = 1;

    for (int i = 0; i<$size(BufferArrayCheck); i++) begin
        BufferArrayCheck[i][0] = 1'b1;
        BufferArrayCheck[i][OAM_ADDR_SIZE:1] = bufferIncrement;
        bufferIncrement++;
    end

    test_full_buffer_array();
    $display("prepare_line Testing full buffer array Done");
    $finish;
        
    end

endmodule
