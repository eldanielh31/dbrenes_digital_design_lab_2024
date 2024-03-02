module Mux #(parameter N=4) (
	
	input logic [N-1:0] sum, sub, //Inputs
	input [1:0] op, //Input of the operation
	output reg [N-1:0] C); //Result


	always_comb begin
	
		case (op)
			
			//Operation Sum
			2'b00: C = sum;
			
			//Operation Subtract
			2'b01: C = sub;
					
			default: C = 4'b0000;

		endcase
	
	end
endmodule