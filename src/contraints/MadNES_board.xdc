## This file is a general .xdc for the Arty A7-100 Rev. D
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets {u_ebi_interface/Q}];
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets {u_ebi_interface/data_ready_i_2}];
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets {u_ebi_interface/not_A_n_0}];
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets {u_ebi_interface/not_A_n_0_0}];
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets {u_ebi_interface/not_A__0_n_0}];
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets {clock_640x480/data_ready_i_2_n_0}];

## Master Clock: 100 MHz
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports {clk_100m}];
create_clock -period 10.000 -name clk_100m [get_ports {clk_100m}];

## EBI

set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[0]}];
set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[1]}];
set_property -dict {PACKAGE_PIN A12 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[2]}];
set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[3]}];
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[4]}];
set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[5]}];
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[6]}];
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[7]}];
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[8]}];
set_property -dict {PACKAGE_PIN B10 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[9]}];
set_property -dict {PACKAGE_PIN A9 IOSTANDARD LVCMOS33} [get_ports  {EBI_AD[10]}];
set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33} [get_ports {EBI_AD[11]}];
set_property -dict {PACKAGE_PIN B9 IOSTANDARD LVCMOS33} [get_ports  {EBI_AD[12]}];
set_property -dict {PACKAGE_PIN C9 IOSTANDARD LVCMOS33} [get_ports  {EBI_AD[13]}];
set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS33} [get_ports  {EBI_AD[14]}];
set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS33} [get_ports  {EBI_AD[15]}];

set_property -dict {PACKAGE_PIN C8 IOSTANDARD LVCMOS33} [get_ports  {bank_select[0]}];
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports {bank_select[1]}];
set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports  {bank_select[2]}];
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {bank_select[3]}];

set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports {EBI_RE}];
set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVCMOS33} [get_ports {EBI_WE}];
set_property -dict {PACKAGE_PIN E11 IOSTANDARD LVCMOS33} [get_ports {EBI_ALE}];

## SPI MCU

#set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports {div_clk[23]}]; 
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports {vga_frame_done}]; # MISO
#set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS33} [get_ports {div_clk[25]}]; 
#set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports {div_clk[26]}];

## SPI SD

#set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {div_clk[27]}];
#set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {div_clk[28]}];
#set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {div_clk[29]}];
#set_property -dict {PACKAGE_PIN K12 IOSTANDARD LVCMOS33} [get_ports {div_clk[30]}];
#set_property -dict {PACKAGE_PIN N11 IOSTANDARD LVCMOS33} [get_ports {div_clk[31]}];

## SRAM

#set_property -dict {PACKAGE_PIN P10 IOSTANDARD LVCMOS33} [get_ports {div_clk[32]}];
#set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {div_clk[33]}];
#set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {div_clk[34]}];
#set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports {div_clk[35]}];
#set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {div_clk[36]}];
#set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {div_clk[37]}];
#set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {div_clk[38]}];
#set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {div_clk[39]}];
#set_property -dict {PACKAGE_PIN T13 IOSTANDARD LVCMOS33} [get_ports {div_clk[40]}];
#set_property -dict {PACKAGE_PIN R12 IOSTANDARD LVCMOS33} [get_ports {div_clk[41]}];
#set_property -dict {PACKAGE_PIN T12 IOSTANDARD LVCMOS33} [get_ports {div_clk[42]}];
#set_property -dict {PACKAGE_PIN P11 IOSTANDARD LVCMOS33} [get_ports {div_clk[43]}];
#set_property -dict {PACKAGE_PIN R11 IOSTANDARD LVCMOS33} [get_ports {div_clk[44]}];
#set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {div_clk[45]}];
#set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {div_clk[46]}];
#set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {div_clk[47]}];
#set_property -dict {PACKAGE_PIN P9 IOSTANDARD LVCMOS33} [get_ports {div_clk[48]}];
#set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {div_clk[49]}];
#set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {div_clk[50]}];
#set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {div_clk[51]}];
#set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {div_clk[52]}];
#set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {div_clk[53]}];

