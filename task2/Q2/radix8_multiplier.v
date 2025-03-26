module CSA #(parameter N)(
    input [N-1:0]  A,
    input [N-1:0]  B,
    input [N-1:0]  C,
    output [N-1:0] Sum,
    output [N-1:0] Carry
);
    assign Sum = A ^ B ^ C;
    assign Carry = (A & B) | (A & C) | (B & C);
endmodule

module adder #(parameter N)(
    input [N-1:0]  A,
    input [N-1:0]  B,
    input          Cin,
    output [N-1:0] Sum,
    output         Cout
);
    assign {Cout, Sum} = A + B + Cin;
endmodule

module radix8_multiplier (
    input clk, rst,
    input [31:0] multiplier,
    input [31:0] multiplicand,
    output [63:0] product
);

    reg [31:0] multiplier_reg;
    reg [63:0] product_reg;
    reg [31:0] sum_reg;
    reg [32:0] carry_reg;
    reg [3:0] counter;
    reg carry_ff;
    wire small_adder_carry;
    wire [2:0] small_adder_sum;
    wire [32:0] CPA_sum;
    wire [33:0] CSA1_output_sum, CSA1_output_carry;
    wire [33:0] CSA2_output_sum, CSA2_output_carry;
    wire [34:0] CSA3_output_sum, CSA3_output_carry;
    wire [33:0] CSA1_input_a, CSA1_input_b, CSA1_input_c;

    // counter register
    always @(posedge rst, posedge clk) begin
        if (rst) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end

    // multiplier register
    always @(posedge rst, posedge clk) begin
        if (rst) begin
            multiplier_reg <= multiplier;
        end
        else begin
            multiplier_reg = {3'd0, multiplier_reg[31:3]};
        end
    end

    // sum register
    always @(posedge rst, posedge clk) begin
        if (rst) begin
            sum_reg <= 32'd0;
        end
        else begin
            sum_reg <= CSA3_output_sum[34:3];
        end
    end

    // carry register
    always @(posedge rst, posedge clk) begin
        if (rst) begin
            carry_reg <= 33'd0;
        end
        else begin
            carry_reg <= CSA3_output_carry[34:2];
        end
    end

    // product register
    always @(posedge rst, posedge clk) begin
        if (rst) begin
            product_reg <= 64'd0;
        end
        else begin
            if (counter == 11) begin
                product_reg <= {CPA_sum[30:0], product_reg[32:0]};
            end
            else begin
                product_reg <= {product_reg[63:33], small_adder_sum, product_reg[32:3]};
            end
        end
    end

    // carry flip-Flop
    always @(posedge rst, posedge clk) begin
        if (rst) begin
            carry_ff <= 1'b0;
        end
        else begin
            carry_ff <= small_adder_carry;
        end
    end

    assign CSA1_input_a = multiplier_reg[0] ? {{2{multiplicand[31]}}, multiplicand} : 34'd0;
    assign CSA1_input_b = multiplier_reg[1] ? (counter == 10) ? -({multiplicand[31], multiplicand, 1'd0}) : {multiplicand[31], multiplicand, 1'd0} : 34'd0;
    assign CSA1_input_c = multiplier_reg[2] ? {multiplicand, 2'd0} : 34'd0;

    CSA #(34) CSA1 (.A(CSA1_input_a), .B(CSA1_input_b), .C(CSA1_input_c), .Sum(CSA1_output_sum), .Carry(CSA1_output_carry));
    CSA #(34) CSA2 (.A(CSA1_output_sum), .B({{2{sum_reg[31]}},sum_reg}), .C({carry_reg[32],carry_reg}), .Sum(CSA2_output_sum), .Carry(CSA2_output_carry));
    CSA #(35) CSA3 (.A({CSA1_output_carry, 1'd0}), .B({CSA2_output_sum[33], CSA2_output_sum}), .C({CSA2_output_carry, 1'd0}), .Sum(CSA3_output_sum), .Carry(CSA3_output_carry));

    adder #(33) CPA (.A({sum_reg[31],sum_reg}), .B(carry_reg), .Cin(carry_ff), .Sum(CPA_sum));
    adder #(3) small_adder (.A(CSA3_output_sum[2:0]), .B({CSA3_output_carry[1:0], 1'b0}), .Cin(carry_ff), .Sum(small_adder_sum), .Cout(small_adder_carry));

    assign product = product_reg;

endmodule