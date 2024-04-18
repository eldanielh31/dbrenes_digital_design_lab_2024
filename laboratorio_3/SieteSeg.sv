module SieteSeg #(parameter N=3)(
	input reg [N-1:0] amount_boats,
	input reg [N-1:0] boats_player,
	input reg [N-1:0] boats_pc,
	output reg [0:6] segAmount,
	output reg [0:6] segPlayer,
	output reg [0:6] segPc
	); 
	  
	  always @(*) begin
	  
		 case (amount_boats)
			3'b000: segAmount = 7'b1000000;
			3'b001: segAmount = 7'b1111001;
			3'b010: segAmount = 7'b0100100;
			3'b011: segAmount = 7'b0110000;
			3'b100: segAmount = 7'b0011001;
			3'b101: segAmount = 7'b0010010;
			default: segAmount = 7'b1000000;
		 endcase
		 
		 case (boats_player)
			3'b000: segPlayer = 7'b1000000;
			3'b001: segPlayer = 7'b1111001;
			3'b010: segPlayer = 7'b0100100;
			3'b011: segPlayer = 7'b0110000;
			3'b100: segPlayer = 7'b0011001;
			3'b101: segPlayer = 7'b0010010;
			default: segPlayer = 7'b1000000;
		 endcase
		 
		 case (boats_pc)
			3'b000: segPc = 7'b1000000;
			3'b001: segPc = 7'b1111001;
			3'b010: segPc = 7'b0100100;
			3'b011: segPc = 7'b0110000;
			3'b100: segPc = 7'b0011001;
			3'b101: segPc = 7'b0010010;
			default: segPc = 7'b1000000;
		 endcase
	end

  
endmodule