
///////////////////////////////////////////////////////////
//////////////////////  -- RESTA --  //////////////////////
///////////////////////////////////////////////////////////

module complement #(parameter N=4)( //Modulo para obtener el complemento de un numero
	input [N-1:0] in, //Numero
	output reg [N-1:0] complement); //Complemento
	
	always_comb begin
		complement = (~in) + 1'b1; //Operacion para obtener el complemento
	end
	
endmodule

module RESTA_op #(parameter N=4)(input logic [N-1:0] a, 
											input logic [N-1:0] b,
											output reg [N-1:0] result,
											output reg flagC,
											output reg flagN,
											output reg flagV,
											output reg flagZ);
	
  wire [N-1:0] A_complement; //Complemento para la entrada A
  wire [N-1:0] B_complement; //Complemento para la entrada B
  wire [N-1:0] Sum; //Resultado de la suma 
	
  complement #(N) comp_A (.in(A), .complement(A_complement)); //Instancia para el complemento de A
  complement #(N) comp_B (.in(B), .complement(B_complement)); //Instancia para el complemento de B

  //Instancia para sumar el complemento del numero menor con el numero mayor
  SUMA_op #(N) adder (.a((a >= b) ? a : A_complement), .b((a >= b) ? B_complement : b), .result(Sum), .flagC(flagC));
	
  //Resultado
  assign result = Sum;										
	
	always_comb begin
		
		//Initialize variables
		flagN = 0;
		flagZ = 0;
		flagV = 0;
		
		if (a < b) begin //Revisa si la primera entrada es menor a la segunda
			flagN = 1; //En ese caso el resultado es negativo
		end
		
		else if (a == b) begin
			flagZ = 1;
		end
		
		else begin 
			flagN = 0;
		end
		
		// FLAG OVERFLOW
		flagV = ((a[N-1] & b[N-1] & (~result[N-1])) | ((~a[N-1]) & (~b[N-1]) & result[N-1]));
		
	end
	
endmodule