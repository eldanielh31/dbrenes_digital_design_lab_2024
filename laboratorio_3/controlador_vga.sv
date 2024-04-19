module controlador_vga(	input  clock,
								input  reset,
								input [49:0] array_player,
								input [49:0] array_pc,
								input logic win,
								input logic lose,
								input reg [4:0] select_row,
								input reg [4:0] select_col,
								input reg [4:0] boat_row,
								input reg [4:0] boat_col,
								input logic [2:0] amount_boats,
								output [7:0] red,
								output [7:0] green,
								output [7:0] blue,
								output vgaclock,
								output hsync,
								output vsync,
								output n_blank);
							  
	logic [0:9] pixel_num;
	logic [0:9] linea_num;
	logic cambio_linea;
	logic clock_25;

   //generate
	clock25mh clock_iml(clock, clock_25);
	
	
	contador_horizontal contador_horizontal (	.reloj(clock_25), 
															.reset(reset), 
															.numero_pixel(pixel_num), 
															.cambio_linea(cambio_linea));
														
										
	contador_vertical contador_vertical (	.reloj(cambio_linea),
														.reset(reset),
														.numero_linea(linea_num));
								
			
	sincronizador sincronizador(.pixel_num(pixel_num),
										.linea_num(linea_num),
										.hsync(hsync), 
										.vsync(vsync), 
										.n_blank(n_blank));
										
										
	generadorMatriz generadorCuadricula (
        .x(pixel_num),
        .y(linea_num),
		  .array_player(array_player),
		  .array_pc(array_pc),
		  .select_row(select_row),
		  .select_col(select_col),
		  .boat_row(boat_row),
		  .boat_col(boat_col),
		  .amount_boats(amount_boats),
		  .win(win),
		  .lose(lose),
        .red(red),
        .green(green),
        .blue(blue));
	 
	assign vgaclock = clock_25;
	//endgenerate
	
endmodule 