module main_aux(
				input clock,
				input reset,
				input logic direction,
				input logic move_h,
				input logic move_v,
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
	logic [7:0] state;
	
	controls controls_inst(
		.direction(direction),
		.move_h(move_h),
		.move_v(move_v),
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
	
	update_matrix_pc update(
					.hit(hit), 
					.fire(fire), 
					.row(row), 
					.col(col), 
					.matrix_pc(matrix_pc));


	controlador_vga(
				.clock(clock),
				.reset(reset),
				.matrix_pc(matrix_pc),
				.red(red),
				.green(green),
				.blue(blue),
				.vgaclock(vgaclock),
				.hsync(hsync),
				.vsync(vsync),
				.n_blank(n_blank)
	);



endmodule 