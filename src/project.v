/*
 * Copyright (c) 2024 Lucas Lenarcic
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

`include "CPU.v"

module tt_um_CPU_Lemme (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Convert rst_n to reset signal active high
  wire reset = ~rst_n;

  // Map uio_in signals
  wire [4:0] load_address = uio_in[4:0];  // Use lower 5 bits for load address
  wire load = uio_in[5];                  // Use bit 5 as the load signal
  wire is_instruction = uio_in[6];        // Use bit 6 to differentiate between instruction/data

  // CPU Instance
  CPU cpu_instance (
      .clk(clk), 
      .reset(reset), 
      .cpu_input(ui_in), 
      .load_address(load_address), 
      .load(load), 
      .is_instruction(is_instruction), 
      .output_value(uo_out)
  );

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_oe  = 8'b0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
