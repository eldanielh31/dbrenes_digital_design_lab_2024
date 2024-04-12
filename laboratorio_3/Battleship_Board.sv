module Battleship_Board(
    input logic clk,
    input logic rst,
    input logic [4:0] row,
    input logic [4:0] col,
    input logic fire,
    output logic hit,
    output reg [2:0] matrix_pc [0:4][0:4]
);

    // Parámetros para definir el tamaño del tablero
    parameter ROWS = 5;
    parameter COLS = 5;

    logic [2:0] cell_state; // Estado de la celda seleccionada
	 logic [2:0] temp;


    // Proceso de disparo y actualización del estado del tablero
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reiniciar el tablero en caso de señal de reset
            for (int i = 0; i < ROWS; i++) begin
                for (int j = 0; j < COLS; j++) begin
                    matrix_pc[i][j] = 3'b000; // Celda vacía (0000_0000)
                end
            end
            hit <= 1'b0;
        end else if (fire) begin
            cell_state = matrix_pc[row][col];
				temp = matrix_pc[row][col];
            if (cell_state == 3'b011 || cell_state == 3'b010) begin
                // Si la celda contiene un barco
                hit <= 1'b1;
                matrix_pc[row][col] = {3'b101, cell_state}; // Marcar el barco como impactado
            end else if (cell_state == 3'b001) begin
                // Si la celda no contiene un barco
                hit <= 1'b0;
                matrix_pc[row][col] = 3'b100; // Marcar la celda como disparada
            end
        end else begin
			
				// Si fire es 0 y el valor actual de matrix_pc[row][col] es 1, mantener el valor
             if (matrix_pc[row][col] == 3'b001 || matrix_pc[row][col] == 3'b011) begin
                matrix_pc[row][col] = temp;
            end

		  end
    end
	 

endmodule
