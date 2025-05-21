`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2025 07:54:38 AM
// Design Name: 
// Module Name: BCD
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: his module implements the Double Dabble algorithm (also known as the shift-and-add-3 algorithm)
// to convert a 15-bit binary input into a 5-digit Binary-Coded Decimal representation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module BCD #(parameter p = 18)(input[14:0] in,output reg [19:0] bcd);
    integer i;
    always @(in) begin
        bcd = 20'b0;
        for (i = 14; i >= 0; i = i - 1) begin
            if (bcd[3:0] > 4) begin
                bcd[3:0] = bcd[3:0] + 3;
            end if (bcd[7:4] > 4) begin
                bcd[7:4] = bcd[7:4] + 3;
            end if (bcd[11:8] > 4) begin
                bcd[11:8] = bcd[11:8] + 3;
            end if (bcd[15:12] > 4) begin
                bcd[15:12] = bcd[15:12] + 3;
            end if (bcd[19:16] > 4) begin
                bcd[19:16] = bcd[19:16] + 3;
            end
            bcd = {bcd[18:0], in[i]};
        end
    end
endmodule
