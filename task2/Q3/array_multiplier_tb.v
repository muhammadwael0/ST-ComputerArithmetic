`timescale 1ns/1ps

module array_multiplier_tb;
    reg signed [31:0] multiplier, multiplicand;
    reg signed [63:0] expected;
    wire signed [63:0] product;

    // Instantiate the array multiplier
    array_multiplier uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    initial begin        
        // Test Cases
        test_case(32'h00000001, 32'h00000001); // 1 * 1
        test_case(32'h12345678, 32'h12345678); // Positive * Positive
        test_case(32'hFFFFFFFF, 32'hFFFFFFFF); // -1 * -1
        test_case(32'h00000000, 32'h12345678); // 0 * Positive
        test_case(32'h12345678, 32'h00000000); // Positive * 0
        test_case(32'h80000000, 32'h00000002); // MIN_INT * 2
        test_case(32'h7FFFFFFF, 32'h7FFFFFFF); // MAX_INT * MAX_INT
        test_case(32'hFFFFFFFF, 32'h00000002); // -1 * 2
        test_case(32'hFFFFFFFE, 32'h00000002); // -2 * 2
        test_case(32'h00000002, 32'hFFFFFFFE); // 2 * -2
        test_case(32'h80000000, 32'hFFFFFFFF); // MIN_INT * -1
        test_case(32'h7FFFFFFF, 32'hFFFFFFFF); // MAX_INT * -1
        test_case(32'h00000003, 32'h00000003); // 3 * 3
        test_case(32'hFFFFFFFF, 32'h00000003); // -1 * 3
        test_case(32'h80000000, 32'h80000000); // MIN_INT * MIN_INT
        
        #200;
        $finish;
    end

    // Task to execute test cases
    task test_case;
        input signed [31:0] a, b;
        begin
            multiplier = a;
            multiplicand = b;
            expected = a * b;
            #10;
            if (product !== expected) begin
                $display("ERROR at Time=%0t: %d * %d = %d (Expected %d)", $time, a, b, product, expected);
            end else begin
                $display("PASS  at Time=%0t: %d * %d = %d", $time, a, b, product);
            end
            #20;
        end
    endtask
    
endmodule