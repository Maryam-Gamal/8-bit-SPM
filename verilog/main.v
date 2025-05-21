`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2025 07:57:10 AM
// Design Name: 
// Module Name: main
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

module main(input signal_in, input left_button_in, input right_button_in, input sys_clk, input rst, input [7:0] multiplicand, input [7:0] multiplier, output [6:0] segments,
 output [3:0] anode_active,
  output led
);
    
    wire clk;
    wire [19:0] bcd;
    wire [15:0] product;
    wire BTNC, BTNR, BTNL;
    wire sign;
    wire [3:0] right_digit ,middle_digit, left_digit;
    
    clk_divider clkdiv_btnc(sys_clk, rst, clk);
    push_button_detector multiply_pressed(clk, signal_in, rst, BTNC);
    push_button_detector right_pressed(clk, right_button_in, rst, BTNR);
    push_button_detector left_pressed(clk, left_button_in, rst, BTNL);
     assign sign = product[15];
    fsm sm(clk, rst, BTNC, multiplicand, multiplier, product, led);
    assign sign = product[15];
    wire [15:0] mag;
    twos_complement tc(product, mag);

    BCD binary_bcd(sign ? mag[14:0] : product[14:0], bcd);
    
    buttonsCU bcu(bcd,BTNR, BTNL, clk, right_digit, middle_digit, left_digit);
    
    reg[1:0] display_enable;
    always @(posedge clk) begin
        display_enable <= display_enable + 1;
        if (display_enable == 2'b11)
            display_enable <= 2'b00;
    end
    
    reg [3:0] inp;
    always @(posedge clk) begin
        case(display_enable)
            2'b10: inp = right_digit;
            2'b01: inp = middle_digit;
            2'b00: inp = left_digit;
            2'b11: inp = (sign) ? 4'b1010 : 4'b1011;
            default: inp = 4'b0000;
        endcase
    end

    SevenSeg seg(display_enable, inp, segments, anode_active);
  
endmodule