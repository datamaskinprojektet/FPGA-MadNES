`default_nettype none
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2020 19:44:03
// Design Name: 
// Module Name: oam_memory
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


module oam_memory(
    input wire clk,              // Clock to drive the RAM module
    input wire[5:0]  read_addr,  // 5 bits to address 64 locations
    input wire[6:0]  write_addr, // 6 bits to address 128 locations
    input wire[15:0] write_data,
    input wire  write_enable,

    output reg [31:0] read_data

    );


reg[6:0] write_address_inferred;
reg[1:0] write_count = 0;

reg[15:0] buffer_input;
reg[31:0] write_data_total;

logic [31:0] write_data_combine;
   
// Vivado-specific inference
(* RAM_STYLE="BLOCK" *)
reg [31:0] OAM_RAM[63:0]; // OAM Ram consists of 127 16-bit elements
                             // An OAM entry is 32-bits, meaning that it spans
                             // 2 register blocks


reg[31:0] output_data;

always @(posedge clk) begin
    output_data <= OAM_RAM[read_addr];
end

always @(posedge clk) begin
    
    if(write_enable && write_count == 0) begin
        buffer_input <= write_data;
        write_count <= 1;
    end

    if(write_enable && write_count == 1) begin
        write_address_inferred <= write_addr / 2;
        write_data_combine[15:0] = write_data;
        write_data_combine[31:16] = buffer_input;
        write_data_total <= write_data_total; 
        OAM_RAM[write_addr / 2]  <= write_data_combine;
        write_count <= 0;
    end
end

always @(negedge write_enable) begin
    write_count <= 0;
end

always @* begin
    read_data = output_data;
end

endmodule
