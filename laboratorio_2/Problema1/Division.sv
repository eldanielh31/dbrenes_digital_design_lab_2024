///////////////////////////////////////////////////////////
//////////////////////  -- DIVISION --  ///////////////////////
///////////////////////////////////////////////////////////

module DIVISION_op #(parameter N=4) (input logic [N-1:0] a, 
											input logic [N-1:0] b,
											output reg [N-1:0] result,
											output reg flagC,
											output reg flagV,
											output reg flagZ);

	always_comb begin
		
		//INICIALIZACIÓN DE VARIABLES
		flagC = 0;
		flagV = 0;
		flagZ = 0;
		
		{flagC, result} = a / b;
		
		// FLAG OVERFLOW
		flagV = ((a[N-1] & b[N-1] & (~result[N-1])) | ((~a[N-1]) & (~b[N-1]) & result[N-1]));
		
		// FLAG CERO
		flagZ = (result == 0);
		
		// Bandera de negativo
//      flagN = (result[N-1] == 1);
		
	
	end
	
endmodule