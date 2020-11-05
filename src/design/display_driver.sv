`timescale 1ns / 1ps

module display_driver (
    input       wire logic clk_100m,     // 100 MHz clock
    input       wire logic btn_rst,      // reset button (active low)

    // Input for EBI interface
    input       wire [15:0] EBI_AD,
    input       wire EBI_ALE,
    // input       wire EBI_CS, // DEPRECATED: Use bank_select instead
    input       wire EBI_RE,
    input       wire EBI_WE,
    input       wire [2:0] bank_select, // TODO: Map pins in constraints file

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
    logic [CORDW-1:0] sx, sy, sx_next, last_y;
    logic de;
    display_timings timings_640x480 (
        .clk_pix,
        .rst     ( !clk_locked ) ,  // wait for clock lock
        .sx      ( sx          ) ,
        .sy      ( sy          ) ,
        .sx_next ( sx_next     ) ,
        .hsync   ( vga_hsync   ) ,
        .vsync   ( vga_vsync   ) ,
        .de
    );

    logic [11:0] data_out;
    logic [15:0] read_address;
    logic [15:0] mcu_write_data;
    logic [15:0] mcu_write_address;
    logic write_enable;

    wire write_enable_oam;
    wire write_enable_vram_sprite;
    wire write_enable_vram_tile;
    wire write_enable_palette;
    wire write_enable_tam;

    assign write_enable_oam         = (bank_select == 0) & write_enable;
    assign write_enable_vram_sprite = (bank_select == 1) & write_enable;
    assign write_enable_vram_tile   = (bank_select == 2) & write_enable;
    assign write_enable_palette     = (bank_select == 3) & write_enable;
    assign write_enable_tam         = (bank_select == 4) & write_enable;


    ebi_interface u_ebi_interface (
        // Assuming 16-bit bus multiplexing and write only
        .EBI_AD         (EBI_AD),
        .EBI_ALE        (EBI_ALE),
        .EBI_RE         (EBI_RE),
        .EBI_WE         (EBI_WE),
        .reset          (!btn_rst),
        .clk            (clk_pix),
        .address_out    (mcu_write_address),
        .data_out       (mcu_write_data),
        .data_ready     (write_enable)
    );

    wire [5:0] oam_read_address;
    wire [31:0] oam_read_data;

    oam_memory OAM(
        .clk          (clk_pix),                // Clock to drive the RAM module
        .reset        (!btn_rst),
        .read_addr    (oam_read_address),       // 5 bits to address 64 locations
        .write_addr   (mcu_write_address[6:0]), // 6 bits to address 128 locations
        .write_data   (mcu_write_data),
        .write_enable (write_enable_oam),

        .read_data(oam_read_data)
    );

    wire [15:0] tam_read_data;
    wire [9:0] tam_read_address;

    tam_memory TAM(
        .clk          (clk_pix),           // Clock to drive the RAM module
        .read_addr    (tam_read_address),  // 5 bits to address 64 locations
        .write_addr   (mcu_write_address[6:0]), // 6 bits to address 128 locations
        .write_data   (mcu_write_data),
        .write_enable (write_enable_tam),

        .read_data    (tam_read_data)

    );

    wire[11:0] sprite_read_address;
    wire[127:0] sprite_read_data;

    vram_16b_x_8_x_4096 SPRITE(
        .clk          (clk_pix),              // Clock to drive the RAM module
        .read_addr    (sprite_read_address),  // 5 bits to address 64 locations
        .write_addr   (mcu_write_address[14:0]), // 6 bits to address 128 locations
        .write_data   (mcu_write_data),
        .write_enable (write_enable_vram_sprite),

        .read_data    (sprite_read_data)
    );

    wire[11:0] tile_read_address;
    wire[127:0] tile_read_data;

    vram_16b_x_8_x_4096 TILE(
        .clk          (clk_pix),                 // Clock to drive the RAM module
        .read_addr    (tile_read_address),       // 5 bits to address 64 locations
        .write_addr   (mcu_write_address[14:0]), // 6 bits to address 128 locations
        .write_data   (mcu_write_data),
        .write_enable (write_enable_vram_tile),
        .read_data    (tile_read_data)
    );

    wire[8:0] palette_read_addr;
    wire[23:0] palette_read_data;

    palette_memory PALETTE(
        .clk          (clk_pix),                // Clock to drive the RAM module
        .read_addr    (palette_read_addr),      // 9 bits to address 512 locations
        .write_addr   (mcu_write_address[7:0]), // 8 bits to address 256 locations
        .write_data   (mcu_write_data),
        .write_enable (write_enable_palette),
        .read_data    (palette_read_data)       // One palette entry is 24 bits
    );

    wire prepare_line_done;
    logic [32 - 1 : 0][8:0] LineObjectArray;
    wire [5:0] oam_read_address_prepare_line, oam_read_address_draw_sprite;
    assign oam_read_address = prepare_line_done ? oam_read_address_draw_sprite : oam_read_address_prepare_line;
    
    prepare_line #(
        .maxObjectPerLine(32), 
        .OAMMaxObjects(256)
    ) prepare_line (
        .clk            (clk_pix),
        .reset          (!btn_rst),
        .oam_data       (oam_read_data),
        .sx             (sx),
        .sy             (sy),
        .oam_addr       (oam_read_address_prepare_line),
        .BufferArray    (LineObjectArray),
        .line_prepeared (prepare_line_done)
    );

    wire sprite_drawer_done;
    sprite_drawer #(
        .VRAM_ADDR_SIZE       (12),
        .VRAM_DATA_SIZE       (128),
        .SECOND_ARRAY_SIZE    (32),
        .OAM_ADDR_SIZE        (6),
        .OAM_DATA_SIZE        (32),
        .COLOR_DEPTH          (8),
        .DISPLAY_WIDTH        (600),
        .DISPLAY_HEIGHT       (480),
        .LINE_NUMBER_WIDTH    ($size(sy))
    ) u_sprite_drawer (
        .clk             (clk_pix),
        .rst             (!btn_rst),
        .enable          (prepare_line_done),
        .done            (sprite_drawer_done),
        .oam_a           (oam_read_address_draw_sprite),
        .oam_d           (oam_read_data),
        .vram_a          (sprite_read_address),
        .vram_d          (sprite_read_data),
        .second_array    (LineObjectArray),
        .line_number     (sy),
        .line_buffer     (LineBuffer_next_line)
    );
    
    logic [CORDW-1:0][7:0] LineBuffer_next_line;
    logic [CORDW-1:0][7:0] LineBuffer_current_line;
    always_ff @(posedge clk_pix) begin
        if (last_y != sy) begin
            LineBuffer_current_line <= LineBuffer_next_line;
        end
        last_y <= sy;
    end

    assign palette_read_addr = !de ? 8'h0 : LineBuffer_current_line[sx_next];


    wtf_is_wrong ILA(
        .clk     ( clk_pix                  ) ,
        .probe0  ( palette_read_data[23:20] ) ,
        .probe1  ( palette_read_data[15:11] ) ,
        .probe2  ( palette_read_data[7:4]   ) ,
        .probe3  ( sy                       ) ,
        .probe4  ( last_y                   ) ,
        .probe5  ( mcu_write_data           ) ,
        .probe6  ( EBI_WE                   ) ,
        .probe7  ( EBI_ALE                  ) ,
        .probe8  ( write_enable_oam         ) ,
        .probe9  ( write_enable_tam         ) ,
        .probe10 ( write_enable_vram_sprite ) ,
        .probe11 ( write_enable_vram_tile   ) ,
        .probe12 ( write_enable_palette     ) ,
        .probe13 ( mcu_write_address        ) ,
        .probe14 ( EBI_AD                   ) ,
        .probe15 ( bank_select[0]           ) ,
        .probe16 ( bank_select[1]           ) ,
        .probe17 ( bank_select[2]           ) ,
        .probe18 ( write_enable             ) 
    );


    // size of screen (excluding blanking)
    localparam H_RES = 640;
    localparam V_RES = 480;

    logic animate;  // high for one clock tick at start of blanking
    always_comb animate = (sy == 480 && sx == 0);

    // VGA output
    always_comb begin
        vga_r = !de ? 4'h0 : palette_read_data[23:20];
        vga_g = !de ? 4'h0 : palette_read_data[15:11];
        vga_b = !de ? 4'h0 : palette_read_data[7:4];
    end
endmodule
