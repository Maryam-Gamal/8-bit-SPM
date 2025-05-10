# dd1-s25-project1-truth-simplifiers
# 🔢 Quine-McCluskey Logic Minimization  

## 📌 Project Overview  
This project implements **a sequential 8-bit signed Serial-Parallel Multiplier (SPM)** using Logisim Evolution and deploys it on the Basys 3 FPGA board. The design balances the hardware efficiency of serial processing with the performance of parallel inputs, enabling compact multiplication for signed **8-bit** binary numbers.

---

## Features✨
-Accepts two signed 8-bit binary values:

  - **Multiplier**: SW7–SW0

  - **Multiplicand**: SW15–SW8

-Computes and displays the signed 16-bit product (up to 5 decimal digits).

-Displays:

  - Sign on leftmost 7-segment display (negative → segment G on)

  - Magnitude on right three 7-segment digits (scrollable with buttons)

- Controls:

  - BTNC: Start multiplication
  
  - BTNL/BTNR: Scroll through the product's decimal digits
  
  - LD0 (LED): Indicates when multiplication is complete

---

