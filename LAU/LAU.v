module adder #(parameter N) (
    input [N-1:0] A,
    input [N-1:0] B,
    input Cin,
    output [N-1:0] Sum,
    output Cout
);
    assign {Cout, Sum} = (Cin) ? A + (~B) + Cin : A + B;
endmodule


module Phi_ROM (
    input [15:0] index,
    input select_phi,   // φ+ -> 1 , φ- -> 0
    output signed [15:0] value 
);
    reg [15:0] phi_plus_table [0:10781];  // ROM φ+
    reg [15:0] phi_minus_table [0:10781]; // ROM φ-

    initial begin
        $readmemh("phi_plus.mem", phi_plus_table);
        $readmemh("phi_minus.mem", phi_minus_table);
    end

    assign value = select_phi ? phi_plus_table[(index > 10781) ? 10781 : index] : phi_minus_table[(index > 10781) ? 10781 : index];

endmodule


module LAU (
    input [1:0] op, // 00 -> add , 01 -> Sub , 10 -> mul , 11 -> Div
    input Sx,
    input Sy,
    input signed [15:0] Lx,
    input signed [15:0] Ly,
    input signed [15:0] Lm,
    output Sz,
    output signed [15:0] Lz
); 
    wire comp = (Lx > Ly);
    wire signed [15:0] lx, ly, rom_out, add1_out, lz;

    assign lx = (comp | op[1]) ? Lx : Ly;
    assign ly = (comp | op[1]) ? Ly : Lx;

    wire adder_signal = (op != 2'b10);

    wire signed [15:0] add2_in1 = op[1] ? add1_out : rom_out;
    wire signed [15:0] add2_in2 = op[1] ? Lm : lx;
    wire phi_select = (Sx ^ Sy) ? op[0] : ~op[0];

    // adder 1
    adder #(16) add1 (.A(lx), .B(ly), .Cin(adder_signal), .Sum(add1_out));

    // adder 2
    adder #(16) add2 (.A(add2_in1), .B(add2_in2), .Cin(~adder_signal), .Sum(lz));

    // phi rom
    Phi_ROM rom (.index(add1_out), .select_phi(phi_select), .value(rom_out));

    wire sz = (Sy & ~comp & ~op[0]) | (~Sy & ~comp & op[0]) | (Sx & comp);

    assign Sz = (Lz == 16'b1111111100011100) ? 1'd0 : op[1] ? Sx ^ Sy : sz;    

    // zero -> 111111.1100011100
       assign Lz = op[1] ? ((Lx == 16'b1111111100011100) || (Ly == 16'b1111111100011100)) ? 16'b1111111100011100 : lz : (Lx == 16'b1111111100011100) ? Ly : (Ly == 16'b1111111100011100) ? Lx : (~phi_select && add1_out == 16'd0) ? 16'b1111111100011100 : lz;
endmodule