module Battleship_Board (
    input logic [2:0] row,
    input logic [2:0] col,
    input logic ship_assign, 
    input logic shoot,
	 input logic [2:0] state,
	 input wire [2:0] amount_boats,
	 input wire [2:0] current_boats,
    output logic [49:0] board, // 2 bits por celda para un tablero de 5x5
	 output logic shootState,
	 output logic [2:0]countBoats
);

    logic [49:0] board_internal; // Representación interna del tablero
	 int index;
	 logic [2:0]countBoat_internal;

    // Valor inicial para el tablero
    initial begin
        board_internal = 50'b0; // Inicializar todas las celdas en 00
		  countBoat_internal = 3'b000;
    end

    // Asignar barco o disparar
    always @(*) begin
        index = (row * 10) + (col * 2); // Calcular el índice basado en fila y columna

        if (!ship_assign && state == 3'b000 && (amount_boats - current_boats == 1)) begin
            board_internal[index] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
        end else if (!ship_assign && state == 3'b000 && (amount_boats - current_boats == 2)) begin
				board_internal[index] = 1'b1; // Asignar barco
				board_internal[index + 2] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
		  end else if (!ship_assign && state == 3'b000 && (amount_boats - current_boats == 3)) begin
				board_internal[index] = 1'b1; // Asignar barco
				board_internal[index + 2] = 1'b1; // Asignar barco
				board_internal[index + 4] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
		  end else if (!ship_assign && state == 3'b000 && (amount_boats - current_boats == 4)) begin
				board_internal[index] = 1'b1; // Asignar barco
				board_internal[index + 2] = 1'b1; // Asignar barco
				board_internal[index + 4] = 1'b1; // Asignar barco
				board_internal[index + 6] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
		  end else if (!ship_assign && state == 3'b000 && (amount_boats - current_boats == 5)) begin
				board_internal[index] = 1'b1; // Asignar barco
				board_internal[index + 2] = 1'b1; // Asignar barco
				board_internal[index + 4] = 1'b1; // Asignar barco
				board_internal[index + 6] = 1'b1; // Asignar barco
				board_internal[index + 8] = 1'b1; // Asignar barco
				countBoat_internal += 3'b001;
		  end 
        else if (shoot) begin
            board_internal[index + 1] = 1'b1; // Disparar
				countBoat_internal -= board_internal[index] && board_internal[index + 1]? 3'b1 : 3'b0;
        end
    end

    // Salida del tablero
    assign board = board_internal;
	 assign shootState = board_internal[index] && board_internal[index + 1];
	 assign countBoats = countBoat_internal;

endmodule

