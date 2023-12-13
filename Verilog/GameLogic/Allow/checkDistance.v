`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Leonardo Mattos Martins
// 
// Create Date: 12/10/2023 08:24:49 PM
// Design Name: 
// Module Name: checkDistance
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

NEW !!
00 08 16 24 32 40 48 56
01 09 17 25 33 41 49 57
02 10 18 26 34 42 50 58
03 11 19 27 35 43 51 59
04 12 20 28 36 44 52 60
05 13 21 29 37 45 53 61
06 14 22 30 38 46 54 62 
07 15 23 31 39 47 55 63 


ROOKS


White on the bottom
*/

module checkDistance(
    input [5:0] targetPosition,
    input [5:0] currentPosition,
    input [3:0] currentPiece,
    input [3:0] targetPiece,
    input clk,
    output reg allowDistance
    );
    
    localparam  WHITE_EMPTY  = 4'b0000, 
                WHITE_KING   = 4'b0001,
                WHITE_QUEEN  = 4'b0010, 
                WHITE_BISHOP = 4'b0011,
                WHITE_KNIGHT = 4'b0100,
                WHITE_ROOK   = 4'b0101,
                WHITE_PAWN   = 4'b0110,
                
                BLACK_EMPTY  = 4'b1000, 
                BLACK_KING   = 4'b1001,
                BLACK_QUEEN  = 4'b1010, 
                BLACK_BISHOP = 4'b1011,
                BLACK_KNIGHT = 4'b1100,
                BLACK_ROOK   = 4'b1101,
                BLACK_PAWN   = 4'b1110;
    
    wire signed [6:0] distance = targetPosition - currentPosition;
    
    always @(posedge clk) begin
    case(currentPiece)
        
        WHITE_EMPTY: allowDistance = 0;
        BLACK_EMPTY: allowDistance = 0; 
       
        WHITE_KING: begin
            case(distance)
                 //horiztonal movement
                 -8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
                  8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
                 
                 //vertical movement 
                 -1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
                  1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
                 
                 //right diag
                 -7: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                  7: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                 
                //left diag 
                 -9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                  9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                  
                  default: allowDistance = 0;
             endcase
         end
         
        BLACK_KING: begin
             case(distance)
                 //horiztonal movement
                 -8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
                  8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
                 
                 //vertical movement 
                 -1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
                  1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
                 
                 //right diag
                 -7: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                  7: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                 
                //left diag 
                 -9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                  9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                  
                  default: allowDistance = 0;
             endcase
         end
         
        WHITE_KNIGHT: begin
             case(distance)
                -17: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == 2*(targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == 2*(currentPosition[5:3] - targetPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                -15: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == 2*(targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == 2*(currentPosition[5:3] - targetPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                -10: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == 2*(targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == 2*(currentPosition[5:3] - targetPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                 -6: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == 2*(targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == 2*(currentPosition[5:3] - targetPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                  6: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == 2*(targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == 2*(currentPosition[5:3] - targetPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                 10: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == 2*(targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == 2*(currentPosition[5:3] - targetPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                 15: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == 2*(targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == 2*(currentPosition[5:3] - targetPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                 17: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == 2*(targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == 2*(currentPosition[5:3] - targetPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || (2*(targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
                 default: allowDistance = 0;
             endcase
         end
         
        BLACK_KNIGHT: begin
             case(distance)
                -17: allowDistance = 1;
                -15: allowDistance = 1;
                -10: allowDistance = 1;
                 -6: allowDistance = 1;
                  6: allowDistance = 1;
                 10: allowDistance = 1;
                 15: allowDistance = 1;
                 17: allowDistance = 1;
                 default: allowDistance = 0;
             endcase
         end  
         
        WHITE_PAWN: begin
             case(distance)
                -17: allowDistance = 1;
                -16: allowDistance = 1;
                -15: allowDistance = 1;
                 -8: allowDistance = 1;
                 default: allowDistance = 0;
            endcase
        end
        
        BLACK_PAWN: begin
            case(distance)
                 17: allowDistance = 1;
                 16: allowDistance = 1;
                 15: allowDistance = 1;
                  8: allowDistance = 1;
                 default: allowDistance = 0;
            endcase
        end
        
        WHITE_BISHOP: begin
        case(distance)
            -63: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -56: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -54: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -49: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -45: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -42: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -36: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -35: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -28: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -27: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -21: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -18: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -14: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             -9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             -7: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
              7: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
              9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             14: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             18: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             21: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             27: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             28: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             35: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             36: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             42: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             45: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             49: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             54: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             56: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             63: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             default: allowDistance = 0;
         endcase
     end
     
        BLACK_BISHOP: begin
        case(distance)
            -63: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -56: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -54: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -49: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -45: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -42: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -36: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -35: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -28: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -27: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -21: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -18: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -14: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             -9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             -7: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
              7: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
              9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             14: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             18: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             21: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             27: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             28: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             35: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             36: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             42: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             45: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             49: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             54: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             56: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             63: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             default: allowDistance = 0;
         endcase
    end  
    
        WHITE_ROOK: begin
        case(distance)
             //Vertical movement 
             -7: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -6: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -5: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -4: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -3: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -2: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              2: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              3: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              4: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              5: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              6: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              7: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              
            //Horizontal movement
            -56: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -48: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -40: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -32: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -24: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -16: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             -8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
              8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             16: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             24: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             32: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             40: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             48: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             56: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             
             default: allowDistance = 0;
        endcase
    end
    
        BLACK_ROOK: begin
        case(distance)
             //Vertical movement 
             -7: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -6: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -5: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -4: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -3: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -2: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              2: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              3: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              4: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              5: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              6: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              7: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              
            //Horizontal movement
            -56: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -48: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -40: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -32: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -24: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -16: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             -8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
              8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             16: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             24: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             32: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             40: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             48: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             56: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             
             default: allowDistance = 0;
        endcase
    end
    
        WHITE_QUEEN: begin
        case(distance)
             //Special Case  
             -7: allowDistance = (targetPosition[2:0] == currentPosition[2:0]) || ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
              7: allowDistance = (targetPosition[2:0] == currentPosition[2:0]) || ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             
             //Vertical Movement
             -6: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -5: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -4: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -3: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -2: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              2: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              3: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              4: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              5: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              6: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              
            //Horizontal movement
            -56: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -48: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -40: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -32: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -24: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -16: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             -8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
              8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             16: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             24: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             32: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             40: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             48: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             56: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             
            -63: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -54: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -49: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -45: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -42: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -36: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -35: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -28: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -27: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -21: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -18: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -14: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             -9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
              9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             14: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             18: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             21: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             27: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             28: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             35: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             36: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             42: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             45: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             49: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             54: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             63: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             
             default: allowDistance = 0;
         endcase
    end
    
        BLACK_QUEEN: begin
        case(distance)
             //Special Case  
             -7: allowDistance = (targetPosition[2:0] == currentPosition[2:0]) || ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
              7: allowDistance = (targetPosition[2:0] == currentPosition[2:0]) || ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             
             //Vertical Movement
             -6: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -5: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -4: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -3: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -2: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
             -1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              1: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              2: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              3: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              4: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              5: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              6: allowDistance = (targetPosition[2:0] == currentPosition[2:0]);
              
            //Horizontal movement
            -56: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -48: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -40: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -32: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -24: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
            -16: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             -8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
              8: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             16: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             24: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             32: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             40: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             48: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             56: allowDistance = (targetPosition[5:3] == currentPosition[5:3]);
             
            -63: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -54: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -49: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -45: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -42: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -36: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -35: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -28: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -27: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -21: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -18: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
            -14: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             -9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
              9: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             14: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             18: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             21: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             27: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             28: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             35: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             36: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             42: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             45: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             49: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             54: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             63: allowDistance = ((targetPosition[2:0] - currentPosition[2:0]) == (targetPosition[5:3] - currentPosition[5:3])) || ((targetPosition[2:0] - currentPosition[2:0]) == (currentPosition[5:3] - targetPosition[5:3]));
             
             default: allowDistance = 0;
         endcase
    end
    
        default: allowDistance = 0;
    
    endcase
end
endmodule
