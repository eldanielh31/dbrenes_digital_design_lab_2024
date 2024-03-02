module seven_segments #(parameter N=4) ( 
	input reg [N-1:0] C,
	output reg [6:0] seg);  
											
	always_comb begin
	
		seg = 0;

		case (C)
			0:  seg = 7'b0000001; //0
			1:  seg = 7'b1001111; //1
			2:  seg = 7'b0010010; //2
			3:  seg = 7'b0000110; //3
			4:  seg = 7'b1001100; //4 
			5:  seg = 7'b0100100; //5
			6:  seg = 7'b0100000; //6
			7:  seg = 7'b0001111; //7
			8:  seg = 7'b0000000; //8
			9:  seg = 7'b0000100; //9
			10: seg = 7'b0001000; //A
			11: seg = 7'b1100000; //B
			12: seg = 7'b0110001; //C
			13: seg = 7'b1000010; //D
			14: seg = 7'b0110000; //E
			15: seg = 7'b0111000; //F
			default: seg = 7'b1111111; //Display nothing if BCD is out of range
		endcase
	 
  end
  
endmodule