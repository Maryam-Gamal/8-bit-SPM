
# sequential 8-bit signed Serial-Parallel Multiplier (SPM)

## 📌 Project Overview  
This project implements **a sequential 8-bit signed Serial-Parallel Multiplier (SPM)** using Logisim Evolution and deploys it on the Basys 3 FPGA board. The design balances the hardware efficiency of serial processing with the performance of parallel inputs, enabling compact multiplication for signed **8-bit** binary numbers.

---
## Block Diagram
The block diagram illustrates the operation of an 8x8 Signed Serial-Parallel Multiplier system designed for FPGA implementation. The user inputs two signed 8-bit binary numbers using toggle switches: the Multiplier (SW7–SW0) is fed serially into an 8-bit shift-right register, while the Multiplicand (SW15–SW8) is loaded in parallel into an 8-bit register. Upon pressing the BTNC (center button), the Control Unit initiates the multiplication process by coordinating data flow and timing through the system, using a Clock Divider to slow down the clock for visible operations. The Serial-Parallel Multiplier (SPM) receives the serial bits from the multiplier register and the parallel multiplicand, producing the 16-bit signed product as a serial output, which is collected in a 16-bit shift-right register. Once complete, the LED (LD0) is turned on to indicate the end of computation. The 16-bit product is then converted from binary to BCD format by a dedicated converter for display purposes. The result is passed to a shifter that controls the scrolling of the 5-digit decimal product through the rightmost three digits of the 7-segment display, while the leftmost digit displays the sign (negative sign indicated by lighting segment G). The BTNL and BTNR buttons allow the user to scroll left and right to view the full result.
![pro2 drawio](https://github.com/user-attachments/assets/631ce27e-c971-4da9-87b5-6902cea75654)

- Control Unit:  Handles data load, clock timing, shifting, and computation status.
- Serial-Parallel Multiplier (SPM): Performs signed multiplication (8*8) over multiple cycles (16).
- Binary to BCD Converter: Uses the Double Dabble algorithm for decimal conversion.
- 7-Segment Display Handler: Scrollable output showing:
Sign (segment G on for negative)
Magnitude (up to 5 decimal digits)
## Serial Parallel Multiplier: 
![spm](https://github.com/user-attachments/assets/41eec0eb-ba1f-456c-ae1d-a87f64dfb336)

---
## How to Run:
- Open Vivado Design Suite
- Create a new RTL project and select Basys 3 board (Artix-7)
- Add or create your Verilog (.v) files
- Create or modify constraint (.xdc) file to map pins
- Click "Run Synthesis" in Flow Navigator
- After synthesis completes, click "Run Implementation"
- After implementation completes, click "Generate Bitstream"
- Connect Basys 3 board via USB cable
- Click "Open Hardware Manager" then "Open Target" → "Auto Connect"
- Right-click on the detected device and select "Program Device"
---
## Logisim Evolution – Instructions
## 🔧 Circuit: spm.circ (Serial-Parallel Multiplier)
1- Press the Reset button 

2- Set your input bits (multipler and multiplicand)

3 -Set the Load switch (of the right shift reg )= ON (enables parallel load of the multiplier input). 

4- Give one manual clock pulse 

5- Set Load switch = OFF 

6- Start the automatic clock (press Ctrl+K) 

7- The multiplier register begins shifting, and the product register accumulates the result.The counter increments with each clock cycle. When the counter reaches the target value (usually 8 for 8-bit), it sets the Done signal (connected to a LED). As soon as the LED turns ON (meaning multiplication is done), press Ctrl+K again to stop the clock to prevent further shifts or overwrites of the result. 

---
## finalsevensegment.circ 
1- Put 1 16 bit signed number in binary in the reg 

2- If it is more than 5 digits (scroll the digits using the 2 selectors of the 3 muxes) 

---
## Features✨
- Accepts two signed 8-bit binary values:

  - **Multiplier**: SW7–SW0

  - **Multiplicand**: SW15–SW8

- Computes and displays the signed 16-bit product (up to 5 decimal digits).

- Displays:

  - **Sign** on leftmost 7-segment display (negative → segment G on)

  - **Magnitude** on right three 7-segment digits (scrollable with buttons)

- Controls:

  - **BTNC**: Start multiplication
  
  - **BTNL/BTNR**: Scroll through the product's decimal digits
  
  - **LD0 (LED)**: Indicates when multiplication is complete

---
## Implementation Challenges
- Signed Arithmetic Handling: Proper two’s complement logic across registers and BCD conversion.
- Clock Control & Timing: Managing auto clocks without data corruption.
- Display Overflow: Scrolling logic built to manage overflow beyond 3 visible digits.
- FPGA Deployment: Adjusting control signals for compatibility with Basys 3 platform.
---
## Validation & Testing
- 5.1 Functional Tests:
  Multiplication verified for both positive and negative inputs and manual verification against software-calculated values.
- 5.2 Edge Case Examples
(-128 × -128) = 16384
(127 × -1) = -127
(-1 × -1) = 1
---
## Individual Contributions
- Maryam Abdelhakem: Built control unit for multiplier, managed clock logic, and led FPGA testing and Debugging 
- Mennatallah Zaid: Built BCD, Developed 7-segment display circuit using Double Dabble and scrolling buttons
- Combined Effort: Built Control Unit for the buttons, Designed Multipler, Connected the modules, Handled edge cases validation and report writing.
---

## References
- https://electronics.stackexchange.com/questions/713730/how-to-convert-16-bit-to-decimal-on-multisim
- https://en.wikipedia.org/wiki/Double_dabble
- https://www.microchip.com/content/dam/mchp/documents/OTH/ApplicationNotes/ApplicationNotes/DOC0529.PDF
