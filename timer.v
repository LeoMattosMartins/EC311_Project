`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 12/13/2023 05:44:49 PM
// Design Name: 
// Module Name: timer
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


module timer(
    input [13:0] moveData,
    input clk, //1s
    input rst,
    output wire [9:0] countdownWhite,
    output wire [9:0] countdownBlack

    );
    
    reg [5:0] secBlack = 6'b111011;
    reg [2:0] minBlack = 3'b101;
    reg [5:0] secWhite = 6'b111011;
    reg [2:0] minWhite = 3'b101;
    
    
    always@(posedge clk, posedge rst) begin
        if(rst) begin
            secBlack = 6'b111011;
            minBlack = 3'b101;
            secWhite = 6'b111011;
            minWhite = 3'b101;
        end
        
        else begin
            if (moveData[13]) begin
                if (secBlack <= 60 && minBlack>=0) begin
                    secBlack = secBlack - 1;
                    minBlack = minBlack;
                    secWhite = secWhite;
                    minWhite = minWhite;                   
                end
                else if (secBlack == 0 && minBlack>=0) begin
                    secBlack = 6'b111011;
                    minBlack = minBlack - 1;
                    secWhite = secWhite;
                    minWhite = minWhite;
                end
            end
            else if (moveData[13] == 0) begin
                if (secWhite <= 60 && minWhite>=0) begin
                    secWhite = secWhite - 1;
                    minWhite = minWhite;
                    secBlack = secBlack;
                    minBlack = minBlack;
                end
                else if (secWhite == 0 && minWhite>=0) begin
                    secWhite = 6'b111011;
                    minWhite = minWhite - 1;
                    secBlack = secBlack;
                    minBlack = minBlack;
                end
            end
            else if ((minBlack == 0 && secBlack == 0) || (minWhite == 0 && secWhite == 0)) begin
                secBlack = 6'b111011;
                minBlack = 3'b101;
                secWhite = 6'b111011;
                minWhite = 3'b101;
            end
        
        end
    end
    
    assign countdownWhite[8:0] = {minWhite, secWhite};
    assign countdownBlack[8:0] = {minBlack, secBlack};
    
    
endmodule
