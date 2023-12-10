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
    //redVGA0, greenVGA0, blueVGA0,
    //redVGA1, greenVGA1,blueVGA1,
    //redVGA2, greenVGA2,blueVGA2,
    //redVGA3, greenVGA3, blueVGA3,
    resetSwitch 
    //horizontalVGA, 
    //verticalVGA
    );
   
    input boardCLK, resetSwitch;
    wire reset;
    assign reset = resetSwitch;
    
    wire vgaCLK, gameCLK;
    clock_divider divide(.boardCLK(boardCLK), .vgaCLK(vgaCLK), .gameCLK(gameCLK), .reset(reset));
    
endmodule
