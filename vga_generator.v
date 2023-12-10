`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/10/2023 12:54:32 AM
// Design Name: 
// Module Name: vga_generator
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

//INTERPRETATION OF PROFESSOR'S EXAMPLE CODE
module vga_generator(
    input clk,
    input reset, 
    output horizontalVGA,
    output verticalVGA, 
    output [9:0] pixelX,
    output [9:0] pixelY
    );
    
    reg [9:0] linePosition = 10'b0000000000; //horizontal location
    reg [9:0] screenPosition = 10'b000000000000; //vertical location
    
    localparam STARTSYNCHORIZONTAL = 16; //Sync from 16-112
    localparam ENDSYNCHORIZONTAL = 112;
    localparam STARTSYNCVERTICAL = 490; //Sync from 490-492
    localparam ENDSYNCVERTICAL = 492;
    localparam STARTPIXELSHORIZONTAL = 160; //Pixels are drawn from 160-800 (640 width)
    localparam ENDPIXELSVERTICAL = 480; //Pixels are drawn from 0-480 (480 height)
    localparam ENDLINE = 800; //complete line (pixels)
    localparam ENDSCREEN = 525; //complete screen (lines)
    
    //Increment the columns and rows
    always@(posedge clk) begin
        if(reset) begin
            linePosition <= 0;
            screenPosition <= 0;
        end
        if(linePosition == ENDLINE) begin //end of line
            linePosition <= 0;
            screenPosition <= screenPosition + 1;
        end else begin 
            linePosition <= linePosition + 1;
        end
        if(screenPosition == ENDSCREEN) begin //end of screen
            screenPosition <= 0;
        end
    end
    
    //Assign pixelX and pixelY 
    //Keep within active pixels
    assign pixelX = (linePosition < STARTPIXELSHORIZONTAL) ? (0) : (linePosition - STARTPIXELSHORIZONTAL);
    assign pixelY = (screenPosition >= ENDPIXELSVERTICAL) ? (ENDPIXELSVERTICAL - 1) : (screenPosition);
    
    //Generate active low sync signals
    //Keep within sync area
    assign horizontalVGA = ~((linePosition >= STARTSYNCHORIZONTAL) & (linePosition < ENDSYNCHORIZONTAL));
    assign verticalVGA = ~((screenPosition >= STARTSYNCVERTICAL) & (screenPosition < ENDSYNCVERTICAL));
        
endmodule
