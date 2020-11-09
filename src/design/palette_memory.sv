`default_nettype none
`timescale 1ns / 1ps

module palette_memory(
    input wire clk,              // Clock to drive the RAM module
    input wire[8:0]  read_addr,  // 9 bits to address 512 locations
    input wire[7:0]  write_addr, // 8 bits to address 256 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [23:0] read_data // One palette entry is 24 bits
    );


(* RAM_SYLE="BLOCK" *)
reg[23:0] PALETTE_RAM[255:0];

reg[15:0] RGBuffer;

always_ff @(posedge clk) begin
    
    if(write_enable && write_addr[0] == 0) begin
        RGBuffer <= write_data ;
    end else if(write_enable && write_addr[0] == 1) begin
        PALETTE_RAM[write_addr >> 1] <= (RGBuffer << 8) + write_data;
    end

end

always_comb begin
    read_data <= PALETTE_RAM[read_addr];
end
endmodule
