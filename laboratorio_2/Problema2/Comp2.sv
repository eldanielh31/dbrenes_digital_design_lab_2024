
///////////////////////////////////////////////////////////
////////////////  -- COMPLEMENTO A 2 --  //////////////////
///////////////////////////////////////////////////////////

module complement2 #(parameter N=4)(input [N-1:0] in,
												output reg [N-1:0] resComp2);
	
	always_comb begin
		resComp2 = (~in) + 1'b1;
	end
	
endmodule