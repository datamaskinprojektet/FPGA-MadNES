`timescale 1ns / 1ps


module top_test_tb();

    parameter CLK_PERIOD = 10;  // 10 ns == 100 MHz

    logic clk;
    logic reset;
    logic [15:0] EBI_AD;
    logic EBI_ALE;
    logic EBI_RE;
    logic EBI_WE;
    logic [2:0] bank_select;
    logic vga_hsync;
    logic vga_vsync;
    // Expanded to 8 bit from 4 bits to get better colors
    logic [7:0] vga_r_8_bit;
    logic [7:0] vga_g_8_bit;
    logic [7:0] vga_b_8_bit;
    logic [3:0] vga_r;
    logic [3:0] vga_g;
    logic [3:0] vga_b;
    logic [50:0] clk_count;

    int fd;
    int data_sendt;
    assign vga_r_8_bit = {4'b0000, vga_r}; 
    assign vga_g_8_bit = {4'b0000, vga_g}; 
    assign vga_b_8_bit = {4'b0000, vga_b}; 
    display_driver dut_display_driver(
    .clk_100m        (clk),             
    .btn_rst         (!reset),             
    .EBI_AD          (EBI_AD),      
    .EBI_ALE         (EBI_ALE),       
    .EBI_RE          (EBI_RE),      
    .EBI_WE          (EBI_WE),      
    .bank_select     (bank_select),            
    .vga_hsync       (vga_hsync),             
    .vga_vsync       (vga_vsync),             
    .vga_r           (vga_r),       
    .vga_g           (vga_g),       
    .vga_b           (vga_b)       
    );                

    always #(CLK_PERIOD / 2) clk = ~clk;

    `include  "top_test_tb_data"

    task resetModule();

        reset = 0;
        clk = 1;
        EBI_AD = 0;
        EBI_ALE = 1;
        EBI_WE = 1;
        EBI_RE = 1;
        bank_select = 0;
        dut_display_driver.OAM.myram_gen[0].myram.memory = '{default:0};
        dut_display_driver.OAM.myram_gen[1].myram.memory = '{default:0};
        //dut_display_driver.TAM.TAM_RAM = '{default:0};
        //dut_display_driver.SPRITE.myram_gen[0].myram.memory = '{default:0};
        //dut_display_driver.SPRITE.myram_gen[1].myram.memory = '{default:0};
        //dut_display_driver.SPRITE.myram_gen[2].myram.memory = '{default:0};
        //dut_display_driver.SPRITE.myram_gen[3].myram.memory = '{default:0};
        //dut_display_driver.SPRITE.myram_gen[4].myram.memory = '{default:0};
        //dut_display_driver.SPRITE.myram_gen[5].myram.memory = '{default:0};
        //dut_display_driver.SPRITE.myram_gen[6].myram.memory = '{default:0};
        //dut_display_driver.SPRITE.myram_gen[7].myram.memory = '{default:0};
        #1;
        reset = 1;
        clk_count = 0;
        #100;
        reset = 0;
        #3000;
    endtask

    always @ (posedge dut_display_driver.clk_pix)
    begin
        clk_count++;
        if(dut_display_driver.de)
        begin
            $fwrite(fd,"%d,%d,%d,%d,%d\n",dut_display_driver.sx,dut_display_driver.sy,(vga_r_8_bit << 4),(vga_g_8_bit << 4),(vga_b_8_bit << 4));
        end
    end
    always @ (posedge dut_display_driver.clk_pix)
    begin
        if (clk_count == 10)
        begin
            write_oam_data();
            write_sprite_data();
            write_pallet_data();
        end
    end

    initial begin
    fd = $fopen("display_data.txt","w"); //Opening file for write
    resetModule();
    $display("topmodule testing");
    //#18_000_000; // 18 ms (one frame is 16.7 ms)
    wait(vga_vsync== 1'b0);
    @(posedge dut_display_driver.clk_pix);
    $fclose(fd);
    $finish; 
    end

endmodule
