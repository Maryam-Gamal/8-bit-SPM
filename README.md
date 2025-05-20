
# sequential 8-bit signed Serial-Parallel Multiplier (SPM)

## 📌 Project Overview  
This project implements **a sequential 8-bit signed Serial-Parallel Multiplier (SPM)** using Logisim Evolution and deploys it on the Basys 3 FPGA board. The design balances the hardware efficiency of serial processing with the performance of parallel inputs, enabling compact multiplication for signed **8-bit** binary numbers.

---
## Block Diagram
The block diagram illustrates the operation of an 8x8 Signed Serial-Parallel Multiplier system designed for FPGA implementation. The user inputs two signed 8-bit binary numbers using toggle switches: the Multiplier (SW7–SW0) is fed serially into an 8-bit shift-right register, while the Multiplicand (SW15–SW8) is loaded in parallel into an 8-bit register. Upon pressing the BTNC (center button), the Control Unit initiates the multiplication process by coordinating data flow and timing through the system, using a Clock Divider to slow down the clock for visible operations. The Serial-Parallel Multiplier (SPM) receives the serial bits from the multiplier register and the parallel multiplicand, producing the 16-bit signed product as a serial output, which is collected in a 16-bit shift-right register. Once complete, the LED (LD0) is turned on to indicate the end of computation. The 16-bit product is then converted from binary to BCD format by a dedicated converter for display purposes. The result is passed to a shifter that controls the scrolling of the 5-digit decimal product through the rightmost three digits of the 7-segment display, while the leftmost digit displays the sign (negative sign indicated by lighting segment G). The BTNL and BTNR buttons allow the user to scroll left and right to view the full result.
![pro2 drawio](https://github.com/user-attachments/assets/631ce27e-c971-4da9-87b5-6902cea75654)

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

## References
- https://electronics.stackexchange.com/questions/713730/how-to-convert-16-bit-to-decimal-on-multisim
- https://en.wikipedia.org/wiki/Double_dabble
- https://www.microchip.com/content/dam/mchp/documents/OTH/ApplicationNotes/ApplicationNotes/DOC0529.PDF
