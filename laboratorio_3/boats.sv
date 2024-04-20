module boats(
	input [2:0] amount_boats, 
	input [2:0] boats_placed, 
	input logic clock,
	output logic full_boat_placed);
	
always @(posedge clock) begin
		if (amount_boats == boats_placed) begin // Revisa si la cantidad de barcos establecida coincide con la cantidad de barcos ya puestos
			full_boat_placed = 1'b1;
		end else begin
			full_boat_placed = 1'b0;
		end
	end

endmodule 