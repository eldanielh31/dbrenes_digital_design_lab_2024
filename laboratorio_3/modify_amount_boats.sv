module modify_amount_boats(
	input logic [2:0] current_amount_boats,
	output logic [2:0] amount_boats
	);
	
	always_comb begin
		amount_boats = 0;
		if(current_amount_boats < 1) begin
			amount_boats = 1;
		end
		else if (current_amount_boats > 5) begin
			amount_boats = 5;
		end
		else begin
			amount_boats = current_amount_boats;
		end
	
	end
	
endmodule 