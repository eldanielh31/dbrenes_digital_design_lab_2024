module generadorMatriz #(parameter ancho = 4'd5) (
    input [0:9] x,
    input [0:9] y,
    input reg [11:0] matrixGame [0:9][0:9], // Matriz 10x5
    output logic [7:0] red,
    output logic [7:0] green,
    output logic [7:0] blue
);

    logic color_blanco;
    logic [0:9] stepx;
    logic [0:9] stepy;
    logic [0:9] x0;
    logic [0:9] y0;
    logic [0:9] i; // Cambiado el rango de i a 10 bits para la matriz 10x5
    logic [0:9] j;

    always_comb begin
        color_blanco = 0;
        i = 0;
        j = 0;

        stepx = (10'd640 - ancho) / 10'd10; // Cambiar el divisor a 10 para tener 10 columnas
        stepy = (10'd480 - ancho) / 10'd5;
        x0 = stepx / 10'd2 + ancho / 10'd2; // Cambiar el divisor a 10 para tener 10 columnas
        y0 = stepy / 5'd2 + ancho / 10'd2;
		  

        for (i = 0; i < 10; i = i + 1) begin // Cambiar el límite a 10 para tener 10 columnas
            x0 = stepx / 10'd2 + ancho / 10'd2; // Cambiar el divisor a 10 para tener 10 columnas
            for (j = 0; j < 10; j = j + 1) begin // Iterar sobre las 5 filas
                if ((x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + stepy / 2 + ancho / 2 > y0 && y + stepy / 2 < y0 + ancho / 2) 
                     || (x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + ancho / 2 > y0 + stepy / 2 && y < y0 + stepy / 2 + ancho / 2) 
                     || (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x + stepx / 2 + ancho / 2 > x0 && x + stepx / 2 < x0 + ancho / 2) 
                     || (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x > x0 - ancho / 2 + stepx / 2 && x < x0 + stepx / 2 + ancho / 2)) begin
                    color_blanco = 1;
                end else if (matrixGame[i][j] == 12'd0) begin
                    red = 8'b00000000;
                    green = 8'b11111111;
                    blue = 8'b00000000;
                end 
                x0 = x0 + stepx;
            end
            y0 = y0 + stepy;
        end
		  

        if (color_blanco) begin
            red = 8'b11111111;
            green = 8'b11111111;
            blue = 8'b11111111;
        end else begin
            red = 8'b00000000;
            green = 8'b00000000;
            blue = 8'b00000000;
        end 
		  
		   // Agregar la línea verde en el medio
        if (x >= 10'd320 - ancho / 2 - 4 && x <= 10'd320 + ancho / 2 - 4) begin
            red = 8'b00000000;
            green = 8'b11111111;
            blue = 8'b00000000;
        end
    end

endmodule


