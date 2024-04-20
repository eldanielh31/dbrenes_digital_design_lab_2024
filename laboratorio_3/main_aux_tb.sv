module main_aux_tb;

    // Parámetros del testbench
    reg clk;
    reg ship_assign;
    reg shoot;
    wire [49:0] board;

    // Generación de transacciones aleatorias
    reg [2:0] row;
    reg [2:0] col;
	 reg [2:0] countBoat;
		 
	 reg rst;
	 reg full_boat_placed;
	 reg time_expired;
	 reg [2:0]boats_player;
	 reg [2:0]boats_pc;
	 reg player_mov;
	 reg pc_mov;
	 reg [2:0]state;
	 reg [2:0]rand_val1;
	 reg [2:0]rand_val2;
	 reg [2:0] amount_boats = 2;
	 reg [2:0] current_boats = 0;
	 
	     // Instancia del módulo bajo prueba
    Battleship_Board dut (clk, rst,row, col, ship_assign, shoot, state, amount_boats, current_boats, player_mov, board, countBoat);
	 Battleship_FSM dut2 (clk, rst, full_boat_placed, time_expired, boats_player, boats_pc, player_mov, pc_mov, state);
	 PseudoRandomModule random (clk, rst, rand_val1, rand_val2);
	 update_current_boats current_boats_inst(
		.clock(clk),
		.reset(rst),
		.countBoat(countBoat),
		.current_boats(current_boats)
	 );
	  // Modulo que revisa si todos los barcos han sido posicionados


    initial begin
			clk = 0;
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
			countBoat = 3'b0;
			

		  //inicio
			ship_assign = 1;
			shoot = 0;
			row = 0;
			col = 0;			
			// Esperar un ciclo
			#20;	
			
			
			ship_assign = 1;
			shoot = 0;
			row = 4;
			col = 4;			
			// Esperar un ciclo
			#10;	
			
			row = 3;
			col = 2;
			ship_assign = 1;
			shoot = 0;
			full_boat_placed = 1;
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
