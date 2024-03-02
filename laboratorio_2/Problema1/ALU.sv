module ALU #(parameter N=4)( //Main module

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

	// INSTANCIA ALU
	ALU_aux #(.N(N)) alu1(
		.A(A),
		.B(B),
		.C(C),
		.op(op),
		.flagC(flagC),
		.flagN(flagN),
		.flagV(flagV),
		.flagZ(flagZ),
		.seg(seg));
/*

	 
	 //Checks if the result of the operation is 0
    if (C == 0 && flagC != 1) begin
      flagZ = 1;
    end
	 
    else begin
      flagZ = 0;
    end
	 
  end
 */

endmodule


