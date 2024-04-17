module Battleship_Board (
    input logic [2:0] row,
    input logic [2:0] col,
    input logic ship_assign, // 1: asignar barco, 0: disparar
    input logic shoot,
    output logic [49:0] board, // 2 bits por celda para un tablero de 5x5
	 output logic shootState,
	 output logic [3:0]countBoat
);

    logic [49:0] board_internal; // Representación interna del tablero
	 int index;
	 logic [3:0]countBoat_internal;

    // Valor inicial para el tablero
    initial begin
        board_internal = 50'b0; // Inicializar todas las celdas en 00
		  countBoat_internal = 4'b0;
    end

    // Asignar barco o disparar
    always @* begin
        index = (row * 10) + (col * 2); // Calcular el índice basado en fila y columna

        if (ship_assign) begin
            board_internal[index] = 1'b1; // Asignar barco
				countBoat_internal += 4'b1;
        end 
        else if (shoot) begin
            board_internal[index + 1] = 1'b1; // Disparar
				countBoat_internal -= board_internal[index] && board_internal[index + 1]? 4'b1 : 4'b0;
        end
    end

    // Salida del tablero
    assign board = board_internal;
	 assign shootState = board_internal[index] && board_internal[index + 1];
	 assign countBoat = countBoat_internal;

endmodule

