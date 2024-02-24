module ALU(input [3:0] A, input [3:0] B, input [1:0] op, 
	output [3:0] C, output [1:0] flag);

always @* begin 
	
	case(op)
		
		2'00: c = A + B; //suma
		2'01: c = A - B; //Resta
		2'10: c = A * B; //Multiplicacion
		
		default: C = 4'0000;
	
	endcase
end

endmodule 