module Bin_BCD (
   input [3:0] binary_input,
   output reg [7:0] bcd_output
);

   always_comb begin
      bcd_output = 8'b0000_0000;

      if (binary_input >= 5) bcd_output[3:0] = binary_input + 3;
      else bcd_output[3:0] = binary_input;

      if (binary_input >= 10) bcd_output[7:4] = binary_input + 3;
      else bcd_output[7:4] = binary_input;
   end

endmodule
