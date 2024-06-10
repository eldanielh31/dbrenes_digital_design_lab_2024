module vga(
    input logic clk,
	 input logic enable,
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
    videoGen videoGen(vgaclk, enable, x, y, r, g, b);
    
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
    input logic clk,
	 input logic enable,
    input logic [9:0] x, y, 
    output logic [7:0] r, g, b
);
    logic pixel;
    logic [7:0] char;
    logic [11:0] char_index; // Incrementamos el tamaño del índice del carácter
    logic in_text_region;
    logic wren = 1'b0;

    // Define la región en la que se mostrará el texto
    parameter H_START = 0; // Inicio horizontal (en caracteres)
    parameter V_START = 6; // Inicio vertical (en líneas)
    parameter CHAR_WIDTH = 8; // Ancho del carácter en píxeles
    parameter CHAR_HEIGHT = 8; // Altura del carácter en píxeles

    // Calcular el índice de carácter en la RAM en función d\la posición x e y
    assign char_index = (x >= H_START * CHAR_WIDTH && x < (H_START + 80) * CHAR_WIDTH && y >= V_START * CHAR_HEIGHT && y < (V_START + 30) * CHAR_HEIGHT) ? 
                        ((x - H_START * CHAR_WIDTH) / CHAR_WIDTH) + ((y - V_START * CHAR_HEIGHT) / CHAR_HEIGHT) * 80 : 12'd0; // Ajustar el cálculo del índice

    // Verificar si estamos en la región del texto
    assign in_text_region = (x >= H_START * CHAR_WIDTH && x < (H_START + 80) * CHAR_WIDTH && y >= V_START * CHAR_HEIGHT && y < (V_START + 30) * CHAR_HEIGHT);

    // Instancia del módulo RAM
    logic [7:0] ram_data;
	 
	 logic [7:0] ram1_data;
	 
    ram text_rom (
        .address(char_index),
        .clock(clk),
        .data(8'd0), // Datos no utilizados en este contexto
        .wren(wren),
        .q(ram_data)
    );
	 
	 ram1 tex_rom (
        .address(char_index),
        .clock(clk),
        .data(8'd0), // Datos no utilizados en este contexto
        .wren(1'b0),
        .q(ram1_data)
    );

    assign char = enable ? ram1_data - 12'd1 : ram_data - 12'd1;

    // Generar los píxeles del carácter
    chargenrom chargenromb(.ch(char), .xoff(x[2:0]), .yoff(y[2:0]), .pixel(pixel));

    // Asignar color a los píxeles
    assign r = (y[3] == 0 && in_text_region) ? {8{pixel}} : 8'h00;
    assign g = 8'h00; // Se puede usar para agregar color verde si es necesario
    assign b = 8'h00; // Se puede usar para agregar color azul si es necesario
endmodule


module chargenrom(
    input logic [7:0] ch,
    input logic [2:0] xoff, yoff,
    output logic pixel
);

    logic [5:0] charrom[4095:0]; // Incrementar el tamaño de la ROM de caracteres
    logic [7:0] line; // una línea leída de la ROM
    // Inicializar la ROM con caracteres desde un archivo de texto
    initial
    $readmemb("charrom.txt", charrom);
    // Índice en la ROM para encontrar la línea del carácter
    assign line = charrom[(ch << 3) + yoff]; // Usar el carácter directamente como índice, y desplazamiento para la línea
    // Invertir el orden de los bits
    assign pixel = line[3'd7-xoff];
    
endmodule


