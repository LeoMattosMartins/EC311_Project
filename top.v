`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 09:25:32 PM
// Design Name: 
// Module Name: top
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


module top(
    boardCLK, 
    redVGA, greenVGA, blueVGA,
    BTNC, BTNU, BTND, BTNR, BTNL,
    resetSwitch,
    horizontalVGA, 
    verticalVGA
    );
   
    input resetSwitch;
    wire reset;
    assign reset = resetSwitch;
    
    input boardCLK;
    wire vgaCLK, gameCLK;
    clock_divider divide(.boardCLK(boardCLK), .vgaCLK(vgaCLK), .gameCLK(gameCLK), .reset(reset));
    
    output wire [3:0] redVGA;
    output wire [3:0] greenVGA; 
    output wire [3:0] blueVGA;
    output wire horizontalVGA, verticalVGA;
    
    input BTNC, BTNU, BTND, BTNR, BTNL;
    
endmodule
