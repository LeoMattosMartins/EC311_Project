`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Leonardo Mattos Martins
// 
// Create Date: 12/11/2023 11:17:38 PM
// Design Name: 
// Module Name: checkAllow
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
/*
00 08 16 24 32 40 48 56
01 09 17 25 33 41 49 57
02 10 18 26 34 42 50 58 
03 11 19 27 35 43 51 59 
04 12 20 28 36 44 52 60
05 13 21 29 37 45 53 61
06 14 22 30 38 46 54 62 
07 15 23 31 39 47 55 63

White on the bottom
*/

module checkAllow(
    input  [13:0] moveData,
    input [255:0] boardInput,
    input clk,
    output wire allowMove,
    output wire [3:0] leds                                                   
    );  
    
    wire [5:0] currentPosition = moveData[11:6];
    wire [5:0] targetPosition = moveData[5:0]; 
    
    wire [3:0] currentPiece;
    wire [3:0] targetPiece; 
    
    checkSquare c1(.desiredSquare(currentPosition), .boardInput(boardInput), .desiredPiece(currentPiece));
    checkSquare c2(.desiredSquare(targetPosition), .boardInput(boardInput), .desiredPiece(targetPiece));
    
    checkColour c3(.currentPiece(currentPiece), .targetPiece(targetPiece), .allowColour(allowColour));
    checkPath c4(.currentPiece(currentPiece), .targetPiece(targetPiece), .allowPath(allowPath));
    checkDistance c5(.clk(clk), .currentPosition(currentPosition), .targetPosition(targetPosition), .currentPiece(currentPiece), .targetPiece(targetPiece), .allowDistance(allowDistance));
    
    assign allowMove = (allowColour && allowPath && allowDistance);
    
    assign leds = {allowColour, allowPath, allowDistance, 1'b1};                                  //CHANGED
    
endmodule
