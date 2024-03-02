module ALU_aux #(parameter N=4) ( 

	input logic [N-1:0] A,
	input logic [N-1:0] B, 
	input [1:0] op, 
	output reg [N-1:0] C,
	output reg flagC,
	output reg flagN,
	output reg flagV,
	output reg flagZ,
	output reg [6:0] seg
	
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

	Mux #(N) uut_mux(
	  .sum(sum_result),
	  .sub(sub_result),
	  .op(op),
	  .C(C)
	);
	
	
	seven_segments #(N) uut_seven_seg(
		.C(C),
		.seg(seg)
	);
	
					
endmodule 