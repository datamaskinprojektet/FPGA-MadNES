module linedraw_tb();

    parameter VRAM_ADDR_SIZE=12;
    parameter VRAM_DATA_SIZE=128;
    parameter SECOND_ARRAY_SIZE=32;
    parameter OAM_ADDR_SIZE=8;
    parameter OAM_DATA_SIZE=32;
    parameter COLOR_DEPTH=8;
    parameter PALETTE_SIZE=256;
    parameter DISPLAY_WIDTH=600;
    parameter DISPLAY_HEIGHT=480;
    parameter LINE_NUMBER_WIDTH=$clog2(DISPLAY_WIDTH);

    logic           reset;
    logic           clk;
    logic [LINE_NUMBER_WIDTH - 1:0]     sx;
    logic [LINE_NUMBER_WIDTH - 1:0]     sy;

    logic enable;
    logic done;
    logic [OAM_ADDR_SIZE-1:0] oam_a;
    logic [OAM_DATA_SIZE-1:0] oam_d;
    logic [VRAM_ADDR_SIZE-1:0] vram_a;
    logic [VRAM_DATA_SIZE-1:0] vram_d;
    logic [OAM_ADDR_SIZE:0] second_array [SECOND_ARRAY_SIZE-1:0]; // [OAM_ADDR_SIZE:1] is address, [0] is active/inactive
    logic [DISPLAY_WIDTH-1:0][2:0][COLOR_DEPTH-1:0] line_buffer;

    sprite_drawer u_sprite_drawer (
        .clk(clk),
        .rst(reset),
        .enable(enable),
        .done(done),
        .oam_a(oam_a),
        .oam_d(oam_d),
        .vram_a(vram_a),
        .vram_d(vram_d),
        .second_array(second_array),
        .line_number(sy),
        .line_buffer(line_buffer)
    );

    prepare_line u_prepare_line (
        .clk                    (clk),
        .reset                  (reset),
        .oam_data               (oam_d),
        .sx                     (sx),
        .sy                     (sy),
        .oam_addr               (oam_a),
        .BufferArray            (second_array),
        .line_prepeared         (enable)
    );

    always #1 clk = ~clk; 
    always #1 sx++;

    task setup();
        foreach ( second_array[i] ) begin
            second_array[i] = 0;
        end
        reset = 1;
        clk = 1;
        sx = 0;
        sy = 0;
        oam_a = 0;
        oam_d = 0;
        vram_a = 0;
        vram_d = 0;
        #1;
        reset = 0;
    endtask

    initial begin
        setup();
        oam_d[31] = 1;
        #25;
        oam_d[31] = 0;
        vram_d = $urandom;
        #1600;
        $stop;
    end

endmodule