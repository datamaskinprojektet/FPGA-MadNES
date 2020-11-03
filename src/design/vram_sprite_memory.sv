`timescale 1ns / 1ps

module vram_16b_x_8_x_4096 (
    input wire clk,               // Clock to drive the RAM module
    input wire [11:0] read_addr,  // 12 bits to address 2048 sprite lines
    input wire [14:0] write_addr, // 15 bits to address 32768 pixel pairs
    input wire [15:0] write_data,
    input wire write_enable,
    output wire [127:0] read_data
);

wire enable [7:0];

generate;
    genvar i;
    for(i=0; i<8; i++) begin
        assign enable[i] = write_enable && (write_addr[2:0] == i);
        bram_16x4096 myram (
            .clk(clk),
            .write_addr(write_addr[14:3]),
            .write_data(write_data),
            .write_enable(enable[i]),
            .read_addr(read_addr),
            .read_data(read_data[16*i+15 -: 16])
        );
    end
endgenerate

endmodule