#set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports {div_clk[54]}];
#set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {div_clk[55]}];
#set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS33} [get_ports {div_clk[56]}];
#set_property -dict {PACKAGE_PIN R3 IOSTANDARD LVCMOS33} [get_ports {div_clk[57]}];
#set_property -dict {PACKAGE_PIN T4 IOSTANDARD LVCMOS33} [get_ports {div_clk[58]}];
#set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports {div_clk[59]}];
#set_property -dict {PACKAGE_PIN R7 IOSTANDARD LVCMOS33} [get_ports {div_clk[60]}];
#set_property -dict {PACKAGE_PIN R8 IOSTANDARD LVCMOS33} [get_ports {div_clk[61]}];
#set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {div_clk[62]}];
#set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {div_clk[63]}];
#set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {div_clk[64]}];
#set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports {div_clk[65]}];
#set_property -dict {PACKAGE_PIN R5 IOSTANDARD LVCMOS33} [get_ports {div_clk[66]}];
#set_property -dict {PACKAGE_PIN R6 IOSTANDARD LVCMOS33} [get_ports {div_clk[67]}];
#set_property -dict {PACKAGE_PIN T7 IOSTANDARD LVCMOS33} [get_ports {div_clk[68]}];
#set_property -dict {PACKAGE_PIN T8 IOSTANDARD LVCMOS33} [get_ports {div_clk[69]}];

#set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVCMOS33} [get_ports {div_clk[70]}];
#set_property -dict {PACKAGE_PIN N6 IOSTANDARD LVCMOS33} [get_ports {div_clk[71]}];
#set_property -dict {PACKAGE_PIN P8 IOSTANDARD LVCMOS33} [get_ports {div_clk[72]}];
#set_property -dict {PACKAGE_PIN N13 IOSTANDARD LVCMOS33} [get_ports {div_clk[73]}];
#set_property -dict {PACKAGE_PIN P13 IOSTANDARD LVCMOS33} [get_ports {div_clk[74]}];
#set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS33} [get_ports {div_clk[75]}];
#set_property -dict {PACKAGE_PIN N12 IOSTANDARD LVCMOS33} [get_ports {div_clk[76]}];



## VGA

#RED CHANNEL
#set_property -dict {PACKAGE_PIN C3 IOSTANDARD LVCMOS33} [get_ports {vga_r[0]}];
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {vga_r[0]}];
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {vga_r[1]}];
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {vga_r[2]}];
set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVCMOS33} [get_ports {vga_r[3]}];

#GREEN CHANNEL
#set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports {vga_g[0]}];
#set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {vga_g[1]}];
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {vga_g[0]}];
set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS33} [get_ports {vga_g[1]}];
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {vga_g[2]}];
set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports {vga_g[3]}];

#BLUE CHANNEL
#set_property -dict {PACKAGE_PIN A2 IOSTANDARD LVCMOS33} [get_ports {vga_b[0]}];
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {vga_b[0]}];
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports {vga_b[1]}];
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports {vga_b[2]}];
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {vga_b[3]}];

#SYNC

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports {vga_vsync}];
set_property -dict {PACKAGE_PIN D3 IOSTANDARD LVCMOS33} [get_ports {vga_hsync}];

## HDMI

#set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {div_clk[95]}];
#set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {div_clk[96]}];

#set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {div_clk[97]}];
#set_property -dict {PACKAGE_PIN A7 IOSTANDARD LVCMOS33} [get_ports {div_clk[98]}];

#set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports {div_clk[99]}];
#set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS33} [get_ports {div_clk[100]}];

#set_property -dict {PACKAGE_PIN F5 IOSTANDARD LVCMOS33} [get_ports {div_clk[101]}];
#set_property -dict {PACKAGE_PIN E5 IOSTANDARD LVCMOS33} [get_ports {div_clk[102]}];

#set_property -dict {PACKAGE_PIN G5 IOSTANDARD LVCMOS33} [get_ports {div_clk[103]}];
#set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {div_clk[104]}];

#set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {div_clk[105]}];
#set_property -dict {PACKAGE_PIN C6 IOSTANDARD LVCMOS33} [get_ports {div_clk[106]}];

## Header 1

#set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {div_clk[107]}];
#set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {div_clk[108]}];
#set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {div_clk[109]}];
#set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {div_clk[110]}];
#set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS33} [get_ports {div_clk[111]}];
#set_property -dict {PACKAGE_PIN D11 IOSTANDARD LVCMOS33} [get_ports {div_clk[112]}];
#set_property -dict {PACKAGE_PIN F12 IOSTANDARD LVCMOS33} [get_ports {div_clk[113]}];
#set_property -dict {PACKAGE_PIN G12 IOSTANDARD LVCMOS33} [get_ports {div_clk[114]}];
#set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {div_clk[115]}];
#set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {div_clk[116]}];
#set_property -dict {PACKAGE_PIN D16 IOSTANDARD LVCMOS33} [get_ports {div_clk[117]}];
#set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports {div_clk[118]}];
#set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports {div_clk[119]}];
#set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports {div_clk[120]}];
#set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {div_clk[121]}];
#set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports {div_clk[122]}];

