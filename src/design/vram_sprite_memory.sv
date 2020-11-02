`timescale 1ns / 1ps

module vram_16b_x_8_x_4096 (
    input wire clk,               // Clock to drive the RAM module
    input wire [11:0] read_addr,  // 12 bits to address 2048 sprite lines
    input wire [15:0] write_addr, // 15 bits to address 32768 pixel pairs
    input wire [15:0] write_data,
    input wire write_enable,
    output reg [255:0] read_data
);

// Writing / Reading / Addressing
// Generate 16 36Kb TDP BRAM blocks
// Each port enables a read-width and write-width of 8 bits.
// Each BRAM block will be able to write and read 16 bits at a time.
// With 16 BRAM blocks, we can evenly distribute the data and read an entire
// 256b sprite-line in one cycle.

    wire[7:0] DIN_0;
    wire[7:0] DIN_1;

    wire[3:0]  MODULE_SELECT;
    wire[11:0] WRITE_ADDRESS_LOCATION;

    assign DIN_0 = write_data[7:0];
    assign DIN_1 = write_data[15:8];

    wire ENA;
    wire ENB;

    assign ENA = 1;
    assign ENB = 1;

    assign MODULE_SELECT = write_addr[3:0];
    assign WRITE_ADDRESS_LOCATION = write_addr[15:4];




    // BRAM Block 0
    wire[7:0] SPRITE_RAM_0_DOUT_A;
    wire[7:0] SPRITE_RAM_0_DOUT_B;


    // BRAM Block 1
    wire[7:0] SPRITE_RAM_1_DOUT_A;
    wire[7:0] SPRITE_RAM_1_DOUT_B;


    // BRAM Block 2
    wire[7:0] SPRITE_RAM_2_DOUT_A;
    wire[7:0] SPRITE_RAM_2_DOUT_B;


    // BRAM Block 3
    wire[7:0] SPRITE_RAM_3_DOUT_A;
    wire[7:0] SPRITE_RAM_3_DOUT_B;


    // BRAM Block 4
    wire[7:0] SPRITE_RAM_4_DOUT_A;
    wire[7:0] SPRITE_RAM_4_DOUT_B;


    // BRAM Block 5
    wire[7:0] SPRITE_RAM_5_DOUT_A;
    wire[7:0] SPRITE_RAM_5_DOUT_B;


    // BRAM Block 6
    wire[7:0] SPRITE_RAM_6_DOUT_A;
    wire[7:0] SPRITE_RAM_6_DOUT_B;


    // BRAM Block 7
    wire[7:0] SPRITE_RAM_7_DOUT_A;
    wire[7:0] SPRITE_RAM_7_DOUT_B;


    // BRAM Block 8
    wire[7:0] SPRITE_RAM_8_DOUT_A;
    wire[7:0] SPRITE_RAM_8_DOUT_B;


    // BRAM Block 9
    wire[7:0] SPRITE_RAM_9_DOUT_A;
    wire[7:0] SPRITE_RAM_9_DOUT_B;


    // BRAM Block 10
    wire[7:0] SPRITE_RAM_10_DOUT_A;
    wire[7:0] SPRITE_RAM_10_DOUT_B;


    // BRAM Block 11
    wire[7:0] SPRITE_RAM_11_DOUT_A;
    wire[7:0] SPRITE_RAM_11_DOUT_B;


    // BRAM Block 12
    wire[7:0] SPRITE_RAM_12_DOUT_A;
    wire[7:0] SPRITE_RAM_12_DOUT_B;


    // BRAM Block 13
    wire[7:0] SPRITE_RAM_13_DOUT_A;
    wire[7:0] SPRITE_RAM_13_DOUT_B;


    // BRAM Block 14
    wire[7:0] SPRITE_RAM_14_DOUT_A;
    wire[7:0] SPRITE_RAM_14_DOUT_B;


    // BRAM Block 15
    wire[7:0] SPRITE_RAM_15_DOUT_A;
    wire[7:0] SPRITE_RAM_15_DOUT_B;

    // Address input Port A
    // Addr 0 -> BRAM0_PA | BRAM0_PB
    // Addr 1 -> BRAM1_PA | BRAM1_PB
    // Addr 2 -> BRAM2_PA | BRAM2_PB
    // Addr 3 -> BRAM3_PA | BRAM3_PB
    // Addr 4 -> BRAM4_PA | BRAM4_PB
    // ......
    // Idea: Use the 4 LSb to address BRAM modules

    // Write Enables
    wire SPRITE_RAM_0_WEN;
    wire SPRITE_RAM_1_WEN;
    wire SPRITE_RAM_2_WEN;
    wire SPRITE_RAM_3_WEN;
    wire SPRITE_RAM_4_WEN;
    wire SPRITE_RAM_5_WEN;
    wire SPRITE_RAM_6_WEN;
    wire SPRITE_RAM_7_WEN;
    wire SPRITE_RAM_8_WEN;
    wire SPRITE_RAM_9_WEN;
    wire SPRITE_RAM_10_WEN;
    wire SPRITE_RAM_11_WEN;
    wire SPRITE_RAM_12_WEN;
    wire SPRITE_RAM_13_WEN;
    wire SPRITE_RAM_14_WEN;
    wire SPRITE_RAM_15_WEN;

    assign SPRITE_RAM_0_WEN = (MODULE_SELECT == 0) && write_enable;
    assign SPRITE_RAM_1_WEN = (MODULE_SELECT == 1) && write_enable;
    assign SPRITE_RAM_2_WEN = (MODULE_SELECT == 2) && write_enable;
    assign SPRITE_RAM_3_WEN = (MODULE_SELECT == 3) && write_enable;
    assign SPRITE_RAM_4_WEN = (MODULE_SELECT == 4) && write_enable;
    assign SPRITE_RAM_5_WEN = (MODULE_SELECT == 5) && write_enable;
    assign SPRITE_RAM_6_WEN = (MODULE_SELECT == 6) && write_enable;
    assign SPRITE_RAM_7_WEN = (MODULE_SELECT == 7) && write_enable;
    assign SPRITE_RAM_8_WEN = (MODULE_SELECT == 8) && write_enable;
    assign SPRITE_RAM_9_WEN = (MODULE_SELECT == 9) && write_enable;
    assign SPRITE_RAM_10_WEN = (MODULE_SELECT == 10) && write_enable;
    assign SPRITE_RAM_11_WEN = (MODULE_SELECT == 11) && write_enable;
    assign SPRITE_RAM_12_WEN = (MODULE_SELECT == 12) && write_enable;
    assign SPRITE_RAM_13_WEN = (MODULE_SELECT == 13) && write_enable;
    assign SPRITE_RAM_14_WEN = (MODULE_SELECT == 14) && write_enable;
    assign SPRITE_RAM_15_WEN = (MODULE_SELECT == 15) && write_enable;

generate;
    genvar i;

    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_0 (
        .DOA(SPRITE_RAM_0_DOUT_A),
        .DOB(SPRITE_RAM_0_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_0_WEN),
        .WEB(SPRITE_RAM_0_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_1 (
        .DOA(SPRITE_RAM_1_DOUT_A),
        .DOB(SPRITE_RAM_1_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_1_WEN),
        .WEB(SPRITE_RAM_1_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_2 (
        .DOA(SPRITE_RAM_2_DOUT_A),
        .DOB(SPRITE_RAM_2_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_2_WEN),
        .WEB(SPRITE_RAM_2_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_3 (
        .DOA(SPRITE_RAM_3_DOUT_A),
        .DOB(SPRITE_RAM_3_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_3_WEN),
        .WEB(SPRITE_RAM_3_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_4 (
        .DOA(SPRITE_RAM_4_DOUT_A),
        .DOB(SPRITE_RAM_4_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_4_WEN),
        .WEB(SPRITE_RAM_4_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_5 (
        .DOA(SPRITE_RAM_5_DOUT_A),
        .DOB(SPRITE_RAM_5_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_5_WEN),
        .WEB(SPRITE_RAM_5_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_6 (
        .DOA(SPRITE_RAM_6_DOUT_A),
        .DOB(SPRITE_RAM_6_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_6_WEN),
        .WEB(SPRITE_RAM_6_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_7 (
        .DOA(SPRITE_RAM_7_DOUT_A),
        .DOB(SPRITE_RAM_7_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_7_WEN),
        .WEB(SPRITE_RAM_7_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_8 (
        .DOA(SPRITE_RAM_8_DOUT_A),
        .DOB(SPRITE_RAM_8_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_8_WEN),
        .WEB(SPRITE_RAM_8_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_9 (
        .DOA(SPRITE_RAM_9_DOUT_A),
        .DOB(SPRITE_RAM_9_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_9_WEN),
        .WEB(SPRITE_RAM_9_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_10 (
        .DOA(SPRITE_RAM_10_DOUT_A),
        .DOB(SPRITE_RAM_10_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_10_WEN),
        .WEB(SPRITE_RAM_10_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_11 (
        .DOA(SPRITE_RAM_11_DOUT_A),
        .DOB(SPRITE_RAM_11_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_11_WEN),
        .WEB(SPRITE_RAM_11_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_12 (
        .DOA(SPRITE_RAM_12_DOUT_A),
        .DOB(SPRITE_RAM_12_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_12_WEN),
        .WEB(SPRITE_RAM_12_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_13 (
        .DOA(SPRITE_RAM_13_DOUT_A),
        .DOB(SPRITE_RAM_13_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_13_WEN),
        .WEB(SPRITE_RAM_13_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_14 (
        .DOA(SPRITE_RAM_14_DOUT_A),
        .DOB(SPRITE_RAM_14_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_14_WEN),
        .WEB(SPRITE_RAM_14_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );


    BRAM_TDP_MACRO #(
        .BRAM_SIZE("36Kb"),
        .DEVICE("7SERIES"),
        .READ_WIDTH_A(8),
        .READ_WIDTH_B(8),
        .WRITE_WIDTH_A(8),
        .WRITE_WIDTH_B(8)
    ) SPRITE_RAM_15 (
        .DOA(SPRITE_RAM_15_DOUT_A),
        .DOB(SPRITE_RAM_15_DOUT_B),
        .DIA(DIN_0),
        .DIB(DIN_1),
        .ADDRA(WRITE_ADDRESS_LOCATION),
        .ADDRB(WRITE_ADDRESS_LOCATION),
        .WEA(SPRITE_RAM_15_WEN),
        .WEB(SPRITE_RAM_15_WEN),
        .ENA(ENA),
        .ENB(ENB),
        .RSTA(~ENA),
        .RSTB(~ENB),
        .CLKA(clk),
        .CLKB(clk)
    );

endgenerate


always_comb begin
    read_data = {
        SPRITE_RAM_0_DOUT_A,
        SPRITE_RAM_0_DOUT_B,
        SPRITE_RAM_1_DOUT_A,
        SPRITE_RAM_1_DOUT_B,
        SPRITE_RAM_2_DOUT_A,
        SPRITE_RAM_2_DOUT_B,
        SPRITE_RAM_3_DOUT_A,
        SPRITE_RAM_3_DOUT_B,
        SPRITE_RAM_4_DOUT_A,
        SPRITE_RAM_4_DOUT_B,
        SPRITE_RAM_5_DOUT_A,
        SPRITE_RAM_5_DOUT_B,
        SPRITE_RAM_6_DOUT_A,
        SPRITE_RAM_6_DOUT_B,
        SPRITE_RAM_7_DOUT_A,
        SPRITE_RAM_7_DOUT_B,
        SPRITE_RAM_8_DOUT_A,
        SPRITE_RAM_8_DOUT_B,
        SPRITE_RAM_9_DOUT_A,
        SPRITE_RAM_9_DOUT_B,
        SPRITE_RAM_10_DOUT_A,
        SPRITE_RAM_10_DOUT_B,
        SPRITE_RAM_11_DOUT_A,
        SPRITE_RAM_11_DOUT_B,
        SPRITE_RAM_12_DOUT_A,
        SPRITE_RAM_12_DOUT_B,
        SPRITE_RAM_13_DOUT_A,
        SPRITE_RAM_13_DOUT_B,
        SPRITE_RAM_14_DOUT_A,
        SPRITE_RAM_14_DOUT_B,
        SPRITE_RAM_15_DOUT_A,
        SPRITE_RAM_15_DOUT_B
    };
end
endmodule
