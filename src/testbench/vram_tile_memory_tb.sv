module vram_tile_memory_tb(

);

    logic clk;
    logic[11:0] read_addr;
    logic [255:0] read_data;

    logic write_enable;
    logic[14:0] write_addr;
    logic [15:0] write_data;


    vram_tile_memory TILE(

    .clk(clk),              // Clock to drive the RAM module
    .read_addr(read_addr),  // 12 bits to address 2048 sprite lines
    .write_addr(write_addr), // 15 bits to address 32768 pixel pairs
    .write_data(write_data),
    .write_enable(write_enable),

    .read_data(read_data)
    );


    initial begin
        clk = 0;
        write_addr = 0;
        write_data = $urandom%255;
        write_enable = 0;

        read_addr = 0;

        #50
        write_enable = 1;

        for(int i = 0; i < 32768; i++) begin
            #40
            write_addr += 1;
            write_data = $urandom%65535;
        end

        #20
        write_enable = 0;

        read_addr = 1;

        #40
        read_addr = 2;
    end

    always #20 clk = ~clk;


endmodule

