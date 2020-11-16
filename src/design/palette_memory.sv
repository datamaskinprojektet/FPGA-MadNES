`default_nettype none
`timescale 1ns / 1ps

module palette_memory(
    input wire clk,              // Clock to drive the RAM module
    input wire[7:0]  read_addr,  // 9 bits to address 512 locations
    input wire[7:0]  write_addr, // 8 bits to address 256 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [23:0] read_data // One palette entry is 24 bits
    );


wire enable [1:0];
generate;
    genvar i;
    for(i=0; i<2; i++) begin: myram_gen
        assign enable[i] = write_enable && (write_addr[0] == i);
        bram_16x256 myram (
            .clk(clk),
            .write_addr({1'b0,write_addr[7:1]}),
            .write_data(write_data),
            .write_enable(enable[i]),
            .read_addr(read_addr),
            .read_data(read_data[((8*(1-i))+15-(8*(i))) -: (16-((i)*8))])
        );
    end
endgenerate

endmodule
