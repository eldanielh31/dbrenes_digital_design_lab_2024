module main_aux(
				input clock,
				input reset,
				input logic direction,
				input logic move_h,
				input logic move_v,
				input logic fire,
				input logic fire_pc,
				input logic place_boat,
				input logic [2:0] amount_boats,
				output logic led,
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
	
	reg [2:0] shoot_row_pc;
	reg [2:0] shoot_col_pc;
	
	logic [2:0] amount_boats_out;
	
	logic full_boat_placed; // Señal que indica si el jugador colocó un barco completo
	logic time_expired; // Señal que indica si se agotó el límite de tiempo
	logic [2:0] boats_player; // Barcos restantes del jugador
	logic [2:0] boats_pc; // Barcos restantes de la maquina
	logic player_mov; // Condicion que indica si el jugador se movio 
	logic pc_mov;
	logic [2:0] state;
	
	logic shootState;
	logic [3:0] countBoat;
	
	logic [2:0] current_boats;

	
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
  .boats_pc(state),
  .segAmount(segAmount),
  .segPlayer(segPlayer),
  .segPc(segPc)
  );
  
  // Modulo que revisa si todos los barcos han sido posicionados
  boats boats_inst (
	.amount_boats(amount_boats_out), 
	.boats_placed(boats_player), 
	.clock(clock),
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
	 .boats_player(boats_player),
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
  
  PseudoRandomModule random (
  .clk(clock), 
  .rst(reset), 
  .rand_val1(shoot_row_pc), 
  .rand_val2(shoot_col_pc)
  );
 
  
  // Modulo para simular el tablero de el jugador
  Battleship_Board battleship_inst_player (
    .row(boat_row),
    .col(boat_col),
	 .rand_row(shoot_row_pc),
	 .rand_col(shoot_col_pc),
	 .state(state),
    .ship_assign(place_boat), // 1: asignar barco, 0: disparar
	 .amount_boats(amount_boats), 
    .board(array_player), // 2 bits por celda para un tablero de 5x5
	 .countBoats(boats_player),
	 .current_boats(current_boats),
	 .clock(clock),
	 .player_mov(0),
	 .pc_mov(pc_mov),
	 .reset(reset),
	 .shoot(fire_pc)
	);
	
	//
	Battleship_Board battleship_inst_pc (
		.row(select_row),
		.col(select_col),
		.rand_row(shoot_row_pc),
		.rand_col(shoot_col_pc),
		.state(state),
		.amount_boats(amount_boats), 
		.current_boats(boats_pc),
		.board(array_pc),
		.countBoats(boats_pc),
		.clock(clock),
	   .reset(reset),
		.shoot(fire),
		.player_mov(player_mov),
		.pc_mov(0)
	);
	
	assign led = fire;
	
	// modulo para actualizar la cantidad actula de barcos
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
				.state(state),
				.array_player(array_player),
				.array_pc(array_pc),
				.select_row(select_row),
				.select_col(select_col),
				.boat_row(boat_row),
				.boat_col(boat_col),
				.amount_boats(amount_boats_out),
				.boats_player(boats_player),
				.red(red),
				.green(green),
				.blue(blue),
				.vgaclock(vgaclock),
				.hsync(hsync),
				.vsync(vsync),
				.n_blank(n_blank)
	);
  
	


endmodule 