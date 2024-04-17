module Battleship_Board_Testbench;

    // Parámetros del testbench
    reg clk;
    reg ship_assign;
    reg shoot;
    wire [49:0] board;

    // Generación de transacciones aleatorias
    reg [2:0] row;
    reg [2:0] col;
	 reg [3:0] countBoat;
	 
	 reg shootState;
	 
	     // Instancia del módulo bajo prueba
    Battleship_Board dut (row, col, ship_assign, shoot, board, shootState, countBoat);

    initial begin
        clk = 0;
        ship_assign = 0;
        shoot = 0;
		  
		  shootState = 0;
		  countBoat = 3'b0;

			row = 4;
			col = 4;
			ship_assign = 0;
			shoot = 1;
			row = row % 5;
			col = col % 5;
			// Esperar un ciclo
			#10;	
			
			row = 0;
			col = 0;
			ship_assign = 1;
			shoot = 0;
			row = row % 5;
			col = col % 5;
			// Esperar un ciclo
			#10;
			
			row = 3;
			col = 2;
			ship_assign = 1;
			shoot = 0;
			row = row % 5;
			col = col % 5;
			// Esperar un ciclo
			#10;
			
			row = 3;
			col = 2;
			ship_assign = 0;
			shoot = 1;
			row = row % 5;
			col = col % 5;
			// Esperar un ciclo
			#10;
			$finish;
    end

    // Generar señal de reloj
    always #5 clk = ~clk;

endmodule


