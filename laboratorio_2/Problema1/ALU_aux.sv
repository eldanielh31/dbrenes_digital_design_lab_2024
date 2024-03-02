module ALU_aux #(parameter N=4) ( 

  input logic [N-1:0] A, //Input 1
  input logic [N-1:0] B, //Input 2
  input logic [1:0] op, //Arimetic or logic operation
  
  output reg [N-1:0] C, //Result of the operation it executes
  output reg [6:0] seg, // Var for the seven segments output
  output reg flagN, //Flag for negative numbers
  output reg flagC, //Flag for a carry
  output reg flagZ, //Flag for a 0
  output reg flagV //Flag for a overflow
	
);
										
	
  wire [N-1:0] sum_result; //Output of the adder
  wire Cout; //Carry of the adder

  wire [N-1:0] sub_result; //Output of the subtractor
  wire Bout; //Carry of the subtractor
  
  wire [1:0] flagsC; 	// FLAG DE ACARREO
  wire flagsN; 			// FLAG DE NEGATIVO
  wire [1:0] flagsV; 	// FLAG DE OVERFLOW
  wire [10:0] flagsZ; 	// FLAG DE CERO
  
  //Instance of the adder module
  adder_4_bits #(N) uut_adder (
    .A(A),
    .B(B),
    .Sum(sum_result),
    .Cout(Cout), 
    .flagC(flagsC[0]),
	 .flagZ(flagsZ[0]),
	 .flagV(flagsV[0])
  );
	
  //Instance of the subtractor module
  substractor_4_bits #(N) uut_sub (
    .A(A),
    .B(B),
    .Difference(sub_result),
    .Bout(Bout),
    .flagN(flagsN),
	 .flagC(flagsC[1]),
	 .flagZ(flagsZ[1]),
	 .flagV(flagsV[1])
  );		
	
	//Instance for the mux comparation
	Mux #(N) uut_mux(
	  .sum(sum_result),
	  .sub(sub_result),
	  .op(op),
	  .C(C)
	);
	
	//Instance for the flags chooser
	flags #(.N(N)) g13 (
		.inFlagC(flagsC),
		.inFlagN(flagsN),
		.inFlagV(flagsV),
		.inFlagZ(flagsZ),
		.op(op),
		.outFlagC(flagC),
		.outFlagN(flagN),
		.outFlagV(flagV),
		.outFlagZ(flagZ));
	
	
	//Instance for the seven segments display
	seven_segments #(N) uut_seven_seg(
		.C(C),
		.seg(seg)
	);
	
					
endmodule 