`include "Math_Unit_8Bit.v"
`include "and8_8bit.v"
`include "divider_8bit_gate.v"
`include "multiplier_8bit_gate.v"
`include "mux6to1_8bit.v"
`include "or_8bit.v"

module ALU_8Bit (
    input [7:0] a,           // Operand from Accumulator
    input [7:0] b,           // Operand from Data Register
    input sub,               // Subtraction signal
    input [2:0] op_select,   // Operation select
    output [7:0] result      // Unified result output
);

    wire [7:0] sum;               // Sum output from Math_Unit_8Bit
    wire [7:0] and_result_internal; // AND operation result
    wire [7:0] or_result_internal;  // OR operation result
    wire [7:0] multiply_result;    // Multiplication result
    wire [7:0] divide_result;      // Division result

    // Instantiate Math_Unit_8Bit for addition and subtraction
    Math_Unit_8Bit math_unit (
        .a(a),
        .b(b),
        .sub(sub),
        .sum(sum)
    );

    // 8-bit AND operation
    assign and_result_internal = a & b;

    // 8-bit OR operation
    assign or_result_internal = a | b;

    // Instantiate Multiplier and Divider
    multiplier_8bit mul (
        .a(a),
        .b(b),
        .product(multiply_result)
    );

    divider_8bit div (
        .dividend(a),
        .divisor(b),
        .quotient(divide_result)
        // Removed remainder as it's not used
    );

    // 6-to-1 MUX to select between different operation results
    mux6to1_8bit mux (
        .in0(sum),                // Addition result
        .in1(sum),                // Subtraction result (same as addition when sub=1)
        .in2(and_result_internal), // AND result
        .in3(or_result_internal),  // OR result
        .in4(multiply_result),     // Multiplication result
        .in5(divide_result),       // Division result
        .sel(op_select),           // Operation select
        .out(result)               // Unified result output
    );
endmodule
