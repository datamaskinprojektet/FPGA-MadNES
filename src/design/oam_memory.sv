`default_nettype none
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


reg[6:0] write_address_inferred;
reg[1:0] write_count;

reg[15:0] buffer_input;
reg[31:0] write_data_total;

//logic [31:0] write_data_combine;
   
// Vivado-specific inference
(* RAM_STYLE="BLOCK" *)
reg [15:0] OAM_RAM [127:0]; // OAM Ram consists of 127 16-bit elements
                             // An OAM entry is 32-bits, meaning that it spans
                             // 2 register blocks


reg[31:0] output_data;

// always_ff @(posedge clk) begin
//     output_data <= OAM_RAM[read_addr];
// end

always_ff @(posedge clk) begin
    if (write_enable) begin
        OAM_RAM[write_addr] = write_data;
    end
    /*
    if (reset) begin
        write_count <= 0;
    end
    else begin
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
    */
end

//always @(negedge write_enable) begin
//    write_count <= 0;
//end

always_comb begin
    read_data = { OAM_RAM[(read_addr << 1) + 1], OAM_RAM[read_addr << 1] };
end

endmodule
