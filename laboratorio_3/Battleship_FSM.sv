module Battleship_FSM (
  input wire clk, // Entrada de reloj
  input wire rst, // Entrada de reinicio
  input wire full_boat_placed, // Señal que indica si el jugador colocó un barco completo
  input wire time_expired, // Señal que indica si se agotó el límite de tiempo
  input wire [2:0] boats_player,
  input wire [2:0] boats_pc,
  input wire player_mov,
  input wire pc_mov,
  output logic [2:0] state
);

  // Define estados
  typedef enum logic [2:0] {
    START,
    PLAY,
    PC,
    WIN,
    LOSE
  } state_t;

  state_t current_state;

  // Registros para estado y próximo estado
  state_t state_reg, next_state_reg;

  // Lógica de transición de estado
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state_reg <= START;
    end else begin
      state_reg <= next_state_reg;
    end
  end

  // Lógica de próximo estado
  always @(*) begin
    case (state_reg)
      START: begin
        next_state_reg = full_boat_placed ? PLAY : START;
      end
      PLAY: begin
			next_state_reg = (time_expired || player_mov) ? PC : PLAY;
			
      end
      PC: begin
			next_state_reg = 	!pc_mov ? PC :
									(boats_pc == 3'd0) ? WIN :
								  (boats_player == 3'd0) ? LOSE :
								  PLAY;
      end
      WIN, LOSE: begin
        next_state_reg = state_reg;
      end
      default: next_state_reg = START;
    endcase
  end

  // Lógica de salida
  assign current_state = state_reg;
	assign state = current_state;

endmodule

