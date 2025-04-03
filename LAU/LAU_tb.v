`timescale 1ns/1ps

module LAU_tb;
    reg [1:0] op;
    reg Sx, Sy;
    reg signed [15:0] Lx, Ly, Lm;
    wire Sz;
    wire signed [15:0] Lz;

    integer minus = 45;
    integer space = 32;
    integer plus = 43;
    integer multiply = 42;
    integer Divide = 47;

    // Instantiate the LAU module
    LAU uut (
        .op(op),
        .Sx(Sx),
        .Sy(Sy),
        .Lx(Lx),
        .Ly(Ly),
        .Lm(Lm),
        .Sz(Sz),
        .Lz(Lz)
    );

    initial begin 

        Lm = 0;   
        // Test Cases
        test_case(16'd5, 16'd10, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(16'd5, 16'd10, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(16'd5, 16'd10, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(16'd5, 16'd10, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(16'd5, 16'd10, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(16'd5, 16'd10, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(16'd5, 16'd10, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(16'd5, 16'd10, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(16'd5, 16'd10, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(16'd5, 16'd10, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(16'd5, 16'd10, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(16'd5, 16'd10, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(16'd5, 16'd10, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(16'd5, 16'd10, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(16'd5, 16'd10, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(16'd5, 16'd10, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(16'd0, 16'd10, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(16'd0, 16'd10, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(16'd0, 16'd10, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(16'd0, 16'd10, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(16'd0, 16'd10, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(16'd0, 16'd10, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(16'd0, 16'd10, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(16'd0, 16'd10, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(16'd0, 16'd10, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(16'd0, 16'd10, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(16'd0, 16'd10, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(16'd0, 16'd10, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(16'd0, 16'd10, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(16'd0, 16'd10, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(16'd0, 16'd10, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(16'd0, 16'd10, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(16'd2014, 16'd10, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(16'd2014, 16'd10, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(16'd2014, 16'd10, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(16'd2014, 16'd10, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(16'd2014, 16'd10, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(16'd2014, 16'd10, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(16'd2014, 16'd10, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(16'd2014, 16'd10, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(16'd2014, 16'd10, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(16'd2014, 16'd10, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(16'd2014, 16'd10, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(16'd2014, 16'd10, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(16'd2014, 16'd10, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(16'd2014, 16'd10, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(16'd2014, 16'd10, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(16'd2014, 16'd10, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(16'd2014, 16'b1111111100011100, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(16'd2014, 16'b1111111100011100, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(16'd2014, 16'b1111111100011100, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(16'd2014, 16'b1111111100011100, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(16'd2014, 16'b1111111100011100, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(16'd2014, 16'b1111111100011100, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(16'd2014, 16'b1111111100011100, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(16'd2014, 16'b1111111100011100, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(16'd2014, 16'b1111111100011100, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(16'd2014, 16'b1111111100011100, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(16'd2014, 16'b1111111100011100, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(16'd2014, 16'b1111111100011100, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(16'd2014, 16'b1111111100011100, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(16'd2014, 16'b1111111100011100, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(16'd2014, 16'b1111111100011100, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(16'd2014, 16'b1111111100011100, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(16'b1111111100011100, 16'd10, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(16'b1111111100011100, 16'd10, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(16'b1111111100011100, 16'd10, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(16'b1111111100011100, 16'd10, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(16'b1111111100011100, 16'd10, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(16'b1111111100011100, 16'd10, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(16'b1111111100011100, 16'd10, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(16'b1111111100011100, 16'd10, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(16'b1111111100011100, 16'd10, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(16'b1111111100011100, 16'd10, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(16'b1111111100011100, 16'd10, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(16'b1111111100011100, 16'd10, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(16'b1111111100011100, 16'd10, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(16'b1111111100011100, 16'd10, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(16'b1111111100011100, 16'd10, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(16'b1111111100011100, 16'd10, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(16'd10, 16'd10, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(16'd10, 16'd10, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(16'd10, 16'd10, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(16'd10, 16'd10, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(16'd10, 16'd10, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(16'd10, 16'd10, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(16'd10, 16'd10, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(16'd10, 16'd10, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(16'd10, 16'd10, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(16'd10, 16'd10, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(16'd10, 16'd10, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(16'd10, 16'd10, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(16'd10, 16'd10, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(16'd10, 16'd10, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(16'd10, 16'd10, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(16'd10, 16'd10, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(16'd0, 16'd0, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(16'd0, 16'd0, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(16'd0, 16'd0, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(16'd0, 16'd0, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(16'd0, 16'd0, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(16'd0, 16'd0, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(16'd0, 16'd0, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(16'd0, 16'd0, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(16'd0, 16'd0, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(16'd0, 16'd0, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(16'd0, 16'd0, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(16'd0, 16'd0, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(16'd0, 16'd0, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(16'd0, 16'd0, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(16'd0, 16'd0, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(16'd0, 16'd0, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(-16'd149, 16'd50, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(-16'd149, 16'd50, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(-16'd149, 16'd50, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(-16'd149, 16'd50, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(-16'd149, 16'd50, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(-16'd149, 16'd50, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(-16'd149, 16'd50, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(-16'd149, 16'd50, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(-16'd149, 16'd50, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(-16'd149, 16'd50, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(-16'd149, 16'd50, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(-16'd149, 16'd50, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(-16'd149, 16'd50, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(-16'd149, 16'd50, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(-16'd149, 16'd50, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(-16'd149, 16'd50, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(-16'd149, -16'd50, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(-16'd149, -16'd50, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(-16'd149, -16'd50, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(-16'd149, -16'd50, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(-16'd149, -16'd50, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(-16'd149, -16'd50, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(-16'd149, -16'd50, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(-16'd149, -16'd50, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(-16'd149, -16'd50, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(-16'd149, -16'd50, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(-16'd149, -16'd50, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(-16'd149, -16'd50, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(-16'd149, -16'd50, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(-16'd149, -16'd50, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(-16'd149, -16'd50, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(-16'd149, -16'd50, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(-16'd149, 16'd8367, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(-16'd149, 16'd8367, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(-16'd149, 16'd8367, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(-16'd149, 16'd8367, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(-16'd149, 16'd8367, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(-16'd149, 16'd8367, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(-16'd149, 16'd8367, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(-16'd149, 16'd8367, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(-16'd149, 16'd8367, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(-16'd149, 16'd8367, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(-16'd149, 16'd8367, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(-16'd149, 16'd8367, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(-16'd149, 16'd8367, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(-16'd149, 16'd8367, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(-16'd149, 16'd8367, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(-16'd149, 16'd8367, 1'd1, 1'd1, 2'd3); // Division - -

        ///////////////

        test_case(16'd5346, 16'd8367, 1'd0, 1'd0, 2'd0); // addition + +
        test_case(16'd5346, 16'd8367, 1'd1, 1'd0, 2'd0); // addition - +
        test_case(16'd5346, 16'd8367, 1'd0, 1'd1, 2'd0); // addition + -
        test_case(16'd5346, 16'd8367, 1'd1, 1'd1, 2'd0); // addition - -

        test_case(16'd5346, 16'd8367, 1'd0, 1'd0, 2'd1); // subtraction + +
        test_case(16'd5346, 16'd8367, 1'd1, 1'd0, 2'd1); // subtraction - +
        test_case(16'd5346, 16'd8367, 1'd0, 1'd1, 2'd1); // subtraction + -
        test_case(16'd5346, 16'd8367, 1'd1, 1'd1, 2'd1); // subtraction - -

        test_case(16'd5346, 16'd8367, 1'd0, 1'd0, 2'd2); // Multiplication + +
        test_case(16'd5346, 16'd8367, 1'd1, 1'd0, 2'd2); // Multiplication - +
        test_case(16'd5346, 16'd8367, 1'd0, 1'd1, 2'd2); // Multiplication + -
        test_case(16'd5346, 16'd8367, 1'd1, 1'd1, 2'd2); // Multiplication - -

        test_case(16'd5346, 16'd8367, 1'd0, 1'd0, 2'd3); // Division + +
        test_case(16'd5346, 16'd8367, 1'd1, 1'd0, 2'd3); // Division - +
        test_case(16'd5346, 16'd8367, 1'd0, 1'd1, 2'd3); // Division + -
        test_case(16'd5346, 16'd8367, 1'd1, 1'd1, 2'd3); // Division - -
        #200;
        $finish;
    end

task test_case;
    input signed [31:0] a, b;
    input c, d;
    input [1:0] e;
    real Lx_real, Ly_real, Lz_real;
    integer operation;
    
    begin
        Lx = a;
        Ly = b;
        Sx = c;
        Sy = d;
        op = e;
        #10;
        operation = e[1] ? e[0] ? Divide : multiply : e[0] ? minus : plus;
        Lx_real = 2.0 ** (a / 1024.0);
        Ly_real = 2.0 ** (b / 1024.0);
        Lz_real = 2.0 ** (Lz / 1024.0);

        $display("%c%f %c %c%f = %c%f", c ? minus : space, (Lx == -228) ? 0 : Lx_real, operation, d ? minus : space, (Ly == -228) ? 0 : Ly_real, Sz ? minus : space, (Lz == -228) ? 0 : Lz_real);
        #20;
    end
endtask

    
endmodule