module or8_8bit (
    input [7:0] a,  // 8-bit input
    output [7:0] y  // Changed from 1-bit to 8-bit output
);

    // Perform bitwise OR operation across all bits of the input using a reduction operator
    assign y = {8{|a}};  // Replicate the result to match 8-bit output

endmodule
