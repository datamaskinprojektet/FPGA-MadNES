`timescale 1ns / 1ps

module oam_memory(
    input wire clk,              // Clock to drive the RAM module
    input wire reset,
    input wire[5:0]  read_addr,  // 5 bits to address 64 locations
    input wire[6:0]  write_addr, // 6 bits to address 128 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [31:0] read_data
);

wire enable [1:0];
generate;
    genvar i;
    for(i=0; i<2; i++) begin
        assign enable[i] = write_enable && (write_addr[0] == i);
        bram_16x256 myram (
            .clk(clk),
            .write_addr({2'b00,write_addr[6:1]}),
            .write_data(write_data),
            .write_enable(enable[i]),
            .read_addr({2'b00,read_addr}),
            .read_data(read_data[16*i+15 -: 16])
        );
    end
endgenerate
endmodule
