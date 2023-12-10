`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/09/2023 11:28:33 PM
// Design Name: 
// Module Name: chess_logic
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


module chess_logic(
    reset, 
    clk, //25 MHz 
    redVGA, greenVGA, blueVGA, horizontalVGA, verticalVGA, 
    BTNC, BTNU, BTND, BTNR, BTNL
    );
    
    input reset, clk;
    input BTNU, BTNC, BTND, BTNR, BTNL;
    output redVGA, greenVGA, blueVGA, horizontalVGA, verticalVGA;
    
endmodule
