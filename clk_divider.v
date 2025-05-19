`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2025 07:49:46 AM
// Design Name: 
// Module Name: clk_divider
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

module  clk_divider#(parameter n = 5000)(
    input clk_in,
    input rst,
    output reg clk_out
);

reg [31:0] count;

always @ (posedge clk_in or posedge rst) begin
    if (rst) begin
        count <= 0;
        clk_out <= 0;
    end
    else begin
        if (count == n - 1) begin
            count <= 0;
            clk_out <= ~clk_out;
        end
        else begin
            count <= count + 1;
        end
    end
end

endmodule
