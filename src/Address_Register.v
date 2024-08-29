module Address_Register (
    input [7:0] instruction,  // Changed from 16-bit to 8-bit
    output reg [3:0] address  // Address for the operand
);
    always @(*) begin
        address = instruction[3:0];  // Extract address for operand from the lower 4 bits
    end
endmodule
