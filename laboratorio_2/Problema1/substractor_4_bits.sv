module complement #(parameter N=4)( //Module to get the complement of a numeber 
	input [N-1:0] in, //Number 
	output reg [N-1:0] complement); //Complement
	
	always_comb begin
		complement = (~in) + 1'b1; //Do the operation
	end
	
endmodule

module substractor_4_bits #(parameter N=4)( //Module to substract two 4 bits numbers
  input [N-1:0] A, //4 bits input
  input [N-1:0] B, //4 bits input 
  output [N-1:0] Difference, //Result
  output logic Bout, //Carry out
  output reg flagC, //Carry flag	
  output reg flagN //Negative flag
);
  wire [N-1:0] A_complement; //Complement of A input
  wire [N-1:0] B_complement; //Complement of B input
  wire [N-1:0] Sum; //Result of the add operation
	
  complement #(N) comp_A (.in(A), .complement(A_complement)); //Instance to get the A complement
  complement #(N) comp_B (.in(B), .complement(B_complement)); //Instance to get the A complement

  //Instance to add the complement of the minor number and the other input
  adder_4_bits #(N) adder (.A((A >= B) ? A : A_complement), .B((A >= B) ? B_complement : B), .Sum(Sum), .Cout(Bout), .flagV(flagV), .flagC(flagC));
	
  //Sets the result of the add operation to the result of all the module
  assign Difference = Sum;
  
  always_comb begin
		
		//Initialize variables
		flagN = 0;
		
		if (A < B) begin //Checks if the first number is less than the second number 
			flagN = 1; //In that case puts the flag to negative
		end
		else begin 
			flagN = 0;
		end
  end 
 
endmodule
