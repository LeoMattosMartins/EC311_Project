`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/13/2023 04:14:26 AM
// Design Name: 
// Module Name: scanSpots
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


module scanSpots(
    input clk, 
    input [255:0] bigBoard,
    input [5:0] currentPosition,
    input [2:0] direction, 
    output reg [5:0] nearestPosition, //Location of the closest piece in that direction
    output reg [2:0] nearestPiece //Type of piece of the closest piece 
    );
    
    //DEFINE DIRECTIONS
    localparam UPLEFTLEFT = 2'b0000;
    localparam  UPUPLEFT = 2'b0001;
    localparam  UPUPRIGHT = 2'b0010;
    localparam  UPRIGHTRIGHT = 2'b0011;
    localparam  RIGHTRIGHTDOWN = 2'b0100;
    localparam  RIGHTDOWNDOWN = 2'b0101;
    localparam  LEFTDOWNDOWN = 2'b0110;
    localparam  LEFTLEFTDOWN = 2'b0111;
   
    //LOCAL VARIABLES
    wire edgeDistance0 = (currentPosition/8 > currentPosition%8) ? (currentPosition%8) : (currentPosition/8); 
    wire edgeDistance1 = ((7-currentPosition/8) > currentPosition%8) ? (currentPosition%8) : (7-currentPosition/8); 
    wire edgeDistance2 = (currentPosition/8 > (7-currentPosition%8)) ? (7-currentPosition%8) : (currentPosition/8); 
    wire edgeDistance3 = ((7-currentPosition/8) > (7-currentPosition%8)) ? (7-currentPosition%8) : (7-currentPosition/8); 
    
    //GENERATE 3-D Board
    genvar r;
    wire [3:0] board[63:0];
    generate for(r=0; r<256; r=r+4) begin 
        assign board[(r/4)][3:0] = bigBoard[(r+3):r];
    end
    endgenerate
    
    always @(posedge clk) begin
        case(direction)
        
            UPLEFTLEFT: begin    
                if(currentPosition%8 >= 2 && currentPosition/8 >= 1) begin
                end    else //Consider what the value of the return address and piece are given nothing. Have a default case in all scenarios and instantiate
            end
            
            UPUPLEFT: begin
                if(currentPosition%8 >= 1 && currentPosition/8 >= 2) begin
                end
            end
            
            UPUPRIGHT: begin
                if((7-(currentPosition%8)) >= 1 && currentPosition/8 >= 2) begin
                end
            end
            
            UPRIGHTRIGHT: begin
                if((7-(currentPosition%8)) >= 2 && currentPosition/8 >= 1) begin
                end
            end

            RIGHTRIGHTDOWN begin
                if((7-(currentPosition%8)) >= 2 && (7-(currentPosition/8)) >= 1) begin
                end
            end

            RIGHTDOWNDOWN begin
                if((7-(currentPosition%8)) >= 1 && (7-(currentPosition/8)) >= 2) begin
                end
            end

            LEFTDOWNDOWN begin
                if(currentPosition%8 >= 1 && (7-(currentPosition/8)) >= 2) begin
                end 
            end

            LEFTLEFTDOWN begin
                if(currentPosition%8 >= 2 && (7-(currentPosition/8)) >= 1) begin
                end 
            end
            
            endcase     
    end
    
 
endmodule
