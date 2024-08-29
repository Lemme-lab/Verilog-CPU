module multiplier_8bit (
    input [7:0] a,       // 8-bit multiplicand
    input [7:0] b,       // 8-bit multiplier
    output [7:0] product // 8-bit product
);

    // Direct multiplication
    assign product = a * b;  // Perform 8-bit multiplication and assign the result

endmodule
