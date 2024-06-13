module top(
	 input logic clk,
	 input logic reset,
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
	
	logic [11:0] char_index;
	logic [7:0] ram_data;
	logic [7:0] ram1_data;
	
	
	logic [11:0] address_ram1;

	Proce procesador (
		.clk(clk),
		.reset(reset), 
		.WriteData(WriteData), 
		.DataAdr(DataAdr),
		.rd(rd_dmem),
		.MemWrite(MemWrite)
	);
	
	memoria_ram text_ram (
        .address(char_index),
        .clock(clk),
        .data(vocales), // Datos no utilizados en este contexto
        .wren(1'b0),
        .q(ram_data)
    );
	 
	 assign address_ram1 = MemWrite ? DataAdr: char_index;
	 
	 ramUpdatedText updated_ram (
        .address(char_index),
        .clock(clk),
        .data(8'd0), // Datos no utilizados en este contexto
        .wren(1'b0),
        .q(ram1_data)
    );

	vga dut_vga (
		.clk(clk),
		.ram_data(ram_data),
		.ram1_data(ram1_data),
		.enable(reset),
		.vgaclk(vgaclk),
		.hsync(hsync),
		.vsync(vsync),
		.sync_b(sync_b),
		.blank_b(blank_b),
		.r(r),
		.g(g),
		.b(b),
		.char_index(char_index)
	);

	seven_segment_display dut_seg (
		.digit(vocales),
		.segments(segA)
	);

endmodule 