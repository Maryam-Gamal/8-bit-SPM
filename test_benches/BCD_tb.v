module BCD_tb;
    // Parameters
    parameter p = 18;  // Using the same parameter as in the BCD module
    
    // Inputs
    reg [14:0] in;
    
    // Outputs
    wire [19:0] bcd;
    
    // Instantiate the BCD module
    BCD #(p) dut (
        .in(in),
        .bcd(bcd)
    );
    
    // Function to convert binary to decimal (for verification)
    function [19:0] binary_to_bcd;
        input [14:0] binary;
        reg [19:0] bcd;
        integer i;
        begin
            bcd = 0;
            for (i = 14; i >= 0; i = i - 1) begin
                // Add 3 to columns >= 5
                if (bcd[3:0] > 4) bcd[3:0] = bcd[3:0] + 3;
                if (bcd[7:4] > 4) bcd[7:4] = bcd[7:4] + 3;
                if (bcd[11:8] > 4) bcd[11:8] = bcd[11:8] + 3;
                if (bcd[15:12] > 4) bcd[15:12] = bcd[15:12] + 3;
                if (bcd[19:16] > 4) bcd[19:16] = bcd[19:16] + 3;
                
                // Shift left
                bcd = {bcd[18:0], binary[i]};
            end
            binary_to_bcd = bcd;
        end
    endfunction
    
    // Display variables
    reg [19:0] expected_bcd;
    
    initial begin
        // Initialize inputs
        in = 0;
        
        // Display header
        $display("Time\tInput Binary\tOutput BCD\t\tExpected BCD\tStatus");
        $display("----------------------------------------------------------------");
        
        // Test case 1: Input = 0
        #10 in = 15'd0;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 2: Input = 1
        #10 in = 15'd1;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 3: Input = 9
        #10 in = 15'd9;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 4: Input = 10
        #10 in = 15'd10;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 5: Input = 99
        #10 in = 15'd99;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 6: Input = 100
        #10 in = 15'd100;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 7: Input = 999
        #10 in = 15'd999;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 8: Input = 1000
        #10 in = 15'd1000;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 9: Input = 9999
        #10 in = 15'd9999;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 10: Input = 10000
        #10 in = 15'd10000;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 11: Input = maximum value (2^15-1 = 32767)
        #10 in = 15'd32767;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 12: Input = random value 1
        #10 in = 15'd12345;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 13: Input = random value 2
        #10 in = 15'd27182;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 14: Input = random value 3
        #10 in = 15'd31415;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // Test case 15: Input = parameter p value
        #10 in = p;
        #1 expected_bcd = binary_to_bcd(in);
        #1 verify_bcd();
        
        // End simulation
        #10 $display("\nTest completed successfully!");
        #10 $finish;
    end
    
    // Task to verify the BCD output
    task verify_bcd;
        begin
            #1;
            $display("%0t\t%d\t\t%d%d%d%d%d\t\t%d%d%d%d%d\t%s", 
                     $time, 
                     in, 
                     bcd[19:16], bcd[15:12], bcd[11:8], bcd[7:4], bcd[3:0],
                     expected_bcd[19:16], expected_bcd[15:12], expected_bcd[11:8], expected_bcd[7:4], expected_bcd[3:0],
                     (bcd === expected_bcd) ? "PASS" : "FAIL");
                     
            if (bcd !== expected_bcd) begin
                $display("ERROR: Mismatch detected! Input: %d, Output: %h, Expected: %h", 
                         in, bcd, expected_bcd);
            end
        end
    endtask

    
endmodule