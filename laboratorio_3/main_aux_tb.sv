module main_aux_tb;

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
	 
	 reg rst;
	 reg full_boat_placed;
	 reg time_expired;
	 reg boats_player;
	 reg boats_pc;
	 reg player_mov;
	 reg pc_mov;
	 reg [2:0]state;
	 reg [2:0]rand_val1;
	 reg [2:0]rand_val2;
	 
	     // Instancia del módulo bajo prueba
    Battleship_Board dut (row, col, ship_assign, shoot, board, shootState, countBoat);
	 Battleship_FSM dut2 (clk, rst, full_boat_placed, time_expired, boats_player, boats_pc, player_mov, pc_mov, state);
	 PseudoRandomModule random (clk, rst, rand_val1, rand_val2);

    initial begin
			rand_val1 = 0;
			rand_val2 = 0;
			
			rst = 0;
			full_boat_placed = 0;
			time_expired = 0;
			boats_player = 1;
			boats_pc = 1;
			player_mov = 0;
			pc_mov = 0;
			state = 3'b0;
			
        clk = 0;
        ship_assign = 0;
        shoot = 0;
		  
		  shootState = 0;
		  countBoat = 3'b0;

			row = 4;
			col = 4;
			ship_assign = 0;
			shoot = 1;
			
			full_boat_placed = 1;
			// Esperar un ciclo
			#10;	
			
			row = 3;
			col = 2;
			ship_assign = 1;
			shoot = 0;
			// Esperar un ciclo
			#10;
			
			row = 3;
			col = 2;
			ship_assign = 0;
			shoot = 1;
			player_mov = 1;
			// Esperar un ciclo
			#10;
			
			
			// Esperar un ciclo
			#10;
			
			pc_mov=1;
			// Esperar un ciclo
			#10;
			$finish;
    end

    // Generar señal de reloj
    always #5 clk = ~clk;

endmodule
