module full_adder (
  input A, B, Cin,
  output C, Cout
);

  assign C = A ^ B ^ Cin;
  assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule

module adder_4_bits (
  input [3:0] A,
  input [3:0] B,
  output [3:0] Sum,
  output Cout
);

  wire [3:0] S;
  wire [4:0] C;

  full_adder FA0 (.A(A[0]), .B(B[0]), .Cin(1'b0), .C(S[0]), .Cout(C[1]));
  full_adder FA1 (.A(A[1]), .B(B[1]), .Cin(C[1]), .C(S[1]), .Cout(C[2]));
  full_adder FA2 (.A(A[2]), .B(B[2]), .Cin(C[2]), .C(S[2]), .Cout(C[3]));
  full_adder FA3 (.A(A[3]), .B(B[3]), .Cin(C[3]), .C(S[3]), .Cout(C[4]));

  assign Sum = S;
  assign Cout = C[4];

endmodule
