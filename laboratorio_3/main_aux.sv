module main_aux(
				input clock,
				input reset,
				input logic direction,
				input logic move_h,
				input logic move_v,
				input logic fire,
				input logic place_boat,
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

	
	reg [49:0] array_player; // Matriz principal del jugador
	reg [49:0] array_pc; // Matriz principal de la computadora
	
	reg [2:0] current_boat_row;
	reg [2:0] current_boat_col;
	
	reg [2:0] boat_row;
	reg [2:0] boat_col;
	
	reg [2:0] select_row; // Fila seleccionada despues de un movimiento
	reg [2:0] select_col; // Columna selecciona despues de un movimiento
	
	reg [2:0] current_row; // Fila actualmente seleccionada
	reg [2:0] current_col; // Columna actualmente seleccionada
	
	logic [2:0] amount_boats_out;
	
   reg start = 1; // Señal de inicio para comenzar el juego
	wire full_boat_placed; // Señal que indica si el jugador colocó un barco completo
	wire time_expired; // Señal que indica si se agotó el límite de tiempo
	wire [2:0] boats_player; // Barcos restantes del jugador
	wire [2:0] boats_pc; // Barcos restantes de la maquina
	wire player_mov; // Condicion que indica si el jugador se movio 
	wire state;
	
	wire logic shootState;
	wire logic [3:0] countBoat;
	
	wire logic [2:0] current_boats;
	
	// Maquina de estados de todo el juego
	Battleship_FSM uut (
    .clk(clock),
    .rst(reset),
    .full_boat_placed(full_boat_placed),
    .time_expired(time_expired),
    .boats_player(boats_player),
    .boats_pc(boats_pc),
    .player_mov(player_mov),
    .pc_mov(pc_mov),
    .state(state)
   );
  
  modify_amount_boats amount_inst (
	.current_amount_boats(amount_boats),
	.amount_boats(amount_boats_out)
	
  );
  
  // Modulo del siete segmentos que muestra la cantidad de barcos
  SieteSeg seg_inst(
  .amount_boats(amount_boats_out),
  .boats_player(boats_player),
  .boats_pc(boats_pc),
  .segAmount(segAmount),
  .segPlayer(segPlayer),
  .segPc(segPc)
  );
  
  // Modulo que revisa si todos los barcos han sido posicionados
  boats boats_inst (
	.amount_boats(amount_boats_out), 
	.boats_placed(boats_player), 
	.full_boat_placed(full_boat_placed)
  ); 
  
  place_boats place_boats_inst (
    .state(state),
    .clock(clock),
    .reset(reset),
    .move_h(move_h),
    .move_v(move_v),
    .direction(direction),
    .place_boat(place_boat),
    .amount_boats(amount_boats_out),
    .current_boat_row(current_boat_row),
    .current_boat_col(current_boat_col),
    .boat_row(boat_row),
    .boat_col(boat_col)
	);
	
	// Modulo para actualizar la fila y colunma actual
  update_boat_row_col update_boat_inst(
    .clock(clock),
	 .reset(reset),
	 .current_boat_row(current_boat_row),
    .current_boat_col(current_boat_col),
    .boat_row(boat_row),
    .boat_col(boat_col)
  );
  
  // Modulo de el movimiento de la seleccion del jugador
  move move_inst (
	 .move_h(move_h),
	 .move_v(move_v),
	 .direction(direction),
	 .player_mov(player_mov),
	 .clock(clock),
	 .reset(reset),
	 .current_row(current_row),
	 .current_col(current_col),
	 .select_row(select_row),
	 .select_col(select_col)
  );
  
  // Modulo para actualizar la fila y colunma actual
  update_row_col update_inst(
    .clock(clock),
	 .reset(reset),
	 .current_row(current_row),
	 .current_col(current_col),
	 .select_row(select_row),
	 .select_col(select_col)
  
  );
  
  // Modulo para simular el tablero de el jugador
  Battleship_Board battleship_inst_player (
    .row(boat_row),
    .col(boat_col),
	 .state(state),
    .ship_assign(place_boat), // 1: asignar barco, 0: disparar
	 .amount_boats(amount_boats), 
    .board(array_player), // 2 bits por celda para un tablero de 5x5
	 .countBoats(boats_player),
	 .current_boats(current_boats)
	);
	
	update_current_boats current_boats_inst(
		.clock(clock),
		.reset(reset),
		.countBoat(boats_player),
		.current_boats(current_boats)
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
				.boat_row(boat_row),
				.boat_col(boat_col),
				.amount_boats(amount_boats_out),
				.red(red),
				.green(green),
				.blue(blue),
				.vgaclock(vgaclock),
				.hsync(hsync),
				.vsync(vsync),
				.n_blank(n_blank)
	);
  
	


endmodule 