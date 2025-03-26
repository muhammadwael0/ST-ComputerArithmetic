module Full_Adder (
    input A,
    input B,
    input Cin,
    output Sum,
    output Carry
);
    assign Sum = A ^ B ^ Cin;
    assign Carry = (A & B) | (B & Cin) | (A & Cin);
endmodule

module array_multiplier (
    input signed [31:0] multiplicand,
    input signed [31:0] multiplier,
    output signed [63:0] product
);
    wire [31:0] partial_product [31:0];

    wire [30:0] Sum [31:0];
    wire [30:0] Carry [30:0];

    wire FA_Carry [30:0];

    wire FA1_Sum, FA1_Carry;
    wire FA2_Sum, FA2_Carry;

    genvar i, j;
    generate
        for (i = 0; i < 32; i = i + 1) begin: PARTIAL_PRODUCTS
            for (j = 0; j < 32; j = j + 1) begin : INNER_LOOP
                if (i == 31 && j != 31) begin
                    assign partial_product[i][j] = multiplicand[i] & (~multiplier[j]);
                end
                else begin
                    if (j == 31 && i != 31) begin
                        assign partial_product[i][j] = (~multiplicand[i]) & multiplier[j];
                    end
                    else begin
                        assign partial_product[i][j] = multiplicand[i] & multiplier[j];
                    end
                end
            end
        end
    endgenerate

    generate
        for (i = 0; i < 31; i = i + 1) begin : OUTER_LOOP
            for (j = 0; j < 31; j = j + 1) begin : INNER_LOOP
                Full_Adder FA (
                    .A((i == 0) ? partial_product[31-j][0] : (j == 0) ? partial_product[31][i] : Sum[i-1][j-1]),
                    .B(partial_product[30-j][i+1]),
                    .Cin((i == 0) ? 1'd0 : Carry[i-1][j]),
                    .Sum(Sum[i][j]),
                    .Carry(Carry[i][j])
                );
            end
        end
    endgenerate

    generate
        for (i = 0; i < 31; i = i + 1) begin : OUTER_LOOP
            Full_Adder FA (
                .A((i == 30) ? FA2_Sum : Sum[30][29-i]),
                .B(Carry[30][30-i]),
                .Cin((i == 0) ? FA1_Carry : FA_Carry[i-1]),
                .Sum(Sum[31][30-i]),
                .Carry(FA_Carry[i])
            );
        end
    endgenerate

    assign product[0] = partial_product[0][0];

    generate
        for (i = 0; i < 30; i = i + 1) begin : LOOP
            assign product[i + 1] = Sum[i][30];
        end
    endgenerate

    assign product[31] = FA1_Sum;

    generate
        for (i = 0; i < 31; i = i + 1) begin : LOOP
            assign product[i + 32] = Sum[31][30-i];
        end
    endgenerate

    Full_Adder FA1 (
        .A(multiplicand[31]),
        .B(multiplier[31]),
        .Cin(sum[30][30]),
        .Sum(FA1_Sum),
        .Carry(FA1_Carry)
    );

    Full_Adder FA2 (
        .A(~multiplicand[31]),
        .B(~multiplier[31]),
        .Cin(partial_product[31][31]),
        .Sum(FA2_Sum),
        .Carry(FA2_Carry)
    );

    Full_Adder FA3 (
        .A(FA2_Carry),
        .B(1'd1),
        .Cin(FA_Carry[30]),
        .Sum(product[63]),
    );

endmodule