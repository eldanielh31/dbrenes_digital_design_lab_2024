module main(input  clock,
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
				

main_aux main_aux_inst(
				.clock(clock),
				.reset(reset),
				.direction(direction),
				.moveH(moveH),
				.moveV(moveV),
				.fire(fire),
				.red(red),
				.green(green),
				.blue(blue),
				.vgaclock(vgaclock),
				.hsync(hsync),
				.vsync(vsync),
				.n_blank(n_blank));





endmodule 