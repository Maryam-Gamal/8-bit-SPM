`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2025 07:50:49 AM
// Design Name: 
// Module Name: synchronizer
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

module synchronizer (
input clk, 
input sig,
output sig1
);
reg meta; 
reg sig1_reg;


always @(posedge clk) begin
 meta <= sig;
 sig1_reg <= meta;
end
 assign sig1 = sig1_reg;
endmodule

