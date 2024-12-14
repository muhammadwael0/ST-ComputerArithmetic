`timescale 1ns / 1ps

module tb_brent_kung_adder();
    reg [63:0] A, B;
  	reg Cin;
    wire [63:0] Sum;        
    wire CarryOut;       

    brent_kung_adder add (
        .A(A),
        .B(B),
      	.Cin(Cin),
        .Sum(Sum),
        .Cout(CarryOut)
    );

    initial begin
 
        A = 64'hFFFFFFFF00000000; B = 64'h00000000FFFFFFFF; Cin = 1; #10; 
        $display("A: %h, B: %h, Cin = %b, Sum: %h, CarryOut: %b", A, B, Cin, Sum, CarryOut);
        A = 64'hFFFFFFFF00000000; B = 64'h00000000FFFFFFFF; Cin = 0; #10; 
        $display("A: %h, B: %h, Cin = %b, Sum: %h, CarryOut: %b", A, B, Cin, Sum, CarryOut);
        A = 64'h0000000000000001; B = 64'h0000000000000001; Cin = 1; #10; 
        $display("A: %h, B: %h, Cin = %b, Sum: %h, CarryOut: %b", A, B, Cin, Sum, CarryOut);
        A = 64'h0000000000000000; B = 64'h00000000FFFFFFFF; Cin = 1; #10; 
        $display("A: %h, B: %h, Cin = %b, Sum: %h, CarryOut: %b", A, B, Cin, Sum, CarryOut);
        A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0000000000000000; Cin = 1; #10; 
        $display("A: %h, B: %h, Cin = %b, Sum: %h, CarryOut: %b", A, B, Cin, Sum, CarryOut);
      $finish;
    end

endmodule