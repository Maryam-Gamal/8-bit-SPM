`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2025 07:51:24 AM
// Design Name: 
// Module Name: rising_edge
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


module rising_edge(input clk, rst, w, output z);
reg [1:0] state, nextState;
parameter [1:0] low=2'b00, Edge=2'b01, high=2'b10; // States Encoding
// Next state generation (combinational logic)
always @ (w or state) begin
case (state)
low: if (w==0) nextState = low;
else nextState = Edge;
Edge: if (w==0) nextState = low;
else nextState = high;
high: if (w==0) nextState = low;
else nextState = high;
default: nextState = low;
endcase
end

always @ (posedge clk or posedge rst) begin
if(rst) state <= low;
else state <= nextState;
end

// output generation (combinational logic)
assign z = (state == Edge);
endmodule
