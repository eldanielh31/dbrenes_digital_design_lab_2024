module Battleship_Board (
    input logic [2:0] row,
    input logic [2:0] col,
    input logic ship_assign, // 1: asignar barco, 0: disparar
    input logic shoot,
    output logic [49:0] board // 2 bits por celda para un tablero de 5x5
);

    logic [49:0] board_internal; // Representación interna del tablero
	 int index;

    // Valor inicial para el tablero
    initial begin
        board_internal = 50'b0; // Inicializar todas las celdas en 00
    end

    // Asignar barco o disparar
    always @* begin
        index = (row * 10) + (col * 2); // Calcular el índice basado en fila y columna

        if (ship_assign) begin
            board_internal[index] = 1'b1; // Asignar barco
        end 
        else if (shoot) begin
            board_internal[index + 1] = 1'b1; // Disparar
        end
    end

    // Salida del tablero
    assign board = board_internal;

endmodule

