module main_aux(
				input clock,
				input reset,
				input logic direction,
				input logic move_h,
				input logic move_v,
				input logic fire,
				input logic [2:0] amount_boats,
				output [6:0] segAmount,
				output [6:0] segPlayer,
				output [6:0] segPc,
				output [7:0] red,
				output [7:0] green,
				output [7:0] blue,
				output vgaclock,
				output hsync,
				output vsync,
				output n_blank);

	
	reg [49:0] array_player = 0000000000_0000000000_0000000000_0000000000_0000000000; // Matriz principal del jugador
	reg [49:0] array_pc; // Matriz principal de la computadora
	
	
	reg [2:0] select_row; // Fila seleccionada despues de un movimiento
	reg [2:0] select_col; // Columna selecciona despues de un movimiento
	
	reg [2:0] current_row; // Fila actualmente seleccionada
	reg [2:0] current_col; // Columna actualmente seleccionada
	
   wire start; // Señal de inicio para comenzar el juego
	wire full_boat_placed; // Señal que indica si el jugador colocó un barco completo
	wire time_expired; // Señal que indica si se agotó el límite de tiempo
	reg [2:0] boats_player = 3'd3; // Barcos restantes del jugador
	reg [2:0] boats_pc = 3'd2; // Barcos restantes de la maquina
	wire player_mov; // Condicion que indica si el jugador se movio 
	wire play; 
	wire win; // Señal que indica victoria
	wire lose; // Señal que indica derrota
	
	// Maquina de estados de todo el juego
	Battleship_FSM Battleship_FSM_inst (
    .clk(clk),
    .rst(rst),
    .start(start),
    .full_boat_placed(full_boat_placed),
    .time_expired(time_expired),
    //.boats_player(boats_player),
    //.boats_pc(boats_pc),
    .player_mov(player_mov),
    .play(play),
    .win(win),
    .lose(lose)
  );
  
  // Modulo del siete segmentos que muestra la cantidad de barcos
  SieteSeg seg_inst(
  .amount_boats(amount_boats),
  .boats_player(boats_player),
  .boats_pc(boats_pc),
  .segAmount(segAmount),
  .segPlayer(segPlayer),
  .segPc(segPc)
  );
  
  // Modulo que revisa si todos los barcos han sido posicionados
  boats boats_inst (
	.amount_boats(amount_boats), 
	.boats_placed(boats_player), 
	.full_boat_placed(full_boat_placed)
  ); 
  
  // Modulo de el movimiento de la seleccion del jugador
  move move_inst (
	 .move_h(move_h),
	 .move_v(move_v),
	 .direction(direction),
	 .clock(clock),
	 .reset(reset),
	 .current_row(current_row),
	 .current_col(current_col),
	 .select_row(select_row),
	 .select_col(select_col),
  );
  
  // Modulo para actualizar la fila y colunma actual
  update_row_col update_inst(
    .clock(clock),
	 .reset(reset),
	 .current_row(current_row),
	 .current_col(current_col),
	 .select_row(select_row),
	 .select_col(select_col),
  
  );
  
  // Modulo para simular el tablero de el jugador
  Battleship_Board battleship_inst (
    .row(1),
    .col(1),
    .ship_assign(1), // 1: asignar barco, 0: disparar
    .shoot(fire),
    .board(array_player), // 2 bits por celda para un tablero de 5x5
	);
	
	// Modulo del controlador vga
	controlador_vga controlador_vga_inst(
				.clock(clock),
				.reset(reset),
				.array_player(array_player),
				.array_pc(array_pc),
				.win(win),
				.lose(lose),
				.select_row(select_row),
				.select_col(select_col),
				.red(red),
				.green(green),
				.blue(blue),
				.vgaclock(vgaclock),
				.hsync(hsync),
				.vsync(vsync),
				.n_blank(n_blank)
	);
  
	


endmodule 