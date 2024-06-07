`timescale 1ns/1ps

module imem_tb;

  // Testbench signals
  logic [31:0] a;
  logic [31:0] rd;

  // Instantiate the imem module
  imem uut (
    .a(a),
    .rd(rd)
  );

  // Clock and reset signals for simulation purposes
  logic clk;
  logic reset;

  // Generate a clock signal
	always begin
		clk <= 1; # 5; clk <= 0; # 5;
	end

  // Test procedure
  initial begin
    // Initialize signals
    reset = 1;
    a = 0;
    #10 reset = 0;

    // Wait for memory initialization
    #10;

    // Apply test cases
    $display("Starting Test...");

     for (int i = 0; i < 32; i++) begin
      a = i * 4;  // Access word-aligned addresses
      #10;  // Wait for data to stabilize
      $display("Address: %h, Data: %h", a, rd);
    end

    // Additional test cases can be added here
		
    // Finish the simulation
    #50;
    $display("Test Complete.");
    $finish;
  end

endmodule