## Header 2

#set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {div_clk[123]}];
#set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports {div_clk[124]}];
#set_property -dict {PACKAGE_PIN P6 IOSTANDARD LVCMOS33} [get_ports {div_clk[125]}];
#set_property -dict {PACKAGE_PIN M5 IOSTANDARD LVCMOS33} [get_ports {div_clk[126]}];
#set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports {div_clk[127]}];
#set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {div_clk[128]}];
#set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports {div_clk[129]}];
#set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {div_clk[130]}];
#set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports {div_clk[131]}];
#set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS33} [get_ports {div_clk[132]}];
#set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS33} [get_ports {div_clk[133]}];
#set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports {div_clk[134]}];
#set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVCMOS33} [get_ports {div_clk[135]}];
#set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {div_clk[136]}];
#set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {div_clk[137]}];
#set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {div_clk[138]}];

## Header 3

#set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {div_clk[139]}];
#set_property -dict {PACKAGE_PIN H13 IOSTANDARD LVCMOS33} [get_ports {div_clk[140]}];
#set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports {div_clk[141]}];
#set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports {div_clk[142]}];
#set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {div_clk[143]}];
#set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {div_clk[144]}];
#set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports {div_clk[145]}];
#set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {div_clk[146]}];
#set_property -dict {PACKAGE_PIN H11 IOSTANDARD LVCMOS33} [get_ports {div_clk[147]}];
#set_property -dict {PACKAGE_PIN M12 IOSTANDARD LVCMOS33} [get_ports {div_clk[148]}];
#set_property -dict {PACKAGE_PIN N9 IOSTANDARD LVCMOS33} [get_ports {div_clk[149]}];
#set_property -dict {PACKAGE_PIN H12 IOSTANDARD LVCMOS33} [get_ports {div_clk[150]}];
#set_property -dict {PACKAGE_PIN G11 IOSTANDARD LVCMOS33} [get_ports {div_clk[151]}];
#set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS33} [get_ports {div_clk[152]}];
#set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports {div_clk[153]}];
#set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33} [get_ports {div_clk[154]}];

## Header 4

#set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {div_clk[155]}];
#set_property -dict {PACKAGE_PIN K5 IOSTANDARD LVCMOS33} [get_ports {div_clk[156]}];
#set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports {div_clk[157]}];
#set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {div_clk[158]}];
#set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {div_clk[159]}];
#set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {div_clk[160]}];
#set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {div_clk[161]}];


##RESET

set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports {btn_rst}];

##JTAG

#set_property -dict { PACKAGE_PIN N7   IOSTANDARD LVCMOS33 } [get_ports { vet_ikke }]; #TDI
#set_property -dict { PACKAGE_PIN N8   IOSTANDARD LVCMOS33 } [get_ports { vet_ikke }]; #TDO
#set_property -dict { PACKAGE_PIN M7   IOSTANDARD LVCMOS33 } [get_ports { vet_ikke }]; #TMS
#set_property -dict { PACKAGE_PIN L7   IOSTANDARD LVCMOS33 } [get_ports { vet_ikke }]; #TCK

## Flash

#set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { div_clk[2] }]; # MOSI
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { div_clk[2] }]; # MISO
#set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { div_clk[6] }]; # WP
#set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { div_clk[7] }]; # RESET
#set_property -dict { PACKAGE_PIN L12   IOSTANDARD LVCMOS33 } [get_ports { div_clk[7] }]; # CS
#set_property -dict { PACKAGE_PIN E8   IOSTANDARD LVCMOS33 } [get_ports { div_clk[7] }]; # CLK
#set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { div_clk[7] }]; #SS

##PROGRAM, DONE, INIT

#set_property -dict { PACKAGE_PIN L9   IOSTANDARD LVCMOS33 } [get_ports { div_clk[7] }]; #PROGRAM_B
#set_property -dict { PACKAGE_PIN H10   IOSTANDARD LVCMOS33 } [get_ports { div_clk[7] }]; #DONE
#set_property -dict { PACKAGE_PIN K10   IOSTANDARD LVCMOS33 } [get_ports { div_clk[7] }]; #INIT_B

#set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design];
#set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design];
set_property CFGBVS VCCO [current_design];
set_property CONFIG_VOLTAGE 3.3 [current_design];
#set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design];
#set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design];
#set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design];
set_property BITSTREAM.CONFIG.UNUSEDPIN Pulldown [current_design];
