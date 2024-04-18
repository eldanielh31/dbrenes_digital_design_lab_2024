module place_boats(
	input wire PLAY, 
	input clock,
   input reset,
   input wire move_h,
   input wire move_v,
   input wire direction,
	input wire place_boat,
	input logic [2:0] amount_boats,
	input reg [2:0] current_row,
   input reg [2:0] current_col,
   output reg [2:0] select_row,
   output reg [2:0] select_col);
	
reg move_h_state;
reg move_h_state_prev;
reg move_v_state;
reg move_v_state_prev;

always @(posedge clock) begin
	 if (PLAY) begin
		 move_h_state_prev <= move_h_state;
		 move_h_state <= move_h;

		 if (!reset && move_h_state && !move_h_state_prev) begin
			  if (direction && current_col < 4) begin
					// Incrementar select_col cuando move_h es 1 y direction es 1
					select_col <= current_col + 1;
					select_row <= current_row;
			  end
			  else if (!direction && current_col > 0) begin
					// Decrementar select_col cuando move_h es 1 y direction es 0
					select_col <= current_col - 1;
					select_row <= current_row;
			  end
		 end

		 move_v_state_prev <= move_v_state;
		 move_v_state <= move_v;

		 if (!reset && move_v_state && !move_v_state_prev) begin
			  if (direction && current_row > 0) begin
					// Decrementar select_row cuando move_v es 1 y direction es 1
					select_row <= current_row - 1;
					select_col <= current_col;
			  end
			  else if (!direction && current_row < 4) begin
					// Incrementar select_row cuando move_v es 1 y direction es 0
					select_row <= current_row + 1;
					select_col <= current_col;
			  end
		 end
	 end
end

endmodule 