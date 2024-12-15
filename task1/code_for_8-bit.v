// this code is working for all corner casses i 've tested

`timescale 1ns / 1ps

module brent_kung_adder (
    input [7:0] A,
    input [7:0] B,
    input       Cin,
  	output [7:0] Sum,
    output Carry_out
);

    wire [7:0] G = A & B;
    wire [7:0] P = A ^ B;

    wire [7:0] Gn_1;
    wire [7:0] Pn_1;
    wire [7:0] Gn_2;
    wire [7:0] Pn_2;
    wire [7:0] Gn_3;
    wire [7:0] Pn_3;
    wire [7:0] Gn_4;
    wire [7:0] Pn_4;
    wire [7:0] Gn_5;
    wire [7:0] Pn_5;

    // Level 1
    assign Gn_1[1] = G[1] | (P[1] & G[0]);
  	assign Pn_1[1] = P[1] & P[0];
    assign Gn_1[3] = G[3] | (P[3] & G[2]);
  	assign Pn_1[3] = P[3] & P[2];
    assign Gn_1[5] = G[5] | (P[5] & G[4]);
  	assign Pn_1[5] = P[5] & P[4];
    assign Gn_1[7] = G[7] | (P[7] & G[6]);
  	assign Pn_1[7] = P[7] & P[6];

    assign Gn_1[0] = G[0];
    assign Gn_1[2] = G[2];
    assign Gn_1[4] = G[4];
    assign Gn_1[6] = G[6];

    assign Pn_1[0] = P[0];
    assign Pn_1[2] = P[2];
    assign Pn_1[4] = P[4];
    assign Pn_1[6] = P[6];

    // Level 2
    assign Gn_2[3] = Gn_1[3] | (Pn_1[3] & Gn_1[1]);
  	assign Pn_2[3] = Pn_1[3] & Pn_1[1];
    assign Gn_2[7] = Gn_1[7] | (Pn_1[7] & Gn_1[5]);
  	assign Pn_2[7] = Pn_1[7] & Pn_1[5];

    assign Gn_2[0] = Gn_1[0];
    assign Gn_2[1] = Gn_1[1];
    assign Gn_2[2] = Gn_1[2];
    assign Gn_2[4] = Gn_1[4];
    assign Gn_2[5] = Gn_1[5];
    assign Gn_2[6] = Gn_1[6];

    assign Pn_2[0] = Pn_1[0];
    assign Pn_2[1] = Pn_1[1];
    assign Pn_2[2] = Pn_1[2];
    assign Pn_2[4] = Pn_1[4];
    assign Pn_2[5] = Pn_1[5];
    assign Pn_2[6] = Pn_1[6];


    // Level 3
    assign Gn_3[7] = Gn_2[7] | (Pn_2[7] & Gn_2[3]);
  	assign Pn_3[7] = Pn_2[7] & Pn_2[3];

    assign Gn_3[0] = Gn_2[0];
    assign Gn_3[1] = Gn_2[1];
    assign Gn_3[2] = Gn_2[2];
    assign Gn_3[3] = Gn_2[3];
    assign Gn_3[4] = Gn_2[4];
    assign Gn_3[5] = Gn_2[5];
    assign Gn_3[6] = Gn_2[6];

    assign Pn_3[0] = Pn_2[0];
    assign Pn_3[1] = Pn_2[1];
    assign Pn_3[2] = Pn_2[2];
    assign Pn_3[3] = Pn_2[3];
    assign Pn_3[4] = Pn_2[4];
    assign Pn_3[5] = Pn_2[5];
    assign Pn_3[6] = Pn_2[6];

    // Level 4
    assign Gn_4[5] = Gn_3[5] | (Pn_3[5] & Gn_3[3]);
  	assign Pn_4[5] = Pn_3[5] & Pn_3[3];

    assign Gn_4[0] = Gn_3[0];
    assign Gn_4[1] = Gn_3[1];
    assign Gn_4[2] = Gn_3[2];
    assign Gn_4[3] = Gn_3[3];
    assign Gn_4[4] = Gn_3[4];
    assign Gn_4[6] = Gn_3[6];
    assign Gn_4[7] = Gn_3[7];

    assign Pn_4[0] = Pn_3[0];
    assign Pn_4[1] = Pn_3[1];
    assign Pn_4[2] = Pn_3[2];
    assign Pn_4[3] = Pn_3[3];
    assign Pn_4[4] = Pn_3[4];
    assign Pn_4[6] = Pn_3[6];
    assign Pn_4[7] = Pn_3[7];

    // Level 5
    assign Gn_5[2] = Gn_4[2] | (Pn_4[2] & Gn_4[1]);
  	assign Pn_5[2] = Pn_4[2] & Pn_4[1];
    assign Gn_5[4] = Gn_4[4] | (Pn_4[4] & Gn_4[3]);
  	assign Pn_5[4] = Pn_4[4] & Pn_4[3];
    assign Gn_5[6] = Gn_4[6] | (Pn_4[6] & Gn_4[5]);
  	assign Pn_5[6] = Pn_4[6] & Pn_4[5];

    assign Gn_5[0] = Gn_4[0];
    assign Gn_5[1] = Gn_4[1];
    assign Gn_5[3] = Gn_4[3];
    assign Gn_5[5] = Gn_4[5];
    assign Gn_5[7] = Gn_4[7];

    assign Pn_5[0] = Pn_4[0];
    assign Pn_5[1] = Pn_4[1];
    assign Pn_5[3] = Pn_4[3];
    assign Pn_5[5] = Pn_4[5];
    assign Pn_5[7] = Pn_4[7];

  	wire [7:0] Carry;
    assign Carry[0] = Cin;

    generate
      	for (genvar i = 0; i < 7; i = i + 1) begin : loop
            assign Carry[i+1] = Gn_5[i] ^ (Pn_5[i] & Cin);
            end
    endgenerate

    assign Carry_out = Gn_5[7] | (Pn_5[7] & Cin);
    assign Sum = P ^ Carry;
endmodule

module tb_brent_kung_adder();

  	reg [7:0] A, B;
  	reg Cin;
  	wire [7:0] Sum;        
    wire CarryOut;       

    brent_kung_adder add (
        .A(A),
        .B(B),
      	.Cin(Cin),
        .Sum(Sum),
      .Carry_out(CarryOut)
    );

    initial begin
 
      A = 8'b00000001; B = 8'b000000011; Cin = 1; #10; 
      $display("A: %h, B: %h, Cin = %b, Sum: %h, CarryOut: %b", A, B, Cin, Sum, CarryOut);

      A = 8'b00100001; B = 8'b000000011; Cin = 1; #10; 
      $display("A: %h, B: %h, Cin = %b, Sum: %h, CarryOut: %b", A, B, Cin, Sum, CarryOut);
      
      A = 8'b00000001; B = 8'b000000011; Cin = 0; #10; 
      $display("A: %h, B: %h, Cin = %b, Sum: %h, CarryOut: %b", A, B, Cin, Sum, CarryOut);
      
      $finish;
    end

endmodule