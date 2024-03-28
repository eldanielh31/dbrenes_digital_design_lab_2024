module vga_pattern (
    input logic clk,
    output reg [7:0] vga_red,
    output reg [7:0] vga_green,
    output reg [7:0] vga_blue,
    output reg hsync,
    output reg vsync
);

    // Parámetros VGA
    parameter H_DISPLAY = 640; // Ancho de la pantalla
    parameter H_FRONT_PORCH = 16; // Porción frontal de sincronización horizontal
    parameter H_SYNC_PULSE = 96; // Pulso de sincronización horizontal
    parameter H_BACK_PORCH = 48; // Porción posterior de sincronización horizontal
    parameter V_DISPLAY = 480; // Altura de la pantalla
    parameter V_FRONT_PORCH = 10; // Porción frontal de sincronización vertical
    parameter V_SYNC_PULSE = 2; // Pulso de sincronización vertical
    parameter V_BACK_PORCH = 33; // Porción posterior de sincronización vertical

    // Contadores para sincronización horizontal y vertical
    reg [9:0] h_counter = 0;
    reg [9:0] v_counter = 0;

    // Sincronización horizontal
    always @(posedge clk) begin
        if (h_counter < H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH - 1) begin
            h_counter <= h_counter + 1;
        end else begin
            h_counter <= 0;
        end
    end

    // Sincronización vertical
    always @(posedge clk) begin
        if (h_counter == H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH - 1) begin
            if (v_counter < V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH - 1) begin
                v_counter <= v_counter + 1;
            end else begin
                v_counter <= 0;
            end
        end
    end

    // Señales de sincronización
    always @* begin
        if (h_counter >= H_DISPLAY + H_FRONT_PORCH && h_counter < H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE)
            hsync = 1'b0;
        else
            hsync = 1'b1;

        if (v_counter >= V_DISPLAY + V_FRONT_PORCH && v_counter < V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE)
            vsync = 1'b0;
        else
            vsync = 1'b1;
    end

    // Patrón de colores simple
    always @* begin
        if (h_counter >= H_DISPLAY || v_counter >= V_DISPLAY) begin
            vga_red = 8'h00;
            vga_green = 8'h00;
            vga_blue = 8'h00;
        end else begin
            // Aquí puedes definir tu patrón de colores
            // Por ejemplo, aquí hay un patrón de barras de colores
            if (h_counter < H_DISPLAY/4) begin
                vga_red = 8'hFF;
                vga_green = 8'h00;
                vga_blue = 8'h00;
            end else if (h_counter < H_DISPLAY/2) begin
                vga_red = 8'h00;
                vga_green = 8'hFF;
                vga_blue = 8'h00;
            end else if (h_counter < 3*H_DISPLAY/4) begin
                vga_red = 8'h00;
                vga_green = 8'h00;
                vga_blue = 8'hFF;
            end else begin
                vga_red = 8'hFF;
                vga_green = 8'hFF;
                vga_blue = 8'hFF;
            end
        end
    end

endmodule
