module FullAdder (
    input   A,
    input   B,
    input   Cin,
    output  Sum,
    output  Carry
);
    assign Sum = A ^ B ^ Cin;
    assign Carry = (A & B) | (B & Cin) | (A & Cin); 
endmodule

module Compressor_4to2 #(parameter N = 32)(
    input [N-1:0]  A, B, C, D,
    output [N-1:0] Sum, Carry
);
    wire [N-1:0] FA_carry, FA1_sum;

generate
    genvar i;
    for (i = 0; i < N; i = i + 1) begin
        if (i == 0) begin
            FullAdder FA1 (.A(A[i]), .B(B[i]), .Cin(C[i]), .Sum(FA1_sum[i]), .Carry(FA_carry[i]));
            FullAdder FA2 (.A(0), .B(FA1_sum[i]), .Cin(D[i]), .Sum(Sum[i]), .Carry(Carry[i]));
        end
        else begin
            FullAdder FA1 (.A(A[i]), .B(B[i]), .Cin(C[i]), .Sum(FA1_sum[i]), .Carry(FA_carry[i]));
            FullAdder FA2 (.A(FA_carry[i-1]), .B(FA1_sum[i]), .Cin(D[i]), .Sum(Sum[i]), .Carry(Carry[i]));
        end
    end
endgenerate

endmodule

module FullTreeMultiplier(
    input [63:0] nums [31:0],
    output [63:0] Sum, carry
);
    // level 1
    Compressor_4to2 comp_lv1_1 (.A(nums[0], nums[1], nums[2]))
endmodule