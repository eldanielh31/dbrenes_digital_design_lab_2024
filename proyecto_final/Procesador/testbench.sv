module testbench();

  // Clock and Reset signals
  reg clk;
  reg reset;

  // Processor interface signals
  wire [31:0] WriteData;
  wire [31:0] DataAdr;
  wire MemWrite;

  // Instantiate the top module
  top uut (
    .clk(clk),
    .reset(reset),
    .WriteData(WriteData),
    .DataAdr(DataAdr),
    .MemWrite(MemWrite)
  );

  // Clock generation
  always begin
		clk <= 1; # 5; clk <= 0; # 5;
	end

  // Reset generation
  initial begin
    reset = 1;
    #15 reset = 0; // Release reset after 15 time units
  end

  // Monitor changes and print relevant signals for debugging
  initial begin
    $monitor("Time: %0t, WriteData: %0h, DataAdr: %0h, MemWrite: %0b", 
             $time, WriteData, DataAdr, MemWrite);
  end

  // Finish simulation after a certain time
  initial begin
    #1000 $finish; // Run simulation for 1000 time units
  end

endmodule