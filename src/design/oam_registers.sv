`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2020 12:33:39
// Design Name: 
// Module Name: oam_registers
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module oam_registers(oam_register, object_enabled);
parameter OAMObjects = 64;

output logic [31:0] oam_register [ OAMObjects - 1 : 0];
output wire [OAMObjects - 1 :0] object_enabled;

/*
OAM: 2 16-bit addresses 
    8 bit spriteref
    10 bit x pos
    10 bit y pos
    1 bit priority
    1 bit x-flip
    1 bit y-flip
    1 bit enable
*/


generate;
  genvar i;
  for (i = 0; i < OAMObjects; i++) begin
    assign object_enabled[i] = (oam_register[i][31]);
  end
endgenerate


endmodule
