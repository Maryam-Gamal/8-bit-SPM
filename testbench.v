`timescale 1ns / 1ps

module mul8_bug_checker();

    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg [7:0] mc;
    reg [7:0] mp;

    // Outputs
    wire [15:0] p;
    wire done;

    // Internal state trackers
    reg [15:0] shift_register;
    reg [7:0] y_register;
    reg sign_bit;

    // Instantiate the Unit Under Test (UUT)
    mul8 uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .mc(mc),
        .mp(mp),
        .p(p),
        .done(done)
    );

    // Clock generation - 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence with detailed state monitoring
    initial begin
        // Initialize Inputs
        rst = 1;
        start = 0;
        mc = 0;
        mp = 0;
        shift_register = 0;
        y_register = 0;
        sign_bit = 0;

        // Reset sequence
        #20;
        rst = 0;
        #20;

        // Debug Case 1: 5 x 7 = 35
        detailed_test(8'd5, 8'd7);
        
        // Debug Case 2: -15 x 10 = -150 (Test negative handling)
        detailed_test(-8'd128, -8'd128);
        
        // Debug Case 3: Edge case -128 x -128 = 16384
        detailed_test(-8'd10, -8'd15);

        // End simulation
        #100;
        $finish;
    end

    // Task for detailed monitoring of internal state
    task detailed_test;
        input [7:0] multiplicand;
        input [7:0] multiplier;
        begin
            $display("\n===== DEBUG TEST =====");
            $display("Multiplying %0d x %0d", $signed(multiplicand), $signed(multiplier));
            
            // Set inputs
            mc = multiplicand;
            mp = multiplier;
            
            // Start multiplication
            #10;
            start = 1;
            #10;
            start = 0;
            
            // Wait for done signal
            wait(done);
            #20;
            
            $display("Final Result: %0d (Expected: %0d)", 
                     $signed(p), $signed(multiplicand) * $signed(multiplier));
            $display("====================");
        end
    endtask
    
    // Detailed signal monitoring for every clock cycle
    initial begin
        $monitor("Time=%t | State=%0d, Count=%0d | mc=%0d, mp=%0d | Y=%b (LSB=%b) | sign_mp=%b | Product=0x%h (%0d) | pw=%b", 
                 $time, uut.state, uut.cnt, $signed(mc), $signed(mp), 
                 uut.Y, uut.Y[0], uut.sign_mp, p, $signed(p), uut.pw);
    end

    // Track the bit-by-bit progress and shift register behavior
    always @(posedge clk) begin
        if (uut.state == uut.RUNNING) begin
            // Print the shift operation details when in RUNNING state
            if (uut.cnt >= 1) begin
                $display("Cycle %0d: Shift reg = 0x%h, LSB input = %b, pw = %b, Sign Extension = %b", 
                          uut.cnt, p, uut.Y[0], uut.pw, 
                          (uut.cnt >= 8) ? uut.sign_mp : uut.Y[7]);
            end
        end
    end

endmodule