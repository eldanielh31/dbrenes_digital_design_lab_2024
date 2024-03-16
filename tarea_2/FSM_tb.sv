module FSM_tb;
    // Inputs
    reg clk;
    reg rst;
    reg maintenance;

    // Outputs
    wire [7:0] error_code;
    wire [7:0] maintenance_counter;
    wire [7:0] cicles_counter;

    // Instantiate the FSM module
    FSM dut (
        .clk(clk),
        .rst(rst),
        .maintenance(maintenance),
        .error_code(error_code),
        .maintenance_counter(maintenance_counter),
        .cicles_counter(cicles_counter)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Initialize inputs
    initial begin
			clk = 0;
			rst = 1;
			maintenance = 0;

        // Reset
        #10 rst = 0;

        // Simulate button presses and clock cycles
		  // 1 ciclo de FPGA = 20 -> 200 ciclos = #4000
		  maintenance = 1;
		  #20
		  maintenance = 1;
		  #20
		  maintenance = 1;
		  #20
		  maintenance = 0;
		  #4040

        // Finish simulation
        $finish;
    end

    // Monitor outputs
    always @(posedge clk) begin
        $display("State: %b, Error Code: %h, Maintenance Count: %h, Cycles Count: %h", dut.state, error_code, maintenance_counter, cicles_counter);
    end
endmodule
