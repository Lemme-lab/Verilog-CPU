`include "full_adder_8bit.v"
`include "or8_8bit.v"

module Math_Unit_8Bit (
    input [7:0] a,     // First 8-bit input
    input [7:0] b,     // Second 8-bit input
    input sub,         // Subtract control signal (1 for subtraction, 0 for addition)
    output [7:0] sum   // 8-bit sum output
);

    wire [7:0] b_xor;      // XOR-ed version of b (for subtraction)
    wire carry_in;         // Carry input to the adder
    wire cout;             // Carry-out from the full adder

    // XOR b with the subtraction signal to handle both addition and subtraction
    assign b_xor = b ^ {8{sub}};

    // Carry input to the adder is the subtraction signal
    assign carry_in = sub;

    // Full adder instance
    full_adder_8bit adder (
        .a(a),
        .b(b_xor),
        .cin(carry_in),
        .sum(sum),
        .cout(cout)  // Connect cout pin
    );

endmodule
