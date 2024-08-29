`timescale 1ns / 1ps

module CPU_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [7:0] cpu_input;
    reg [4:0] load_address;
    reg load;
    reg is_instruction;

    // Output
    wire [7:0] output_value;

    // Instantiate the CPU module
    CPU uut (
        .clk(clk),
        .reset(reset),
        .cpu_input(cpu_input),
        .load_address(load_address),
        .load(load),
        .is_instruction(is_instruction),
        .output_value(output_value)
    );

    // Clock generation
    always #5 clk = ~clk;  // Clock period of 10 time units

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        cpu_input = 8'b00000000;
        load_address = 5'b00000;
        load = 0;
        is_instruction = 0;

        // Apply reset
        #10 reset = 0;  // Deassert reset after 10 time units
        #10 reset = 1;  // Assert reset after 10 time units

        // Wait for reset to complete
        #20;

        // Test case 1: Load an instruction into the CPU
        cpu_input = 8'b00000001;  // Example instruction
        load_address = 5'b00000;  // Load into address 0
        load = 1;                 // Enable load
        is_instruction = 1;       // Indicate it's an instruction
        #10 load = 0;             // Disable load after 10 time units

        // Wait for the CPU to process
        #20;

        // Test case 2: Load data into the CPU
        cpu_input = 8'b00001111;  // Example data
        load_address = 5'b00001;  // Load into address 1
        load = 1;                 // Enable load
        is_instruction = 0;       // Indicate it's data
        #10 load = 0;             // Disable load after 10 time units

        // Wait for the CPU to process
        #20;

        // Test case 3: Perform an operation using the ALU
        cpu_input = 8'b00000010;  // Another instruction
        load_address = 5'b00010;  // Load into address 2
        load = 1;                 // Enable load
        is_instruction = 1;       // Indicate it's an instruction
        #10 load = 0;             // Disable load after 10 time units

        // Wait for the CPU to process
        #20;

        // Check the output
        $display("Output Value: %b", output_value);

        // Finish simulation
        #50;
        $stop;
    end

endmodule
