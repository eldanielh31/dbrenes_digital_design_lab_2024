module flags #(parameter N=4) (

	input logic [1:0] inFlagC,
	input logic inFlagN,
	input logic [1:0] inFlagV,
	input logic [10:0] inFlagZ,
	input [1:0] op,
	output reg outFlagC,
	output reg outFlagN,
	output reg outFlagV,
	output reg outFlagZ
	
);

always_comb begin
		
		outFlagC = 0;
		outFlagN = 0;
		outFlagV = 0;
		outFlagZ = 0;

		case (op)
			
			//Operation Sum
			0: begin 
					outFlagC = inFlagC[0];
					outFlagN = 0;
					outFlagV = inFlagV[0];
					outFlagZ = inFlagZ[0];
				end
			//Operation Subtract
			1: begin 
					outFlagC = inFlagC[1];
					outFlagN = inFlagN;
					outFlagV = inFlagV[1];
					outFlagZ = inFlagZ[1];
				end
			default: begin 
					outFlagC = 0;
					outFlagN = 0;
					outFlagV = 0;
					outFlagZ = 0;
				end
		endcase
	
	end
	
endmodule
