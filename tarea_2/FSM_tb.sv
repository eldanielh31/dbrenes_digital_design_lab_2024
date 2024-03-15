module FSM_tb;
    // Inputs
    reg clk;
    reg rst;
    reg x;

    // Outputs
    wire [7:0] a;
    wire [7:0] b;

    // Instantiate the DUT (Design Under Test)
    FSM dut (
        .clk(clk),
        .rst(rst),
        .x(x),
        .a(a),
        .b(b)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initialize inputs
    initial begin
      clk = 0;
      rst = 1;
      x = 0;

      // Reset
      #10 rst = 0;
      #10 rst = 1;
		#10 rst = 0;
		
      // Simulate button presses
      #20 x = 1; // Button pressed
      #20 x = 0; // Button released
      #20 x = 1; // Button pressed again

    end

endmodule
