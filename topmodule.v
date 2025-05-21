`timescale 1ns / 1ps

module spm (input wire clk, input wire  rst, input wire  y, input wire [7:0]   x, output wire p);
    wire[7:1] pp;
    genvar i;

    CSADD csa0 (clk, rst, (x[0]&y), (pp[1]), (p));
    
    generate 
        for(i=1; i<7; i=i+1) begin
            CSADD csa (.clk(clk), .rst(rst), .x(x[i]&y), .y(pp[i+1]), .sum(pp[i]));
        end 
    endgenerate
    
    TCMP tcmp (.clk(clk), .rst(rst), .a(x[7]&y), .s(pp[7]));

endmodule


module CSADD(input wire clk, input wire rst,input wire x, input wire y,output reg  sum);
    reg sc;
    wire hsum1, hco1;
    wire hsum2, hco2;
    assign hsum1 = y ^ sc;
    assign hco1 = y & sc;

    
    assign hsum2 = x ^ hsum1;
    assign hco2 = x & hsum1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sum <= 1'b0;
            sc <= 1'b0;
        end
        else begin
            sum <= hsum2;
            sc <= hco1 ^ hco2;
        end
    end
endmodule

module TCMP (input wire clk, input wire rst,input wire a, output reg  s);
    reg z;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            s <= 1'b0; z <= 1'b0;
        end
        else begin
            z <= a | z; s <= a ^ z;
        end
    end

endmodule
