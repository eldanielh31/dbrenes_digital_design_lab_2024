
///////////////////////////////////////////////////////////
//////////////////////  -- SUMA --  ///////////////////////
///////////////////////////////////////////////////////////

module sumador_completo ( //Sumador de 1 bit
  input a, b, Cin, 
  output logic c, Cout 
);

  assign c = a ^ b ^ Cin; //Operacion XOR 
  assign Cout = (a & b) | (b & Cin) | (a & Cin); //Operaciones para el carry out

endmodule

module SUMA_op #(parameter N=4) (input logic [N-1:0] a, 
											input logic [N-1:0] b,
											output reg [N-1:0] result,
											output reg flagC,
											output reg flagV,
											output reg flagZ);
	
	
  wire [3:0] S; //Wire para la suma
  wire [4:0] C; //Wire para el carry
  
	
  //Combinacion Logica
  sumador_completo FA0 (.a(a[0]), .b(b[0]), .Cin(1'b0), .c(S[0]), .Cout(C[1]));
  sumador_completo FA1 (.a(a[1]), .b(b[1]), .Cin(result[1]), .c(S[1]), .Cout(C[2]));
  sumador_completo FA2 (.a(a[2]), .b(b[2]), .Cin(result[2]), .c(S[2]), .Cout(C[3]));
  sumador_completo FA3 (.a(a[3]), .b(b[3]), .Cin(result[3]), .c(S[3]), .Cout(C[4]));
  
  
  assign result = S; //Pone el resultad

	always_comb begin
		
		//INICIALIZACIÓN DE VARIABLES
		flagV = 0;
		flagZ = 0;
		flagC = 0;
	
		// FLAG OVERFLOW
		flagV = ((a[N-1] & b[N-1] & (~result[N-1])) | ((~a[N-1]) & (~b[N-1]) & result[N-1]));
		
		// FLAG 0
		if (result == 0)begin
			flagZ = 1;
		end
		else begin 
			flagZ = 0;
		end
		
		//Flag Carry
		if (C[4] == 1)begin
			flagC = 1;
		end
		else begin
			flagC = 0;
		end
	
	end
	
endmodule