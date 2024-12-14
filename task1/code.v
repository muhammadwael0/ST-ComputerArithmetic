// there are problems with some corner cases
// I tried so hard to fix the code  


`timescale 1ns / 1ps

module brent_kung_adder (
    input  [63:0] A,
    input  [63:0] B,
    input         Cin,
    output [63:0] Sum,
    output        Cout
);
    wire [63:0] G_in = A & B;
    wire [63:0] P_in = A ^ B;
    wire [63:0] G_out;
    wire [63:0] P_out;

    brent_kung_64_bit add_64(
        .Gin(G_in),
        .Pin(P_in),
        .Gout(G_out),
        .Pout(P_out)
    );

    wire [63:0] Carry;
    assign Carry[0] = Cin;

    generate
      	for (genvar i = 1; i <= 63; i = i + 1) begin : carry_compute
          assign Carry[i] = G_out[i - 1] | (P_out[i - 1] & Cin);
        end
    endgenerate

  assign Cout = G_out[63] | (P_out[63] & Cin);
    assign Sum = P_out ^ Carry;

endmodule

////////////////////////////////////////////////////////////////////////

module brent_kung_64_bit (
    input  [63:0] Gin,
    input  [63:0] Pin,
    output [63:0] Gout,
    output [63:0] Pout
);
    wire [63:0] Gi;
    wire [63:0] Pi;
    wire [63:0] Go;
    wire [63:0] Po;

    genvar i;

    generate
        for (i = 0; i < 64; i = i + 1) begin : up_computation
            if (i % 2 != 0)
            begin : cond_if
                assign Gi[i] = Gin[i] | (Pin[i] & Gin[i - 1]);
                assign Pi[i] = Pin[i] & Pin[i - 1];
            end
            else
            begin : cond_else
                assign Gi[i] = Gin[i];
                assign Pi[i] = Pin[i];
            end
        end
    endgenerate

    brent_kung_32_bit add_32(
        .Gin(Gi),
        .Pin(Pi),
        .Gout(Go),
        .Pout(Po)
    );

    generate
        for (i = 0; i < 64; i = i + 1) begin : down_computation
            if ((i % 2 == 0) && (i != 0))
            begin : cond
                assign Gout[i] = Go[i] | (Po[i] & Go[i - 1]);
                assign Pout[i] = Po[i] & Po[i - 1];
            end
            else
            begin : cond
                assign Gout[i] = Go[i];
                assign Pout[i] = Po[i];
            end
        end
    endgenerate

endmodule

////////////////////////////////////////////////////////////////////////////////////////

module brent_kung_32_bit (
    input  [63:0] Gin,
    input  [63:0] Pin,
    output [63:0] Gout,
    output [63:0] Pout
);
    wire [63:0] Gi;
    wire [63:0] Pi;
    wire [63:0] Go;
    wire [63:0] Po;

    genvar i, j;

    generate
        for (i = 3; i < 64; i = i + 4) begin : up_computation
            for (j = i - 3; j < i; j = j + 1) begin : inner_loop_up
                assign Gi[j] = Gin[j];
                assign Pi[j] = Pin[j];
            end
            assign Gi[i] = Gin[i] | (Pin[i] & Gin[i - 2]);
            assign Pi[i] = Pin[i] & Pin[i - 2];
        end
    endgenerate

    brent_kung_16_bit add_16 (
        .Gin(Gi),
        .Pin(Pi),
        .Gout(Go),
        .Pout(Po)
    );

    generate
        for (i = 5; i < 64; i = i + 4) begin : down_computation
            for (j = i - 3; j < i; j = j + 1) begin : inner_loop_down
                assign Gout[j] = Go[j];
                assign Pout[j] = Po[j];
            end
            assign Gout[i] = Go[i] | (Po[i] & Go[i - 2]);
            assign Pout[i] = Po[i] & Po[i - 2];
        end
    endgenerate

    generate
        for (i = 0; i < 2; i = i + 1) begin : down_dropped
            assign Gout[i] = Go[i];
            assign Pout[i] = Po[i];
        end
    endgenerate
    generate
        for (i = 62; i < 64; i = i + 1) begin : up_dropped
            assign Gout[i] = Go[i];
            assign Pout[i] = Po[i];
        end
    endgenerate
endmodule

///////////////////////////////////////////////////////////////////////////////////////////

module brent_kung_16_bit (
    input  [63:0] Gin,
    input  [63:0] Pin,
    output [63:0] Gout,
    output [63:0] Pout
);
    wire [63:0] Gi;
    wire [63:0] Pi;
    wire [63:0] Go;
    wire [63:0] Po;

    genvar i, j;

    generate
        for (i = 7; i < 64; i = i + 8) begin : up_computation
            for (j = i - 7; j < i; j = j + 1) begin : inner_loop_up
                assign Gi[j] = Gin[j];
                assign Pi[j] = Pin[j];
            end
            assign Gi[i] = Gin[i] | (Pin[i] & Gin[i - 4]);
            assign Pi[i] = Pin[i] & Pin[i - 4];
        end
    endgenerate

    brent_kung_8_bit add_8 (
        .Gin(Gi),
        .Pin(Pi),
        .Gout(Go),
        .Pout(Po)
    );

    generate
        for (i = 11; i < 64; i = i + 8) begin : down_computation
            for (j = i - 7; j < i; j = j + 1) begin : inner_loop_down
                assign Gout[j] = Go[j];
                assign Pout[j] = Po[j];
            end
            assign Gout[i] = Go[i] | (Po[i] & Go[i - 4]);
            assign Pout[i] = Po[i] & Po[i - 4];
        end
    endgenerate

    generate
        for (i = 0; i < 4; i = i + 1) begin : down_dropped
            assign Gout[i] = Go[i];
            assign Pout[i] = Po[i];
        end
    endgenerate
    generate
        for (i = 60; i < 64; i = i + 1) begin : up_dropped
            assign Gout[i] = Go[i];
            assign Pout[i] = Po[i];
        end
    endgenerate

endmodule

//////////////////////////////////////////////////////////////////////////////////////////

module brent_kung_8_bit (
    input  [63:0] Gin,
    input  [63:0] Pin,
    output [63:0] Gout,
    output [63:0] Pout
);
    wire [63:0] Gi;
    wire [63:0] Pi;
    wire [63:0] Go;
    wire [63:0] Po;

    genvar i, j;

    generate
        for (i = 15; i < 64; i = i + 16) begin : up_computation
            for (j = i - 15; j < i; j = j + 1) begin : inner_loop_up
                assign Gi[j] = Gin[j];
                assign Pi[j] = Pin[j];
            end
            assign Gi[i] = Gin[i] | (Pin[i] & Gin[i - 8]);
            assign Pi[i] = Pin[i] & Pin[i - 8];
        end
    endgenerate

    brent_kung_4_bit add_4 (
        .Gin(Gi),
        .Pin(Pi),
        .Gout(Go),
        .Pout(Po)
    );

    generate
        for (i = 23; i < 64; i = i + 16) begin : down_computation
            for (j = i - 15; j < i; j = j + 1) begin : inner_loop_down
                assign Gout[j] = Go[j];
                assign Pout[j] = Po[j];
            end
            assign Gout[i] = Go[i] | (Po[i] & Go[i - 8]);
            assign Pout[i] = Po[i] & Po[i - 8];
        end
    endgenerate

    generate
        for (i = 0; i < 8; i = i + 1) begin : down_dropped
            assign Gout[i] = Go[i];
            assign Pout[i] = Po[i];
        end
    endgenerate
    generate
        for (i = 56; i < 64; i = i + 1) begin : up_dropped
            assign Gout[i] = Go[i];
            assign Pout[i] = Po[i];
        end
    endgenerate
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////

module brent_kung_4_bit (
    input  [63:0] Gin,
    input  [63:0] Pin,
    output [63:0] Gout,
    output [63:0] Pout
);
    wire [63:0] Gi;
    wire [63:0] Pi;
    wire [63:0] Go;
    wire [63:0] Po;

    genvar i, j;

    generate
        for (i = 31; i < 64; i = i + 32) begin : up_computation
            for (j = i - 31; j < i; j = j + 1) begin : inner_loop_up
                assign Gi[j] = Gin[j];
                assign Pi[j] = Pin[j];
            end
            assign Gi[i] = Gin[i] | (Pin[i] & Gin[i - 16]);
            assign Pi[i] = Pin[i] & Pin[i - 16];
        end
    endgenerate

    brent_kung_2_bit add_2 (
        .Gin(Gi),
        .Pin(Pi),
        .Gout(Go),
        .Pout(Po)
    );

    generate
        for (i = 47; i < 64; i = i + 32) begin : down_computation
            for (j = i - 31; j < i; j = j + 1) begin : inner_loop_down
                assign Gout[j] = Go[j];
                assign Pout[j] = Po[j];
            end
            assign Gout[i] = Go[i] | (Po[i] & Go[i - 16]);
            assign Pout[i] = Po[i] & Po[i - 16];
        end
    endgenerate

    generate
        for (i = 0; i < 16; i = i + 1) begin : down_dropped
            assign Gout[i] = Go[i];
            assign Pout[i] = Po[i];
        end
    endgenerate
    generate
        for (i = 48; i < 64; i = i + 1) begin : up_dropped
            assign Gout[i] = Go[i];
            assign Pout[i] = Po[i];
        end
    endgenerate
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////

module brent_kung_2_bit (
    input  [63:0] Gin,
    input  [63:0] Pin,
    output [63:0] Gout,
    output [63:0] Pout
);
    wire [63:0] G;
    wire [63:0] P;

    assign G[63] = Gin[63] | (Pin[63] & Gin[31]);
    assign P[63] = Pin[63] & Pin[31];

    genvar i;

    generate
        for (i = 0; i < 63; i = i + 1)
        begin : down_dropped
            assign G[i] = Gin[i];
            assign P[i] = Pin[i];
        end
    endgenerate

    assign Gout = G;
    assign Pout = P;

endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////