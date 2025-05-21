`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2025 07:53:58 AM
// Design Name: 
// Module Name: push_button_detector
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

module push_button_detector(input clk, x, reset, output z);
    
    wire debouncerout;
    wire syncout;
    
    debouncer debound(clk, reset, x, debouncerout);
    
    synchronizer synch(clk, debouncerout, syncout);
    
    rising_edge edgedetector(clk, reset, syncout, z);
    
    
    
endmodule

