module Bin_BCD_FPGA(
   input [3:0] binary_input, // 4 bits input
   output reg [6:0] seg // 7 bits output for 7-segment display
);

reg [7:0] bcd_output; // 8 bits BCD output

integer i; // Counter

always @(binary_input) begin
   bcd_output = 0;
   for (i = 0; i < 4; i = i + 1) begin
      if (bcd_output[3:0] >= 5) bcd_output[3:0] = bcd_output[3:0] + 3;  // If the bits from 3 to 0 are greater or equal than 5, adds 3 to the bits from 3 to 0
      if (bcd_output[7:4] >= 5) bcd_output[7:4] = bcd_output[7:4] + 3;   // If the bits from 7 to 4 are greater or equal than 5, adds 3 to the bits from 7 to 4
      bcd_output = {bcd_output[6:0], binary_input[3-i]};  // BCD value                
   end
end

// Connect BCD output to 7-segment display
always @* begin
   case(bcd_output)
      4'h0: seg = 7'b1000000; // BCD: 0
      4'h1: seg = 7'b1111001; // BCD: 1
      4'h2: seg = 7'b0100100; // BCD: 2
      4'h3: seg = 7'b0110000; // BCD: 3
      4'h4: seg = 7'b0011001; // BCD: 4
      4'h5: seg = 7'b0010010; // BCD: 5
      4'h6: seg = 7'b0000010; // BCD: 6
      4'h7: seg = 7'b1111000; // BCD: 7
      4'h8: seg = 7'b0000000; // BCD: 8
      4'h9: seg = 7'b0010000; // BCD: 9
      4'hA: seg = 7'b0001000; // BCD: A 
      4'hB: seg = 7'b0000011; // BCD: B 
      4'hC: seg = 7'b1000110; // BCD: C 
      4'hD: seg = 7'b0100001; // BCD: D 
      4'hE: seg = 7'b0000110; // BCD: E 
      4'hF: seg = 7'b0001110; // BCD: F 
      default: seg = 7'b1111111; // Display nothing if BCD is out of range
   endcase
end

endmodule