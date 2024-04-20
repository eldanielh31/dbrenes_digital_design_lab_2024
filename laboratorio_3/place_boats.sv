module place_boats(
	input logic [2:0] state, 
	input clock,
   input reset,
   input logic move_h,
   input logic move_v,
   input logic direction,
	input logic place_boat,
	input logic [2:0] amount_boats,
	input logic [2:0] boats_player,
	input reg [2:0] current_boat_row,
   input reg [2:0] current_boat_col,
   output reg [2:0] boat_row,
   output reg [2:0] boat_col);
	
reg move_h_state;
reg move_h_state_prev;
reg move_v_state;
reg move_v_state_prev;

always @(posedge clock) begin
	 if (state == 3'b000) begin
		 move_h_state_prev <= move_h_state;
		 move_h_state <= move_h;
		 
		 if (reset) begin
			boat_col <= 0;
			boat_row <= 0;
		 end

		 if (!reset && move_h_state && !move_h_state_prev) begin
			  if (direction && current_boat_col < 5 - (amount_boats - boats_player)) begin
					// Incrementar boat_col cuando move_h es 1 y direction es 1
					boat_col <= current_boat_col + 1;
					boat_row <= current_boat_row;
			  end
			  else if (!direction && current_boat_col > 0) begin
					// Decrementar boat_col cuando move_h es 1 y direction es 0
					boat_col <= current_boat_col - 1;
					boat_row <= current_boat_row;
			  end
		 end

		 move_v_state_prev <= move_v_state;
		 move_v_state <= move_v;

		 if (!reset && move_v_state && !move_v_state_prev) begin
			  if (direction && current_boat_row > 0) begin
					// Decrementar boat_row cuando move_v es 1 y direction es 1
					boat_row <= current_boat_row - 1;
					boat_col <= current_boat_col;
			  end
			  else if (!direction && current_boat_row < 4) begin
					// Incrementar boat_row cuando move_v es 1 y direction es 0
					boat_row <= current_boat_row + 1;
					boat_col <= current_boat_col;
			  end
		 end
	 end
end

endmodule 