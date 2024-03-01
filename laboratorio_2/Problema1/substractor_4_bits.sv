module complement #(parameter N=4)(
	input [N-1:0] in,
	output reg [N-1:0] complement);
	
	always_comb begin
		complement = (~in) + 1'b1;
	end
	
endmodule

module substractor_4_bits #(parameter N=4)(
  input [N-1:0] A,
  input [N-1:0] B,
  output [N-1:0] Difference,
  output logic Bout,
  output reg flagV,
  output reg flagC,
  output reg flagZ,
  output reg flagN
);

  wire [N-1:0] B_complement;
  wire [N-1:0] Sum;

  complement #(N) comp_B (.in(B), .complement(B_complement));

  adder_4_bits #(N) adder (.A(A), .B(B_complement), .Sum(Sum), .Cout(Bout), .flagV(flagV), .flagC(flagC), .flagZ(flagZ));

  assign Difference = Sum;
  
  always_comb begin
  
		flagN = 0;
		
		if (Difference != 0)begin
			flagN = ~Bout;
		end
  end 
 
endmodule
