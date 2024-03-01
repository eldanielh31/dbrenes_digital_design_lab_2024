module ALU #(parameter N=4)( //Main module

  input logic [N-1:0] A, //Input 1
  input logic [N-1:0] B, //Input 2
  input logic [1:0] op, //Arimetic or logic operation
  
  output logic [N-1:0] C, //Result of the operation it executes
  output reg flagN, //Flag for negative numbers
  output reg flagC, //Flag for a carry
  output reg flagZ, //Flag for a 0
  output reg flagV //Flag for a overflow
  
);

  wire [N-1:0] sum_result; //Output of the adder
  wire Cout; //Carry of the adder

  wire [N-1:0] sub_result; //Output of the subtractor
  wire Bout; //Carry of the subtractor
  
  //Instance of the adder module
  adder_4_bits #(N) uut_adder (
    .A(A),
    .B(B),
    .Sum(sum_result),
    .Cout(Cout), 
	 .flagV(flagV),
    .flagC(flagC)
  );
	
  //Instance of the subtractor module
  substractor_4_bits #(N) uut_sub (
    .A(A),
    .B(B),
    .Difference(sub_result),
    .Bout(Bout),
    .flagN(flagN)
  );

  always_comb begin
    case (op)
      2'b00: C = sum_result; //Result of the adder
      2'b01: C = sub_result; //Result of the subtractor
      2'b10: C = A * B; //Result of the multiplication
      default: C = 4'b0000; //Default value
    endcase
	 
	 //Checks if the result of the operation is 0
    if (C == 0 && flagC != 1) begin
      flagZ = 1;
    end
	 
    else begin
      flagZ = 0;
    end
	 
  end
  
endmodule


