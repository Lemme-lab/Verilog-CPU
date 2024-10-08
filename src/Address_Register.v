module Address_Register (
    input [7:0] instruction,  // 8-bit instruction
    output reg [3:0] address  // Address for the operand (lower 4 bits of the instruction)
);
    // Declare unused bits outside the always block
    /* verilator lint_off UNUSEDSIGNAL */
    wire [3:0] unused_instruction_bits = instruction[7:4];  // Unused upper bits of instruction
    /* verilator lint_on UNUSEDSIGNAL */

    always @(*) begin
        address = instruction[3:0];  // Use only the lower 4 bits
    end
endmodule
