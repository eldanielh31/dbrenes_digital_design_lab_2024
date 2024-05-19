module vga(
	input logic clk,
	output logic vgaclk, // 25.175 MHz VGA clock
	output logic hsync, vsync,
	output logic sync_b, blank_b, // To monitor & DAC
	output logic [7:0] r, g, b
); 
	// To video DAC
	logic [9:0] x, y;
	
	// Use a PLL to create the 25.175 MHz VGA pixel clock
	// 25.175 MHz clk period = 39.772 ns
	// Screen is 800 clocks wide by 525 tall, but only 640 x 480 used
	// HSync = 1/(39.772 ns *800) = 31.470 kHz
	// Vsync = 31.474 kHz / 525 = 59.94 Hz (~60 Hz refresh rate)
	vgapll vgapll(.refclk(clk), .outclk_0(vgaclk));
	// Generate monitor timing signals
	vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y);
	// User-defined module to determine pixel color
	videoGen videoGen(x, y, r, g, b);
	
endmodule

module vgaController #(parameter HACTIVE = 10'd640,
                       HFP = 10'd16,
                       HSYN = 10'd96,
                       HBP = 10'd48,
                       HMAX = HACTIVE + HFP + HSYN + HBP,
                       VBP = 10'd32,
                       VACTIVE = 10'd480,
                       VFP = 10'd11,
                       VSYN = 10'd2,
                       VMAX = VACTIVE + VFP + VSYN + VBP)
                      (input logic vgaclk,
                       output logic hsync, vsync, sync_b, blank_b,
                       output logic [9:0] x, y);

    // Contadores para las posiciones horizontales y verticales
    logic [9:0] hcnt, vcnt;

    always @(posedge vgaclk) begin
        if (hcnt == HMAX - 1) begin
            hcnt <= 0;
            if (vcnt == VMAX - 1) begin
                vcnt <= 0;
            end else begin
                vcnt <= vcnt + 1;
            end
        end else begin
            hcnt <= hcnt + 1;
        end
    end

    // Asignar las posiciones x e y de salida
    assign x = (hcnt < HACTIVE) ? hcnt : 10'd0;
    assign y = (vcnt < VACTIVE) ? vcnt : 10'd0;

    // Calcular las señales de sincronización (activo bajo)
    assign hsync = ~(hcnt >= HACTIVE + HFP && hcnt < HACTIVE + HFP + HSYN);
    assign vsync = ~(vcnt >= VACTIVE + VFP && vcnt < VACTIVE + VFP + VSYN);
    assign sync_b = hsync & vsync;

    // Forzar las salidas a negro cuando estén fuera del área de visualización legal
    assign blank_b = (hcnt < HACTIVE) && (vcnt < VACTIVE);

endmodule

module videoGen(
	input logic [9:0] x, y, 
	output logic [7:0] r, g, b
);

	logic pixel, inrect;
	
	// Given y position, choose a character to display
	// then look up the pixel value from the character ROM
	// and display it in red or blue.Also draw a green rectangle.
	chargenrom chargenromb(y[8:3] + 8'd65, x[2:0], y[2:0], pixel);
	rectgen rectgen(x, y, 10'd120, 10'd150, 10'd200, 10'd230, inrect);
	assign {r, b} = (y[3]==0) ? {{8{pixel}},8'h00} : {8'h00,{8{pixel}}};
	//assign g = inrect ? 8'hFF : 8'h00;
	
endmodule

module chargenrom(
	input logic [7:0] ch,
	input logic [2:0] xoff, yoff,
	output logic pixel
);

	logic [5:0] charrom[2047:0]; // character generator ROM
	logic [7:0] line; // a line read from the ROM
	// Initialize ROM with characters from text file
	initial
	$readmemb("charrom.txt", charrom);
	// Index into ROM to find line of character
	assign line = charrom[yoff + {ch-65, 3'b000}]; // Subtract 65 because A
	// is entry 0
	// Reverse order of bits
	assign pixel = line[3'd7-xoff];
	
endmodule

module rectgen(
	input logic [9:0] x, y, left, top, right, bot,
	output logic inrect
);
	assign inrect = (x >= left & x < right & y >= top & y < bot);
endmodule 