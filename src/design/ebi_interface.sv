`timescale 1ns / 1ps

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

logic [15:0] latched_address, latched_data;

always_latch begin
    if (~EBI_ALE) begin
        latched_address = EBI_AD;
    end
    if (~EBI_WE) begin
        latched_data = EBI_AD;
    end
end

// The following does not work in synthesis, So I've made my own below
// always_ff @(posedge clk, negedge EBI_WE) begin
//     data_ready_d <= ~EBI_WE;
// end

// ------------------- WEIRD CODE --------------------- //
wire not_we, A, not_A, Q, not_Q;
assign not_we = ~EBI_WE;
assign A =      ~((  ~not_we   ) & not_A);
assign not_A =  ~((clk | not_we) & A);
assign Q =      ~(~( (   A  & clk) | not_we) & not_Q);
assign not_Q =  ~( (~(not_A & clk) | not_we) & Q);
// ---------------------------------------------------- //

always_ff @(posedge clk) begin
    address_out <= latched_address;
    data_out <= latched_data;
    data_ready <= Q;
end
endmodule
