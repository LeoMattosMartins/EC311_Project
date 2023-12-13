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
    reg firstTurn;
    
    always @(posedge clk)  begin
    
        //check if you have a first turn pawns
        if((currentPiece == WHITE_PAWN && currentPosition%8 == 6) || (currentPiece == BLACK_PAWN && currentPosition%8 == 1)) begin
            firstTurn = 1;
        end else begin
            firstTurn = 0;
        end
    
    
        case(currentPiece)
        
        WHITE_EMPTY: allowDistance = 0;
        BLACK_EMPTY: allowDistance = 0; 
       
        WHITE_KING: begin
            case(distance)
                 -9: allowDistance = 1;
                 -8: allowDistance = 1;
                 -7: allowDistance = 1;
                 -1: allowDistance = 1;
                  1: allowDistance = 1;
                  7: allowDistance = 1;
                  8: allowDistance = 1;
                  9: allowDistance = 1;
                  default: allowDistance = 0;
             endcase
         end
         BLACK_KING: begin
             case(distance)
                 -9: allowDistance = 1;
                 -8: allowDistance = 1;
                 -7: allowDistance = 1;
                 -1: allowDistance = 1;
                  1: allowDistance = 1;
                  7: allowDistance = 1;
                  8: allowDistance = 1;
                  9: allowDistance = 1;
                  default: allowDistance = 0;
             endcase
         end
         
         WHITE_KNIGHT: begin
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
                -2: allowDistance = (firstTurn) ? 1 : 0;
                -1: allowDistance = 1;
                -9: allowDistance = 1;
                7: allowDistance = 1;
                default: allowDistance = 0;
            endcase
        end
        BLACK_PAWN: begin
            case(distance)
                2: allowDistance = (firstTurn) ? 1 : 0;
                1: allowDistance = 1;
                9: allowDistance = 1;
                -7: allowDistance = 1;
                 default: allowDistance = 0;
            endcase
        end
        
        WHITE_BISHOP: begin
        case(distance)
            -63: allowDistance = 1;
            -56: allowDistance = 1;
            -54: allowDistance = 1;
            -49: allowDistance = 1;
            -45: allowDistance = 1;
            -42: allowDistance = 1;
            -36: allowDistance = 1;
            -35: allowDistance = 1;
            -28: allowDistance = 1;
            -27: allowDistance = 1;
            -21: allowDistance = 1;
            -18: allowDistance = 1;
            -14: allowDistance = 1;
             -9: allowDistance = 1;
             -7: allowDistance = 1;
              7: allowDistance = 1;
              9: allowDistance = 1;
             14: allowDistance = 1;
             18: allowDistance = 1;
             21: allowDistance = 1;
             27: allowDistance = 1;
             28: allowDistance = 1;
             35: allowDistance = 1;
             36: allowDistance = 1;
             42: allowDistance = 1;
             45: allowDistance = 1;
             49: allowDistance = 1;
             54: allowDistance = 1;
             56: allowDistance = 1;
             63: allowDistance = 1;
             default: allowDistance = 0;
         endcase
     end
     BLACK_BISHOP: begin
        case(distance)
            -63: allowDistance = 1;
            -56: allowDistance = 1;
            -54: allowDistance = 1;
            -49: allowDistance = 1;
            -45: allowDistance = 1;
            -42: allowDistance = 1;
            -36: allowDistance = 1;
            -35: allowDistance = 1;
            -28: allowDistance = 1;
            -27: allowDistance = 1;
            -21: allowDistance = 1;
            -18: allowDistance = 1;
            -14: allowDistance = 1;
             -9: allowDistance = 1;
             -7: allowDistance = 1;
              7: allowDistance = 1;
              9: allowDistance = 1;
             14: allowDistance = 1;
             18: allowDistance = 1;
             21: allowDistance = 1;
             27: allowDistance = 1;
             28: allowDistance = 1;
             35: allowDistance = 1;
             36: allowDistance = 1;
             42: allowDistance = 1;
             45: allowDistance = 1;
             49: allowDistance = 1;
             54: allowDistance = 1;
             56: allowDistance = 1;
             63: allowDistance = 1;
             default: allowDistance = 0;
         endcase
    end  
    
    WHITE_ROOK: begin
        case(distance)
            -56: allowDistance = 1;
            -48: allowDistance = 1;
            -40: allowDistance = 1;
            -32: allowDistance = 1;
            -24: allowDistance = 1;
            -16: allowDistance = 1;
             -8: allowDistance = 1;
             -7: allowDistance = 1;
             -6: allowDistance = 1;
             -5: allowDistance = 1;
             -4: allowDistance = 1;
             -3: allowDistance = 1;
             -2: allowDistance = 1;
             -1: allowDistance = 1;
              1: allowDistance = 1;
              2: allowDistance = 1;
              3: allowDistance = 1;
              4: allowDistance = 1;
              5: allowDistance = 1;
              6: allowDistance = 1;
              7: allowDistance = 1;
              8: allowDistance = 1;
             16: allowDistance = 1;
             24: allowDistance = 1;
             32: allowDistance = 1;
             40: allowDistance = 1;
             48: allowDistance = 1;
             56: allowDistance = 1;
             default: allowDistance = 0;
        endcase
    end
    
    BLACK_ROOK: begin
        case(distance)
            -56: allowDistance = 1;
            -48: allowDistance = 1;
            -40: allowDistance = 1;
            -32: allowDistance = 1;
            -24: allowDistance = 1;
            -16: allowDistance = 1;
             -8: allowDistance = 1;
             -7: allowDistance = 1;
             -6: allowDistance = 1;
             -5: allowDistance = 1;
             -4: allowDistance = 1;
             -3: allowDistance = 1;
             -2: allowDistance = 1;
             -1: allowDistance = 1;
              1: allowDistance = 1;
              2: allowDistance = 1;
              3: allowDistance = 1;
              4: allowDistance = 1;
              5: allowDistance = 1;
              6: allowDistance = 1;
              7: allowDistance = 1;
              8: allowDistance = 1;
             16: allowDistance = 1;
             24: allowDistance = 1;
             32: allowDistance = 1;
             40: allowDistance = 1;
             48: allowDistance = 1;
             56: allowDistance = 1;
             default: allowDistance = 0;
        endcase
    end
    
    WHITE_QUEEN: begin
        case(distance)
            -56: allowDistance = 1;
            -48: allowDistance = 1;
            -40: allowDistance = 1;
            -32: allowDistance = 1;
            -24: allowDistance = 1;
            -16: allowDistance = 1;
             -8: allowDistance = 1;
             -7: allowDistance = 1;
             -6: allowDistance = 1;
             -5: allowDistance = 1;
             -4: allowDistance = 1;
             -3: allowDistance = 1;
             -2: allowDistance = 1;
             -1: allowDistance = 1;
              1: allowDistance = 1;
              2: allowDistance = 1;
              3: allowDistance = 1;
              4: allowDistance = 1;
              5: allowDistance = 1;
              6: allowDistance = 1;
              7: allowDistance = 1;
              8: allowDistance = 1;
             16: allowDistance = 1;
             24: allowDistance = 1;
             32: allowDistance = 1;
             40: allowDistance = 1;
             48: allowDistance = 1;
             56: allowDistance = 1;
             
            -63: allowDistance = 1;
            -56: allowDistance = 1;
            -54: allowDistance = 1;
            -49: allowDistance = 1;
            -45: allowDistance = 1;
            -42: allowDistance = 1;
            -36: allowDistance = 1;
            -35: allowDistance = 1;
            -28: allowDistance = 1;
            -27: allowDistance = 1;
            -21: allowDistance = 1;
            -18: allowDistance = 1;
            -14: allowDistance = 1;
             -9: allowDistance = 1;
             -7: allowDistance = 1;
              7: allowDistance = 1;
              9: allowDistance = 1;
             14: allowDistance = 1;
             18: allowDistance = 1;
             21: allowDistance = 1;
             27: allowDistance = 1;
             28: allowDistance = 1;
             35: allowDistance = 1;
             36: allowDistance = 1;
             42: allowDistance = 1;
             45: allowDistance = 1;
             49: allowDistance = 1;
             54: allowDistance = 1;
             56: allowDistance = 1;
             63: allowDistance = 1;
             default: allowDistance = 0;
        endcase
    end
    
    BLACK_QUEEN: begin
        case(distance)
            -56: allowDistance = 1;
            -48: allowDistance = 1;
            -40: allowDistance = 1;
            -32: allowDistance = 1;
            -24: allowDistance = 1;
            -16: allowDistance = 1;
             -8: allowDistance = 1;
             -7: allowDistance = 1;
             -6: allowDistance = 1;
             -5: allowDistance = 1;
             -4: allowDistance = 1;
             -3: allowDistance = 1;
             -2: allowDistance = 1;
             -1: allowDistance = 1;
              1: allowDistance = 1;
              2: allowDistance = 1;
              3: allowDistance = 1;
              4: allowDistance = 1;
              5: allowDistance = 1;
              6: allowDistance = 1;
              7: allowDistance = 1;
              8: allowDistance = 1;
             16: allowDistance = 1;
             24: allowDistance = 1;
             32: allowDistance = 1;
             40: allowDistance = 1;
             48: allowDistance = 1;
             56: allowDistance = 1;
             
            -63: allowDistance = 1;
            -56: allowDistance = 1;
            -54: allowDistance = 1;
            -49: allowDistance = 1;
            -45: allowDistance = 1;
            -42: allowDistance = 1;
            -36: allowDistance = 1;
            -35: allowDistance = 1;
            -28: allowDistance = 1;
            -27: allowDistance = 1;
            -21: allowDistance = 1;
            -18: allowDistance = 1;
            -14: allowDistance = 1;
             -9: allowDistance = 1;
             -7: allowDistance = 1;
              7: allowDistance = 1;
              9: allowDistance = 1;
             14: allowDistance = 1;
             18: allowDistance = 1;
             21: allowDistance = 1;
             27: allowDistance = 1;
             28: allowDistance = 1;
             35: allowDistance = 1;
             36: allowDistance = 1;
             42: allowDistance = 1;
             45: allowDistance = 1;
             49: allowDistance = 1;
             54: allowDistance = 1;
             56: allowDistance = 1;
             63: allowDistance = 1;
             default: allowDistance = 0;
        endcase
    end
    
    default: allowDistance = 0;
    
    endcase
end
endmodule
