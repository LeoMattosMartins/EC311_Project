`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 04:03:09 AM
// Design Name: 
// Module Name: checkCheck
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


module checkCheck(
    input clk, 
    input bigBoard,
    input currentPosition,
    output inCheck
    //how do you output the number of pieces and their locations/types of all the pieces chacking the king. Maybe a large array where each bit represents check from one position on the board. then you just send that array. 
    );
    
    scanDiagonal scan1(.clk(clk), );
    if(returnPiece == Bishop or Queen or (Pawn and currpos - return pos == 1)
        inCheck == 1;
    scanDiagonal scan2();
    scanDiagonal scan3();
    scanDiagonal scan4();
    scanStraight scan5();
    scanStraight scan6();
    scanStraight scan7();
    scanStraight scan8();
    scanSpots scan9();
    scanSpots scan10();
    scanSpots scan11();
    scanSpots scan12();
    scanSpots scan13();
    scanSpots scan14();
    scanSpots scan15();
    scanSpots scan16();

                                            
    
endmodule
