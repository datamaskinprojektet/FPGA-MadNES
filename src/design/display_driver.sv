`default_nettype none
`timescale 1ns / 1ps

module display_driver (
    input       wire logic clk_100m,     // 100 MHz clock
    input       wire logic btn_rst,      // reset button (active low)

    // Input for EBI interface
    input       wire [15:0] EBI_AD,
    input       wire EBI_ALE,
    input       wire EBI_CS,
    input       wire EBI_RE,
    input       wire EBI_WE,

    output      logic vga_hsync,    // horizontal sync
    output      logic vga_vsync,    // vertical sync
    output      logic [3:0] vga_r,  // 4-bit VGA red
    output      logic [3:0] vga_g,  // 4-bit VGA green
    output      logic [3:0] vga_b   // 4-bit VGA blue
    );

    
    // generate pixel clock
    logic clk_pix;
    logic clk_locked;
    clock_gen clock_640x480 (
       .clk(clk_100m),
       .rst(!btn_rst),  // reset button is active low
       .clk_pix,
       .clk_locked
    );

    // display timings
    localparam CORDW = 10;  // screen coordinate width in bits
    logic [CORDW-1:0] sx, sy;
    logic de;
    display_timings timings_640x480 (
        .clk_pix,
        .rst(!clk_locked),  // wait for clock lock
        .sx(sx),
        .sy(sy),
        .hsync(vga_hsync),
        .vsync(vga_vsync),
        .de
    );

    logic [11:0] data_out;
    logic [15:0] read_address;
    logic [15:0] data_inn;
    logic [15:0] write_address;
    logic write_enable;
    logic data_ready;
    
    ebi_interface u_ebi_interface (
        // Assuming 16-bit bus multiplexing and write only
        .EBI_AD         (EBI_AD),
        .EBI_ALE        (EBI_ALE),
        .EBI_CS         (EBI_CS),
        .EBI_RE         (EBI_RE),
        .EBI_WE         (EBI_WE),
        .reset          (!btn_rst),
        .clk            (clk_pix),
        .address_out    (write_address),
        .data_out       (data_inn),
        .data_ready     (write_enable)
    );
    
    
    ram_16x12d_infer u_ram_16x12d_infer (
        .data_out         (data_out),
        .write_enable     (write_enable),
        .data_inn         (data_inn),
        .read_address     (read_address),
        .write_address    (write_address),
        .clk              (clk_pix)
    );

    //logic [11:0] addr_counter;
    //assign write_address = addr_counter; 
    assign read_address = {sx[9:5],sy[9:5]};
    
    /*
    assign write_enable = 1;
    always_ff @(posedge clk_pix) begin
        addr_counter <= addr_counter + 1;
        data_inn <= addr_counter[11:0];
        
    end
    */

    // size of screen (excluding blanking)
    localparam H_RES = 640;
    localparam V_RES = 480;

    logic animate;  // high for one clock tick at start of blanking
    always_comb animate = (sy == 480 && sx == 0);

    // VGA output
    always_comb begin
        vga_r = !de ? 4'h0 : data_out[11:8];
        vga_g = !de ? 4'h0 : data_out[7:4];
        vga_b = !de ? 4'h0 : data_out[3:0];
    end
endmodule
