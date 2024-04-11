module main_aux(input  clock,
				input  reset,
				input logic direction,
				input logic moveH,
				input logic moveV,
				input logic fire,
				output [7:0] red,
				output [7:0] green,
				output [7:0] blue,
				output vgaclock,
				output hsync,
				output vsync,
				output n_blank);

reg [1:0] matrix_player [0:4][0:4] = '{'{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}};				
reg [1:0] matrix_pc [0:4][0:4] = '{'{1, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}};				

logic [4:0] row;
logic [4:0] col;

logic hit;
logic state[7:0];

get_player_pos(
	.matrix_pc(matrix_pc),
	.row(row),
	.col(col)
);

Battleship_Board board(
			.clk(clock),
			.rst(reset),
			.row(row),
         .col(col),
			.fire(fire),
         .hit(hit),
         .state(state)
);


controlador_vga(
			.clock(clock),
			.

);



endmodule 