`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/12/2023 10:29:15 PM
// Design Name: 
// Module Name: king_states
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


module king_states(
    input clk,
    input reset,
    output reg [2:0] winState,
    output reg check  //either player has been checked
    );
    
    //LOCAL VARIABLES
    reg inCheckWHITE;
    reg inCheckBLACK;
    reg kingStateWHITE;
    reg kingStateBLACK;
    
    //STATE DECODINGS
    localparam SAFE = 2'b00;
    localparam CHECK = 2'b01;
    localparam CHECKMATE = 2'b10;
    localparam STALEMATE = 2'b11;
    localparam CONTINUE = 2'b00;
    localparam WHITEWIN = 2'b01;
    localparam BLACKWIN = 2'b10;
    localparam DRAW = 2'b11;
    
    //INITIALIZE LOCAL VARIABLES
    checkCheck checkW(.inCheck(inCheckWHITE)); //white's current position
    checkCheck checkB(.inCheck(inCheckBLACK)); //black's current position
 
    //STATE MACHINES
    always@(posedge clk, posedge reset) begin
    
        if(reset) begin
        
        end else begin
        
        
        
            //State Machine for WHITE KING
            case(kingStateWHITE)
                
                SAFE: begin
                    if(inCheckWHITE) begin
                        kingStateWHITE <= CHECK;
                        check <= 1;
                    end
                    if(stalemate) begin                                            //FINISH
                        kingStateWHITE <= STALEMATE;
                        winState <= DRAW;
                    end
                    winState <= CONTINUE;
                    check <= 0;
                end
                
                CHECK: begin
                   if(!inCheckWHITE) begin
                       kingStateWHITE <= SAFE;
                       check <= 0;
                   end
                end
                
                CHECKMATE: begin
                    winState <= BLACKWIN;
                end
                
                STALEMATE: begin
                end
                
            endcase
            
            
            
            
            
            //State Machine for BLACK KING
            case(kingStateBLACK)
                
                SAFE: begin
                    if(inCheckBLACK) begin
                        kingStateBLACK <= CHECK;
                        check <= 1;
                    end
                    if(stalemate) begin                                            //FINISH
                        kingStateBLACK <= STALEMATE;
                        winState <= DRAW;
                    end
                    winState <= CONTINUE;
                    check <= 0;
                end
                
                CHECK: begin
                   if(!inCheckBLACK) begin
                       kingStateBLACK <= SAFE;
                       check <= 0;
                   end
                end
                
                CHECKMATE: begin
                    winState <= WHITEWIN;
                end
                
                STALEMATE: begin
                end
                
            endcase
            
            
            
            
        end
    end
endmodule
