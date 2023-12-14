`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/10/2023 04:48:37 PM
// Design Name: 
// Module Name: user_state
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

//UNTESTED
module user_state(
    input clk,
    input reset,
    input allowMove,
    input [255:0] entireBoard,
    input BTNC, BTNU, BTND, BTNR, BTNL,
    output reg [10:0] changePiece, //FOR BUILD BOARD bits 0-5->Address, 6-9->Content, 10->Change Boolean 
    output reg [13:0] moveData,                                                                                                
    output reg [2:0] currentState, //FOR BUILD BOARD checks if game is in start state 
    output reg castleAble
    );
    
    //Things needed in allowMove checker: cursorLocation, selectionLocation, board from build board, encodings, playerTurn     //TODO
    //return allowMove
    
    //initialize the state and other reg stuff                                                                                  //TODO

    //Board State Variable Declarations
    reg [5:0] cursorLocation = 6'b100110;
    reg [5:0] selectionLocation;                                                                                                //TODO Initialize all these
    reg selectionCheck; //Checks if a selection has been made
    reg playerTurn;
    
    
    reg whiteKingFirstTurn = 1;
    reg whiteLeftRookFirstTurn = 1;
    reg whiteRightRookFirstTurn = 1;
    
    reg blackKingFirstTurn = 1;
    reg blackLeftRookFirstTurn = 1;
    reg blackRightRookFirstTurn = 1;
    
    wire signed [6:0] distance = selectionLocation - cursorLocation;
    
    //Create package to send to other functions
    always @(posedge clk) begin
        moveData <= {playerTurn, selectionCheck, selectionLocation, cursorLocation};
    end
    
    //Generate a 3D version of the board
    //Purpose of this is to be able to index the 64 squares
    genvar r;
    wire [3:0] board[63:0];
    generate for(r=0; r<256; r=r+4) begin 
        assign board[(r/4)][3:0] = entireBoard[(r+3):r];
    end
    endgenerate
    
    //Create User State Machine
    localparam  startGame      = 5'b00000,
                selectPiece    = 5'b00001,
                movePiece      = 5'b00010,
                removePiece    = 5'b00011,
                placePiece     = 5'b00100,
                whiteLeftCastle1    = 5'b00101,
                whiteLeftCastle2    = 5'b00110,
                whiteRightCastle1   = 5'b00111,
                whiteRightCastle2   = 5'b01000,
                blackLeftCastle1    = 5'b01001,
                blackLeftCastle2    = 5'b01010,
                blackRightCastle1   = 5'b01011,
                blackRightCastle2   = 5'b01100,
                whiteEnPassantLeft  = 5'b01101,
                whiteEnPassantRight = 5'b01111,
                blackEnPassantLeft  = 5'b10000,
                blackEnPassantRight = 5'b10001;
    
    
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
                BLACK_PAWN   = 4'b1110,
                
                EMPTY = 3'b000;
    
    
    //Start State Machine
    always@(posedge clk, posedge reset) begin
        if(reset) begin
            currentState <= startGame;       
            //castleState <= writeking;
            //change to whites turn
            playerTurn <= 1'b0;
            //move cursor to start
            cursorLocation <= 6'b100110;
            //empty select address
            
            //enable 0 and other things too. 
            selectionCheck <= 1'b0;
            changePiece <= 11'b00000000000;
            
            whiteKingFirstTurn = 1;
            whiteLeftRookFirstTurn = 1;
            whiteRightRookFirstTurn = 1 ;
    
            blackKingFirstTurn = 1;
            blackLeftRookFirstTurn = 1;
            blackRightRookFirstTurn = 1;
            
        end else begin
        
            case(currentState)
            
                startGame: begin
                    currentState <= selectPiece;
                end
                
                selectPiece: begin
                    if(BTNC && (board[cursorLocation][2:0] != 1'b0) && (board[cursorLocation][3] == playerTurn)) begin //if location is empty and it's the right player's turn
                        currentState <= movePiece;
                        selectionCheck <= 1;
                        selectionLocation <= cursorLocation;
                    end
                end
                
                movePiece: begin
                    if(BTNC) begin
                        if(allowMove) begin
                            selectionCheck <= 0;
                            changePiece[5:0] <= cursorLocation;
                            changePiece[10] <= 1;
                            
                            if((selectionLocation == 39) && (board[selectionLocation][3:0] == WHITE_KING) &&  //castling
                            (distance == -9 || distance == -8 || distance == -7 || distance == -1 
                            || distance == 1 || distance == 7 || distance == 8 || distance == 9))
                            begin
                                whiteKingFirstTurn <= 0;
                            end
                            
                            if((selectionLocation == 32) && (board[selectionLocation][3:0] == BLACK_KING) && 
                            (distance == -9 || distance == -8 || distance == -7 || distance == -1 
                            || distance == 1 || distance == 7 || distance == 8 || distance == 9))
                            begin
                                blackKingFirstTurn <= 0;
                            end
                            
                            if((selectionLocation == 7) && (board[selectionLocation][3:0] == WHITE_ROOK) && 
                            (distance == 1 || distance == 2 || distance == 3 || distance == 4
                            || distance == 5 || distance == 6 || distance == 7 || distance == 8
                            || distance == 16 || distance == 24 || distance == 32 || distance == 40
                            || distance == 48 || distance == 56 ||distance == 1 || distance == 2 
                            || distance == 3 || distance == 4 || distance == 5 || distance == 6 
                            || distance == 7 || distance == 8 || distance == 16 || distance == 24 
                            || distance == 32 || distance == 40 || distance == 48 || distance == 56 ))
                            begin
                                whiteLeftRookFirstTurn <= 0;
                            end
                            
                            if((selectionLocation == 63) && (board[selectionLocation][3:0] == WHITE_ROOK) && 
                            (distance == 1 || distance == 2 || distance == 3 || distance == 4
                            || distance == 5 || distance == 6 || distance == 7 || distance == 8
                            || distance == 16 || distance == 24 || distance == 32 || distance == 40
                            || distance == 48 || distance == 56 ||distance == 1 || distance == 2 
                            || distance == 3 || distance == 4 || distance == 5 || distance == 6 
                            || distance == 7 || distance == 8 || distance == 16 || distance == 24 
                            || distance == 32 || distance == 40 || distance == 48 || distance == 56 ))
                            begin
                                whiteRightRookFirstTurn <= 0;
                            end
                            
                            if((selectionLocation == 0) && (board[selectionLocation][3:0] == BLACK_ROOK) && 
                            (distance == 1 || distance == 2 || distance == 3 || distance == 4
                            || distance == 5 || distance == 6 || distance == 7 || distance == 8
                            || distance == 16 || distance == 24 || distance == 32 || distance == 40
                            || distance == 48 || distance == 56 ||distance == 1 || distance == 2 
                            || distance == 3 || distance == 4 || distance == 5 || distance == 6 
                            || distance == 7 || distance == 8 || distance == 16 || distance == 24 
                            || distance == 32 || distance == 40 || distance == 48 || distance == 56 ))
                            begin
                                blackLeftRookFirstTurn <= 0;
                            end
                            
                            if((selectionLocation == 56) && (board[selectionLocation][3:0] == BLACK_ROOK) && 
                            (distance == 1 || distance == 2 || distance == 3 || distance == 4
                            || distance == 5 || distance == 6 || distance == 7 || distance == 8
                            || distance == 16 || distance == 24 || distance == 32 || distance == 40
                            || distance == 48 || distance == 56 ||distance == 1 || distance == 2 
                            || distance == 3 || distance == 4 || distance == 5 || distance == 6 
                            || distance == 7 || distance == 8 || distance == 16 || distance == 24 
                            || distance == 32 || distance == 40 || distance == 48 || distance == 56 ))
                            begin
                                blackRightRookFirstTurn <= 0;
                            end
                            
                            if( (cursorLocation % 8 == 0) && (board[selectionLocation][3:0] == WHITE_PAWN) )begin          // Promotion
                                changePiece[9:6] <= WHITE_QUEEN;
                                currentState <= placePiece;
                            end else if ( (cursorLocation % 8 == 7) && (board[selectionLocation][3:0] == BLACK_PAWN) )begin
                                changePiece[9:6] <= BLACK_QUEEN;
                                currentState <= placePiece;
                             ///////////UNFINISHED ///////
                            end else if ( (board[47][2:0] == EMPTY) && (board[55][2:0] == EMPTY) && (board[selectionLocation][3:0] == WHITE_KING) && (cursorLocation ==  15) //castling
                                           && whiteKingFirstTurn && whiteRightRookFirstTurn )begin
                                changePiece[9:6] <= board[selectionLocation][3:0];
                                currentState <= whiteRightCastle1; 
                                
                            end else if ( (board[31][2:0] == EMPTY) && (board[23][2:0] == EMPTY) && (board[63] == WHITE_ROOK)
                                           && (board[15][2:0] == EMPTY) && (board[selectionLocation][3:0] == WHITE_KING) && (cursorLocation ==  55) 
                                           && whiteKingFirstTurn && whiteLeftRookFirstTurn )begin
                                changePiece[9:6] <= board[selectionLocation][3:0];
                                currentState <= whiteLeftCastle1;
                               
                            end else begin
                                changePiece[9:6] <= board[selectionLocation][3:0];
                                currentState <= placePiece;
                            end 
                            
                         
                            
                            
                         
                        end else begin //double check to logic of if say they click their own piece
                        currentState <= selectPiece;
                        selectionCheck <= 0;
                        //should you put the cursor back where it was so that the piece snaps back? check the logic here
                        end
                    end
                end
                
                whiteRightCastle1: begin
                    selectionCheck <= 0;
                    changePiece[5:0] <= 6'd47;
                    changePiece[9:6] <= WHITE_ROOK;
                    changePiece[10] <= 1;
                    currentState <= whiteRightCastle2;
                end
                
                whiteRightCastle2: begin
                    selectionCheck <= 0;
                    changePiece[5:0] <= 6'd63;
                    changePiece[9:6] <= WHITE_EMPTY;
                    changePiece[10] <= 1;
                    currentState <= removePiece;
                
                end
                
                whiteLeftCastle1: begin
                    selectionCheck <= 0;
                    changePiece[5:0] <= 6'd23;
                    changePiece[9:6] <= WHITE_ROOK;
                    changePiece[10] <= 1;
                    currentState <= whiteLeftCastle2;
                
                end
                
                whiteLeftCastle2: begin
                    selectionCheck <= 0;
                    changePiece[5:0] <= 6'd7;
                    changePiece[9:6] <= WHITE_EMPTY;
                    changePiece[10] <= 1;
                    currentState <= removePiece;
                
                end
                
                removePiece: begin
                    currentState <= selectPiece;
                    changePiece[10] <= 0;
                    playerTurn <= ~playerTurn;
                end
                
                placePiece: begin
                    currentState <= removePiece;
                    changePiece[5:0] <= selectionLocation;
                    changePiece[9:6] <= {1'b0, 3'b000};
                end
                
            endcase 
            
            
            
            
            //Check for Cursor Movements every CLK
            if(BTNL && cursorLocation[5:3] != 3'b000) begin                                   //have hold to midigate the hold time violation or check if cursor matches with VGA
                cursorLocation <= cursorLocation - 6'b00_1000;
            end else if(BTNR && cursorLocation[5:3] != 3'b111) begin                            
                cursorLocation <= cursorLocation + 6'b00_1000;
            end else if(BTND && cursorLocation[2:0] != 3'b111) begin
                cursorLocation <= cursorLocation + 6'b00_0001;
            end else if(BTNU && cursorLocation[2:0] != 3'b000) begin 
                cursorLocation <= cursorLocation - 6'b00_0001;
            end
        end    
  end 
endmodule

