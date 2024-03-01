module full_adder ( //1 bit adder module
  input A, B, Cin, //Inputs
  output logic C, Cout //Outputs
);

  assign C = A ^ B ^ Cin; //XOR operation to get the result
  assign Cout = (A & B) | (B & Cin) | (A & Cin); //Operations to get the carry out

endmodule

module adder_4_bits #(parameter N=4)( //4 bits adder module
  input [N-1:0] A,
  input [N-1:0] B,
  output [N-1:0] Sum,
  output logic Cout,
  output reg flagV,
  output reg flagC
);

  wire [3:0] S;
  wire [4:0] C;
  
  full_adder FA0 (.A(A[0]), .B(B[0]), .Cin(1'b0), .C(S[0]), .Cout(C[1]));
  full_adder FA1 (.A(A[1]), .B(B[1]), .Cin(C[1]), .C(S[1]), .Cout(C[2]));
  full_adder FA2 (.A(A[2]), .B(B[2]), .Cin(C[2]), .C(S[2]), .Cout(C[3]));
  full_adder FA3 (.A(A[3]), .B(B[3]), .Cin(C[3]), .C(S[3]), .Cout(C[4]));
  
  
  assign Sum = S;
  assign Cout = C[4];

  always_comb begin
    flagC = 0;
    flagV = 0;
  
    if (Cout == 1) begin
      flagC = 1;
    end 
	 
	 flagV = (A[N-1] & B[N-1] & ~Sum[N-1]) | (~A[N-1] & ~B[N-1] & Sum[N-1]);
  end
endmodule
