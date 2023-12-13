`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 04:07:12 AM
// Design Name: 
// Module Name: scanStraight
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

//UNFINISHED
module scanStraight(
    input clk, 
    input [5:0] currentPosition,
    input [1:0] direction, 
    output [5:0] nearestPosition, //Location of the closest piece in that direction
    output [2:0] nearestPiece //Type of piece of the closest piece 
    );
    
    //DEFINE DIRECTIONS
    localparam UP = 2'b00;
    localparam LEFT = 2'b01;
    localparam RIGHT = 2'b10;
    localparam DOWN = 2'b11;
   
    //LOCAL VARIABLES
    reg counter;
    
    always @(posedge clk) begin
        case(direction)
        
            UP: begin
            i = spaces between this and up
            for i
                currentPosition = (;
            end
            
            DOWN: begin
            end
            
            RIGHT: begin
            end
            
            LEFT: begin
            end
            
            endcase     
    end
    
    
    
    
    
    
    
    
endmodule
