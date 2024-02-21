module Bin_BCD(
   input [3:0] binary_input, // 4 bits input
   output reg [7:0] bcd_output; // 8 bits output
);

integer i; // Counter

//Executes every time the input changes
always @(binary_input) begin

   bcd_output = 0;
	
	//For loop to iterate the 4 bits input
   for (i = 0; i < 4; i = i + 1) begin 
      if (bcd_output[3:0] >= 5) bcd_output[3:0] = bcd_output[3:0] + 3;  // If the bits from 3 to 0 are greater or equal than 5, adds 3 to the bits from 3 to 0
      if (bcd_output[7:4] >= 5) bcd_output[7:4] = bcd_output[7:4] + 3;  // If the bits from 7 to 4 are greater or equal than 5, adds 3 to the bits from 7 to 4
      bcd_output = {bcd_output[6:0], binary_input[3-i]};  // BCD value                
   end
end
endmodule
