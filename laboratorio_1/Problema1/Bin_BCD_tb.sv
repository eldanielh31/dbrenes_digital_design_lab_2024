module Bin_BCD_tb();

  reg [3:0] binary_input;
  wire [6:0] bcd_output;

  Bin_BCD dut ( 
  
    .binary_input(binary_input),
    .seg(bcd_output)
	 
  );

  initial begin	//Test values
  
    binary_input = 4'b0001;
    #40 binary_input = 4'b0010;
    #40 binary_input = 4'b0011;
    #40 binary_input = 4'b0100;
	 #40 binary_input = 4'b0101;
	 #40 binary_input = 4'b0110;
	 #40 binary_input = 4'b0111;
	 #40 binary_input = 4'b1000;
	 #40 binary_input = 4'b1111;
	 
  end

endmodule
