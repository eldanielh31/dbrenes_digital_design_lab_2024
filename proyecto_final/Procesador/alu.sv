module alu(
	input logic [31:0] SrcA, 
	input logic [31:0] SrcB, 
	input logic [1:0] ALUControl, 
	output logic [31:0] ALUResult, 
	output logic [3:0] ALUFlags
);

always_comb begin
		
	case (ALUControl) 
		
		2'b00: ALUResult = SrcA + SrcB; 
		2'b01: ALUResult = SrcA - SrcB;
		2'b10: ALUResult = SrcA & SrcB;
		2'b11: ALUResult = SrcA | SrcB;
	
	endcase
end	

endmodule 