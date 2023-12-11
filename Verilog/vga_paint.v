`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 12/10/2023 01:29:43 PM
// Design Name: 
// Module Name: vga_paint
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

module vga_paint(
    input wire [255:0] board,
    input wire clk, //24.4 kHz                                                                              //changed to 25MHz
    input wire reset,
    input wire [12:0] moveData,
    output wire [3:0] redVGA, 
    output wire [3:0] blueVGA, 
    output wire [3:0] greenVGA, 
    output wire horizontalVGA, 
    output wire verticalVGA
    );
    
    //Define different colors based on how they interact with the VGA
    reg [11:0] currentColor = 0; //set this equal to the desired color constant
    
    localparam BLACKTILECOLOR = 12'b001101101000;
    localparam WHITETILECOLOR = 12'b111010101001;
    localparam CURSORTILECOLOR = 12'b0000111100011;
    localparam SELECTEDTILECOLOR = 12'b111101010110;
    localparam BLACKPIECECOLOR = 12'b000100010011;
    localparam WHITEPIECECOLOR = 12'b111011101111;
    
    //Storing piece data and design
    localparam WHITE = 1'b0;
    localparam BLACK = 1'b1;
    localparam EMPTY = 3'b000;
    localparam KING = 3'b001;
    localparam QUEEN = 3'b010;
    localparam BISHOP = 3'b011;
    localparam KNIGHT = 3'b100;
    localparam ROOK = 3'b101;
    localparam PAWN = 3'b110;
    
    localparam [120:0] pawn = 
        121'b00000000000_00000000000_10000000000_11000000000_11011000000_11111100000_11011000000_11000000000_10000000000_00000000000_00000000000;
    
    localparam [120:0] rook = 
        121'b00000000000_00000000000_11000011100_11111111000_11111110000_11111110000_11111110000_11111111000_11000011100_00000000000_00000000000;
    
    localparam [120:0] bishop = 
        121'b00000000000_00000000000_10000000000_11000000000_11100111000_11111111100_11100110000_11000000000_10000000000_00000000000_00000000000;
    
    localparam [120:0] knight = 
        121'b00000000000_11000000000_11111111000_11111111100_11110011110_11100011110_11000111100_10000111010_00001110010_00000100000_00000000000;
    
    localparam [120:0] king = 
        121'b00000000000_00000000000_10000000000_11000010000_11110011010_11111111111_11110011010_11000010000_10000000000_00000000000_00000000000;
    
    localparam [120:0] queen = 
        121'b00000000000_00000000000_10000000000_11000001000_11110111100_11111111110_11110111100_11000001000_10000000000_00000000000_00000000000;
    
    
    //Create the 25 MHz clock                                                                   //CHANGED
    wire PIXELS;
    rohans_clock_divider test(.in_clk(clk), .out_clk(PIXELS));
    
    
    //Generate the vga cycle
    wire [9:0] x;
    wire [9:0] y;
    wire de;
    vga_generator activate(.clk(clk), .reset(reset), .horizontalVGA(horizontalVGA), .verticalVGA(verticalVGA), .pixelX(x), .pixelY(y), .de(de)); 
    
    //ROHANS CODE                                                                                   //TODO look through organize and comment
    wire [3:0] PIECES[63:0];
    genvar i;
    
    generate for (i=0; i<64; i=i+1) begin
        assign PIECES[i] = board[i*4+3:i*4];
    end
    endgenerate
    
    
    //Defining board position on screen, and defining squares of the board
    reg [2:0] let;
    reg [2:0] num;
    reg [5:0] squareX;
    reg [5:0] squareY;
    
    always @ (x) begin
        if (x<=150) begin
            let <= 0;
            squareX = x-100; end
        else if (x<=200) begin
            let <= 1;
            squareX = x-150; end
        else if (x<=250) begin
            let <= 2;
            squareX = x-200; end
        else if (x<=300) begin 
            let <= 3; 
            squareX = x-250; end
        else if (x<=350) begin
            let <= 4;
            squareX = x-300; end
        else if (x<=400) begin
            let <= 5;
            squareX = x-350; end
        else if (x<=450) begin
            let <= 6;
            squareX = x-400; end
        else begin
            let <= 7;
            squareX = x-450; end
    end
    
    always @ (y) begin
        if (y<=90) begin
            num <= 0;
            squareY = y - 40; end
        else if (y<=140) begin
            num <= 1;
            squareY = y - 90; end
        else if (y<=190) begin
            num <= 2;
            squareY = y - 140; end
        else if (y<=240) begin
            num <= 3;
            squareY = y - 190; end
        else if (y<=290) begin
            num <= 4;
            squareY = y - 240; end
        else if (y<=340) begin
            num <= 5;
            squareY = y - 290; end
        else if (y<=390) begin
            num <= 6;
            squareY = y - 340; end
        else begin
            num <= 7;
            squareY = y - 390; end
    end
    
    reg [3:0] ypiece;
    reg [3:0] xpiece;
    
    
    always @ (squareX) begin
        if (squareX <=5) xpiece <= 0;
        else if (squareX <=9) xpiece <= 1;
        else if (squareX <=13) xpiece <= 2;
        else if (squareX <=17) xpiece <= 3;
        else if (squareX <=21) xpiece <= 4;
        else if (squareX <=25) xpiece <= 5;
        else if (squareX <=29) xpiece <= 6;
        else if (squareX <=33) xpiece <= 7;
        else if (squareX <=37) xpiece <= 8;
        else if (squareX <=41) xpiece <= 9;
        else if (squareX <=45) xpiece <= 10;
    end
    
    always @ (squareY) begin
        if (squareY <=5) ypiece <= 0;
        else if (squareY <=9) ypiece <= 1;
        else if (squareY <=13) ypiece <= 2;
        else if (squareY <=17) ypiece <= 3;
        else if (squareY <=21) ypiece <= 4;
        else if (squareY <=25) ypiece <= 5;
        else if (squareY <=29) ypiece <= 6;
        else if (squareY <=33) ypiece <= 7;
        else if (squareY <=37) ypiece <= 8;
        else if (squareY <=41) ypiece <= 9;
        else if (squareY <=45) ypiece <= 10;
    end
    
    
    //Converting each square to an 11x11 array to draw designs
    reg [10:0] square[10:0];
    integer j;
    
    
    wire boardBoolean;
    wire dark;
    assign boardBoolean = (x>=100 && x<500) && (y>=40 && y<440);
    assign dark = let[0] ^ num[0];
    
    always @ (posedge PIXELS) begin                                                                                     //CHANGED
        if (de == 0)
            currentColor = 12'b0;
        else if (de==1) begin
            if (boardBoolean) begin
                case (PIECES[{let, num}][2:0])
                    EMPTY: begin   
                        if (moveData[5:0] == {let,num})
                            currentColor = CURSORTILECOLOR;
                        else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                            currentColor = SELECTEDTILECOLOR;
                        else begin                         
                            if (dark)
                                currentColor = BLACKTILECOLOR;
                            else
                                currentColor = WHITETILECOLOR;
                        end
                    end
                    
                    
                    PAWN : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = pawn[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    
                    ROOK : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = rook[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    
                   KNIGHT : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = knight[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    BISHOP : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = bishop[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    
                    QUEEN : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = queen[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    
                    KING : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = king[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                
                
                
                endcase
                end
        else if (~boardBoolean)
            currentColor = 12'b0;
        end
    end                                                                                         //END OF ROHANS CODE
    
    //Assign color outputs
    assign redVGA = currentColor[11:8];
    assign greenVGA = currentColor[7:4];
    assign blueVGA = currentColor[3:0];
         
endmodule  
