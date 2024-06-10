module top(
	 input logic clk,
	 input logic reset,
	 input logic enable,
	 input logic [3:0] vocales,
	 output logic [6:0] segA,
    output logic vgaclk, // 25.175 MHz VGA clock
    output logic hsync, vsync,
    output logic sync_b, blank_b, // To monitor & DAC
    output logic [7:0] r, g, b	
);

	logic [31:0] WriteData;
	logic [31:0] DataAdr;
	logic MemWrite;
	logic [31:0] rd_dmem;
	
	logic read_data;

	Proce procesador (
		.clk(clk),
		.reset(reset), 
		.start(enable),
		.WriteData(WriteData), 
		.DataAdr(DataAdr),
		.rd(rd_dmem),
		.MemWrite(MemWrite)
	);

	vga dut_vga (
		.clk(clk),
		.enable(enable),
		.vgaclk(vgaclk),
		.hsync(hsync),
		.vsync(vsync),
		.sync_b(sync_b),
		.blank_b(blank_b),
		.r(r),
		.g(g),
		.b(b)
	);

	seven_segment_display dut_seg (
		.digit(vocales),
		.segments(segA)
	);

endmodule 