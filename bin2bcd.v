`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 10/26/2023 05:10:45 PM
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(
    input [5:0] bin,
    output reg [11:0] bcd
    );
    
    integer i;
    
    always @(bin)
        begin
            bcd = 0;
            for (i = 0; i < 6; i = i+1)
            begin                
                if(bcd[3:0] >= 5) 
                    bcd[3:0] = bcd[3:0] + 3;
                if( bcd[7:4] >= 5)
                    bcd[7:4] = bcd[7:4] + 3;
                if(bcd[11:8] >= 5)
                    bcd[11:8] = bcd[11:8] + 3;  
                bcd = {bcd[10:0],bin[5-i]};
            end
        end     
    
endmodule
