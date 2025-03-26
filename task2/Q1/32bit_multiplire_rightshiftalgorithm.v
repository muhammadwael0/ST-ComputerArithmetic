module sum #(parameter N = 32)(
    input [N-1:0]  A,
    input [N-1:0]  B,
    input          Cin,
    output [N-1:0] SUM,
    output         Cout
);
    assign {Cout, SUM} = Cin ? (A + (~B) + 1) : (A + B);
endmodule

module signed_multiplier (
    input rst, clk,
    input signed [31:0] multiplicand,
    input signed [31:0] multiplier,
    output signed [63:0] product
);
    reg [5:0] counter;
    reg signed [63:0] product_reg;
    wire [31:0] adder_out;
    wire adder_Cout, MSB_Shift;

    // adder-sub 
    sum adder (product_reg[63:32], multiplicand, counter[5], adder_out, adder_Cout);

    // mux to solve sign problem
    assign MSB_Shift = counter[5] ? (~multiplicand[31]) : multiplicand[31];

    // counter register
    always @(posedge rst, posedge clk) begin
        if (rst) begin
            counter <= 6'd1;
        end
        else begin
            counter <= counter + 1;
        end
    end

    // product register
    always @(posedge rst, posedge clk) begin
        if (rst) begin
            product_reg <= {32'd0, multiplier};
        end
        else begin
            if (product[0]) begin
                product_reg <= {MSB_Shift, adder_out, product_reg[31:1]};
            end
            else begin
                product_reg <= {product_reg[63], product_reg[63:1]};
            end
        end
    end

    assign product = product_reg;
endmodule