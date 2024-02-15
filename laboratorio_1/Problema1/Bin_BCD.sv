module Bin_BCD(
   input [3:0] binary_input,
   output reg [7:0] bcd_output
);

integer i;

always @(binary_input) begin
   bcd_output = 0;         
   for (i = 0; i < 4; i = i + 1) begin             // Itera por cada bit de entrada
      if (bcd_output[3:0] >= 5) bcd_output[3:0] = bcd_output[3:0] + 3;  // If BCD digit is >= 5, + 3
      if (bcd_output[7:4] >= 5) bcd_output[7:4] = bcd_output[7:4] + 3;
      bcd_output = {bcd_output[6:0], binary_input[3-i]};                  // Shift un bit, y shift por cada bit del input 
   end
end

endmodule

