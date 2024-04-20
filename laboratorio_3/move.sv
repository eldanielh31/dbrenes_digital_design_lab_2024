module move(
    input clock, 
    input reset,
	 input logic [2:0] state, 
    input logic move_h, // Variable que determina el movimiento en horizontal
    input logic move_v, // Variable que determina el movimiento en vertical
    input logic direction, // Variable que determina si se va a tener una direccion positiva o negativa
    input reg [2:0] current_row, // Fila en la que el jugador esta posicionado
    input reg [2:0] current_col, // Columna en la que el jugador esta posicionado
    output reg [2:0] select_row, // Fila en la que el jugador se va a posicionar
    output reg [2:0] select_col // Columna en la que el jugador se va a posicionar
);

reg move_h_state; // Registra el estado de la variable move_h
reg move_h_state_prev; // Registra el estado actual de la variable move_h
reg move_v_state; // Registra el estado de la variable move_v
reg move_v_state_prev; // Registra el estado actual de la variable move_h

always @(posedge clock) begin
	if (state == 3'b000) begin
		 move_h_state_prev <= move_h_state;
		 move_h_state <= move_h;
		 
		 if (reset) begin
			select_col <= 0;
			select_row <= 0;
		 end

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
