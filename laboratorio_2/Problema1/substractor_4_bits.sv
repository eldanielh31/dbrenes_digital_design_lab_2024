module substractor_4_bits (
  input [3:0] A, 
  input [3:0] B,  
  output [3:0] result, 
  output borrow 
);

  wire [3:0] A_not;  
  wire [3:0] B_plus_1;  
  wire [3:0] sum;    

  assign A_not = ~A + 4'b1;

  
  assign B_plus_1 = B + 4'b1;

  assign sum = A_not + B_plus_1;

  assign result = sum[3:0];
  assign borrow = sum[4];

endmodule
