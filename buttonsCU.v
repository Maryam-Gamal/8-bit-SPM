`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2025 07:56:32 AM
// Design Name: 
// Module Name: buttonsCU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: FSM that controls which digits are displayed on a 3-digit display. 
// The FSM has three states (DISPLAY_MODE1, DISPLAY_MODE2, and DISPLAY_MODE3) 
// and transitions between them based on left and right button inputs (BTNL and BTNR).
// The state machine allows the user to navigate through a 5-digit BCD value using just a 3-digit display window. 
// in DISPLAY_MODE1, digits 0-2 are shown
// in DISPLAY_MODE2, digits 1-3 are shown 
// in DISPLAY_MODE3, digits 2-4 are shown. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module buttonsCU(input [19:0] bcd, input BTNR, input BTNL, input clk, output [3:0] right, output [3:0] middle, output [3:0] left);

// State register and next state
reg [1:0] state, next;
// State definitions - representing different display configurations
parameter [1:0] DISPLAY_MODE1 = 2'b00, DISPLAY_MODE2 = 2'b01, DISPLAY_MODE3 = 2'b10;

// Initialize state to first display mode
initial begin
  state = DISPLAY_MODE1;
end

// Combinational logic for next state determination based on button inputs
always @(BTNR, BTNL) begin
  case (state)
    DISPLAY_MODE1: begin
      // In mode 1, left button transitions to mode 2
      if (BTNL) begin
        next = DISPLAY_MODE2;
      end else begin 
        next = DISPLAY_MODE1;
      end
    end
    
    DISPLAY_MODE2: begin
      // In mode 2, right button goes back to mode 1, left button advances to mode 3
      if (BTNR) begin
        next = DISPLAY_MODE1;
      end else if (BTNL) begin
        next = DISPLAY_MODE3;
      end else begin 
        next = DISPLAY_MODE2;
      end
    end
    
    DISPLAY_MODE3: begin
      // In mode 3, right button returns to mode 2
      if (BTNR) begin
        next = DISPLAY_MODE2;
      end else begin
        next = DISPLAY_MODE3;
      end
    end
  endcase
end

// Sequential logic to update state on clock edge
always @(posedge clk) begin
    state <= next;
end

// Output assignments based on current state
// Each state shifts which BCD digits are displayed in the 3-digit window
assign right = (state == DISPLAY_MODE1) ? bcd[3:0] : 
              ((state == DISPLAY_MODE2) ? bcd[7:4] : bcd[11:8]); 

assign middle = (state == DISPLAY_MODE1) ? bcd[7:4] : 
               ((state == DISPLAY_MODE2) ? bcd[11:8] : bcd[15:12]); 

assign left = (state == DISPLAY_MODE1) ? bcd[11:8] : 
             ((state == DISPLAY_MODE2) ? bcd[15:12] : bcd[19:16]); 

endmodule
