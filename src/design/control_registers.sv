`timescale 1ns / 1ps


module control_registers(
    input logic clk,                // Clock to drive the module
    input logic[2:0] read_addr,     // ReadAddress, multiplexes between registers
    input logic[2:0] write_addr,    // WriteAddress, multiplexes
    input logic[7:0] write_data,    // Data to write to control registers
    input logic[0:0] write_enable,  // Enables writing to control registers

    output reg[7:0]  read_data      // Data output from registers

);
//////////////////////////////////
/// Color Palette Select       ///
//////////////////////////////////
/// Min: 0, Max 7              ///
//////////////////////////////////
reg[2:0] color_palette_sel;


//////////////////////////////////
/// State Register (Addr 001)  ///
//////////////////////////////////
/// 0 = Normal Operation       ///
/// 1 = Loading State          ///
/// 2 = Bootstrapping Phase    ///
/// 3 = Not used               ///
//////////////////////////////////
reg[1:0] state;

always_ff @(posedge clk) begin
    if(write_enable) begin
        case(write_addr)
            3'b000: color_palette_sel <= write_data[2:0];
            3'b001: state             <= write_data[1:0];
        endcase

    end
end

// Set Bootstrapping phase on init
initial begin
    state <= 2'b010;
end


always_comb begin
    case(read_addr)
        3'b000: read_data <= color_palette_sel;
        3'b001: read_data <= state;
    endcase
end

endmodule
