module Battleship_Board (
	 input logic clock,
	 input logic reset,
    input logic [2:0] row,
    input logic [2:0] col,
    input logic ship_assign, 
	 input logic shoot,
	 input logic [2:0] state,
	 input logic [2:0] amount_boats,
	 input logic [2:0] current_boats,
	 output logic player_mov,
    output logic [49:0] board, // 2 bits por celda para un tablero de 5x5
	 output logic [2:0]countBoats
);

    logic [49:0] board_internal; // Representación interna del tablero
	 int index;
	 logic [2:0]countBoat_internal;
	 
	 reg ship_assign_state = 0; // Registra el estado de la variable move_h
	 reg ship_assign_state_prev = 0; // Registra el estado actual de la variable move_h
	 
	 reg shoot_state = 0; // Registra el estado de la variable move_h
	 reg shoot_state_prev = 0; // Registra el estado actual de la variable move_h 

    // Valor inicial para el tablero
    initial begin
        board_internal = 50'b0; // Inicializar todas las celdas en 00
		  countBoat_internal = 3'b000;
    end
	 

    // Asignar barco o disparar
    always @(posedge clock or posedge reset) begin
	 
		  if (reset) begin
				board_internal <= 50'b0; // Inicializar todas las celdas en 00
				countBoat_internal <= 3'b000;
				player_mov <= 1'b0;
		  end else begin
			  index = (row * 10) + (col * 2); // Calcular el índice basado en fila y columna
			  
			  ship_assign_state_prev <= ship_assign_state;
			  ship_assign_state <= ship_assign;
			  
			  if (ship_assign_state && !ship_assign_state_prev && state == 3'b000 && (amount_boats - current_boats == 3'b001)) begin
				  board_internal[index + 1] <= 1'b1;
				  countBoat_internal += 3'b001;
			  end else if (ship_assign_state && !ship_assign_state_prev && state == 3'b000 && (amount_boats - current_boats == 3'b010)) begin
		  
				board_internal[index + 1] = 1'b1; // Asignar barco
				board_internal[index + 3] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
				
		  end else if (ship_assign_state && !ship_assign_state_prev && state == 3'b000 && (amount_boats - current_boats == 3'b011)) begin
		  
				board_internal[index + 1] = 1'b1; // Asignar barco
				board_internal[index + 3] = 1'b1; // Asignar barco
				board_internal[index + 5] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
				
		  end else if (ship_assign_state && !ship_assign_state_prev && state == 3'b000 && (amount_boats - current_boats == 3'b100)) begin
		  
				board_internal[index + 1] = 1'b1; // Asignar barco
				board_internal[index + 3] = 1'b1; // Asignar barco
				board_internal[index + 5] = 1'b1; // Asignar barco
				board_internal[index + 7] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
				
		  end else if (ship_assign_state && !ship_assign_state_prev && state == 3'b000 && (amount_boats - current_boats == 3'b101)) begin
		  
				board_internal[index + 1] = 1'b1; // Asignar barco
				board_internal[index + 3] = 1'b1; // Asignar barco
				board_internal[index + 5] = 1'b1; // Asignar barco
				board_internal[index + 7] = 1'b1; // Asignar barco
				board_internal[index + 9] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
				
		  end 
		  
        else if (shoot && state == 3'b001 && player_mov == 1'b0) begin
					board_internal[index] = 1'b1; // Disparar
					player_mov = 1'b1;
					countBoat_internal -= board_internal[index] && board_internal[index + 1]? 3'b001 : 3'b000;
        end
		  end
    end

    // Salida del tablero
    assign board = board_internal;
	 assign shootState = board_internal[index] && board_internal[index + 1];
	 assign countBoats = countBoat_internal;

endmodule

