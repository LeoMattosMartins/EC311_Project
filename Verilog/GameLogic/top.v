`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
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
   
    //Reset
    input resetSwitch;
    wire reset;
    assign reset = resetSwitch;
    
    //Clock Management
    input boardCLK;
    wire vgaCLK, gameCLK;
    clock_divider divide(.boardCLK(boardCLK), .vgaCLK(vgaCLK), .gameCLK(gameCLK), .reset(reset));
    
    //VGA Instantiations
    output wire [3:0] redVGA;
    output wire [3:0] greenVGA; 
    output wire [3:0] blueVGA;
    output wire horizontalVGA, verticalVGA;
    
    //Button Management
    input BTNC, BTNU, BTND, BTNR, BTNL;
    wire cleanBTNC, cleanBTNU, cleanBTND, cleanBTNR, cleanBTNL;
    button_debouncer debounceUp(.clk(gameCLK), .reset(reset), .BTN(BTNU), .clean(cleanBTNU));
    button_debouncer debounceDown(.clk(gameCLK), .reset(reset), .BTN(BTND), .clean(cleanBTND));
    button_debouncer debounceRight(.clk(gameCLK), .reset(reset), .BTN(BTNR), .clean(cleanBTNR));
    button_debouncer debounceLeft(.clk(gameCLK), .reset(reset), .BTN(BTNL), .clean(cleanBTNL));
    button_debouncer debounceCenter(.clk(gameCLK), .reset(reset), .BTN(BTNC), .clean(cleanBTNC));
    
    //Game Logic
    chess_logic create(
    .reset(reset), 
    .clk(gameCLK),
    .redVGA(redVGA),
    .greenVGA(greenVGA),
    .blueVGA(blueVGA),
    .horizontalVGA(horizontalVGA),
    .verticalVGA(verticalVGA),
    .BTNC(cleanBTNC),
    .BTNU(cleanBTNU),
    .BTND(cleanBTND),
    .BTNR(cleanBTNR),
    .BTNL(cleanBTNL)
    //pass the chessboard/its current state somehow to the VGA
    //pass the cursor position and whether it's on or off somehow to VGA
    //probably some other stuff too idk yet
     );
    
    //Display on the VGA
    
    
endmodule
