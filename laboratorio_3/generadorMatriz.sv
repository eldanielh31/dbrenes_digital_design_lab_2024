module generadorMatriz #(parameter ancho = 4'd5) (
    input [0:9] x,
    input [0:9] y,
    input reg [1:0] matrix_player [0:4][0:4], // Matriz 10x5
	 input reg [2:0] matrix_pc [0:4][0:4], // Matriz 10x5
	 //input logic win,
	 input logic lose,
    output logic [7:0] red,
    output logic [7:0] green,
    output logic [7:0] blue
);

    logic color_blanco;
	 logic color_azul;
	 logic color_rojo;
	 logic color_verde;
	 logic color_celeste;
	 logic gano;
    logic [0:9] stepx;
    logic [0:9] stepy;
    logic [0:9] x0;
    logic [0:9] y0;
    logic [0:9] i; // Cambiado el rango de i a 10 bits para la matriz 10x5
    logic [0:9] j;
	 logic [0:4] ajuste_x;
	 logic [0:4] ajuste_y;
	 logic win;
	 
    always_comb begin
        color_blanco = 0;
		  color_azul = 0;
		  color_rojo = 0;
		  color_verde = 0;
		  color_celeste = 0;
		  win = 0;
		  
		  
        i = 0;
        j = 0;

        stepx = (10'd640 - ancho) / 10'd10; // Cambiar el divisor a 10 para tener 10 columnas
        stepy = (10'd480 - ancho) / 10'd5;
        x0 = stepx / 10'd2 + ancho / 10'd2; // Cambiar el divisor a 10 para tener 10 columnas
        y0 = stepy / 5'd2 + ancho / 10'd2;
		  
		  ajuste_x = 30;
		  ajuste_y = 29;
		  win = 1;
		  if (win) begin 
				caso_win();
		  end
		  //else if (lose) begin
				//caso_lose();
		  //end
			else begin
        for (i = 0; i < 10; i = i + 1) begin // Cambiar el límite a 10 para tener 10 columnas
				x0 = stepx / 10'd2 + ancho / 10'd2;
            for (j = 0; j < 10; j = j + 1) begin // Iterar sobre las 5 filas
				
					 x0 = x0 + (j == 5 ? 5 : 0);
					 
                if (((x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + stepy / 2 + ancho / 2 > y0 && y + stepy / 2 < y0 + ancho / 2) 
                     || (x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + ancho / 2 > y0 + stepy / 2 && y < y0 + stepy / 2 + ancho / 2) 
                     || (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x + stepx / 2 + ancho / 2 > x0 && x + stepx / 2 < x0 + ancho / 2) 
                     || (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x > x0 - ancho / 2 + stepx / 2 && x < x0 + stepx / 2 + ancho / 2)) && (j < 5)) begin
				
                        color_blanco = 1;

                end else if (((x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + stepy / 2 + ancho / 2 > y0 && y + stepy / 2 < y0 + ancho / 2) 
                     || (x + stepx / 2 + ancho / 2 > x0 && x < x0 + stepx / 2 + ancho / 2 && y + ancho / 2 > y0 + stepy / 2 && y < y0 + stepy / 2 + ancho / 2) 
                     || (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x + stepx / 2 + ancho / 2 > x0 && x + stepx / 2 < x0 + ancho / 2) 
                     || (y + stepy / 2 + ancho / 2 > y0 && y < y0 + stepy / 2 + ancho / 2 && x > x0 - ancho / 2 + stepx / 2 && x < x0 + stepx / 2 + ancho / 2)) && (j >= 5)) begin
				
                       color_azul = 1;
				 
										 
					 end 
                x0 = x0 + stepx;
            end
            y0 = y0 + stepy;
        end
		  
		  for (i = 0;i < 5;i = i + 1)begin
				x0 = stepx / 10'd2 + ancho / 10'd2;
				for(j=0;j < 5;j= j + 1)begin 
					if (matrix_player[i][j] == 2'd1) begin
                    caso_destruido_player();
                end 
					 else if (matrix_player[i][j] == 2'd2) begin
						caso_fallo_player();
					 end else if (matrix_player[i][j] == 2'd3) begin
						caso_barco();
					 end
					 if (matrix_pc[i][j] == 3'b001 || matrix_pc[i][j] == 3'd011) begin 
						caso_seleccionado();
					 end else if (matrix_pc[i][j] == 3'b101) begin 
						caso_destruido_pc();
					 end else if (matrix_pc[i][j] == 3'b100) begin 
						caso_fallo_pc();
					 end else begin
						red = 8'b00000000;
						green = 8'b00000000;
						blue = 8'b00000000;
					 end
					 x0 = x0 + stepx; 
				end
				y0 = y0 + stepy;
		  end
		  end
		  

        if (color_blanco) begin
            red = 8'b11111111;
            green = 8'b11111111;
            blue = 8'b11111111; 
        end else if (color_azul)begin 
				red = 8'b00000000;
            green = 8'b00000000;
            blue = 8'b11111111;
		  end else if (color_rojo)begin 
				red = 8'b11111111;
            green = 8'b00000000;
            blue = 8'b00000000;
		  end else if (color_verde)begin 
				red = 8'b00000000;
            green = 8'b11111111;
            blue = 8'b00000000;
		  end else if (color_celeste)begin
				red = 8'b01100110;
				green = 8'b10010100;
				blue = 8'b11011000;
		  end else begin
            red = 8'b00000000;
            green = 8'b00000000;
            blue = 8'b00000000;
        end 
		  
    end
	 
	 function void caso_turno_player();
		// Se dibuja una P
		if (  ((x == 200 || x == 230)  && (y > 210)  && (y < 240)) 
			|| ((x == 200)  && (y > 240)  && (y < 270))
			|| ((x > 200 && x < 230)    && (y == 210 || y == 240)) ) begin
					
				red =   8'b11111111;
				green = 8'b11111111;
				blue =  8'b11111111;
		end 
		
		// Se dibuja una L
		 if ((x == 250) && (y > 210) && (y < 270)) begin

			  red =   8'b11111111;
			  green = 8'b11111111;
			  blue =  8'b11111111;

		 end 
		 
		// Se dibuja una A
		 if (((x == 270 || x == 300) && (y > 210) && (y < 270)) ||
			  ((x == 270 || x == 295) && (y > 240) && (y < 270)) ||
			  ((x > 270 && x < 300) && (y == 210 || y == 240))) begin

			  red =   8'b11111111;
			  green = 8'b11111111;
			  blue =  8'b11111111;
		
		end
		//Se dibuja una Y
		if ((x == 325) && (y > 230) && (y < 270)
		
		|| ((x > 306 && x < 309) && (y == 212))
		|| ((x > 308 && x < 311) && (y == 214))	
		|| ((x > 310 && x < 313) && (y == 216))	
		|| ((x > 312 && x < 315) && (y == 218))
		|| ((x > 314 && x < 317) && (y == 220))
		|| ((x > 316 && x < 319) && (y == 222))
		|| ((x > 318 && x < 321) && (y == 224))	
		|| ((x > 320 && x < 323) && (y == 226))	
		|| ((x > 322 && x < 325) && (y == 228))
		|| ((x > 324 && x < 327) && (y == 230))
		
		|| ((x > 342 && x < 345) && (y == 212))
		|| ((x > 340 && x < 343) && (y == 214))	
		|| ((x > 338 && x < 341) && (y == 216))	
		|| ((x > 336 && x < 339) && (y == 218))
		|| ((x > 334 && x < 337) && (y == 220))
		|| ((x > 332 && x < 335) && (y == 222))
		|| ((x > 330 && x < 333) && (y == 224))	
		|| ((x > 328 && x < 331) && (y == 226))	
		|| ((x > 326 && x < 329) && (y == 228))
		|| ((x > 324 && x < 327) && (y == 230))
		
		) begin 
			red =   8'b11111111;
			green = 8'b11111111;
		   blue =  8'b11111111;
		
		end
		
		//Se dibuja una E
		if (((x == 350)  && (y > 210)  && (y < 270)) 
					|| ((x > 350 && x < 380) && (y == 210 || y == 240 || y == 270 ))) begin
							
				red =   8'b11111111;
				green = 8'b11111111;
				blue =  8'b11111111;
		end 
		
		//Se dibuja una R
		if ( ((x == 395 || x == 425) && (y > 210)  && (y < 240)) 
					|| ((x == 395 || x == 420) && (y > 240)  && (y < 270))
					|| ((x > 395 && x < 425)   && (y == 210 || y == 240))) begin 
		
				red =   8'b11111111;
				green = 8'b11111111;
				blue =  8'b11111111;
		end

		 
		
		else begin
			color_blanco = 1;
		end
	 endfunction
	 
	 
	 function void caso_destruido_player();
		 if (x >= x0 - ajuste_x && x < x0 - ajuste_x + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
					
				color_rojo = 1;
		end 
	 endfunction
	 
	 function void caso_fallo_player();
		if (x >= x0 - ajuste_x && x < x0 - ajuste_x + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
					
				color_verde = 1;
		end 
	 endfunction
	 
	 function void caso_seleccionado();
		if (x >= x0 - ajuste_x + 320 && x < x0 - ajuste_x + 317 + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
					
				color_celeste = 1;
		end 
	endfunction
		
	function void caso_destruido_pc();
		if (x >= x0 - ajuste_x + 320 && x < x0 - ajuste_x + 317 + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
					
				color_rojo = 1;
		end 
	endfunction
	
		
	function void caso_fallo_pc();
		if (x >= x0 - ajuste_x + 320 && x < x0 - ajuste_x + 320 + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
					
				color_verde = 1;
		end
		
		
	 endfunction
	 
	 function void caso_barco();
		if (x >= x0 - ajuste_x && x < x0 - ajuste_x + stepx && y >= y0 + ajuste_y && y < y0 + ajuste_y + stepy) begin
					
				color_azul = 1;
		end 
	 
	 endfunction
	 
	 function void caso_win();
	 
		if (((x == 450 || x == 465 || x == 480) && (y > 210) && (y < 270))
        || ((x == 455 || x == 470) && (y > 240) && (y < 270))
        || ((x == 460) && (y > 210) && (y < 240))
        || ((x == 475) && (y > 240) && (y < 270))
        || ((x > 450 && x < 455) && (y == 210 || y == 240 || y == 270))
        || ((x > 460 && x < 465) && (y == 210 || y == 240 || y == 270))
        || ((x > 465 && x < 470) && (y == 210 || y == 240 || y == 270))
        || ((x > 470 && x < 475) && (y == 210 || y == 240 || y == 270))
        || ((x > 475 && x < 480) && (y == 210 || y == 240 || y == 270))) begin
		
			color_blanco = 1;
		end
	 
//		// Se dibuja una L
//		 if ((x == 350) && (y > 210) && (y < 270)) begin
//
//			  color_blanco = 1;
//
//		 end 
//		 
//		 if (((x == 370 || x == 400)  && (y > 210) && (y < 270)) 
//					
//					|| ((x > 370 && x < 372) && (y == 212))
//					|| ((x > 371 && x < 374) && (y == 214))
//					|| ((x > 373 && x < 376) && (y == 216))
//					|| ((x > 375 && x < 378) && (y == 218))
//					|| ((x > 377 && x < 380) && (y == 220))
//					|| ((x > 379 && x < 382) && (y == 222))
//					|| ((x > 381 && x < 384) && (y == 224))
//					|| ((x > 383 && x < 386) && (y == 226))
//					|| ((x > 385 && x < 388) && (y == 228))
//					|| ((x > 387 && x < 390) && (y == 230))
//					|| ((x > 389 && x < 392) && (y == 232))
//					|| ((x > 391 && x < 394) && (y == 234)) 
//					|| ((x > 393 && x < 396) && (y == 236))
//					|| ((x > 395 && x < 398) && (y == 238))
//					|| ((x > 397 && x < 400) && (y == 240))) begin
//					
//				color_blanco = 1;
//		end 
		else begin 
			red = 8'd00000000;
			green = 8'd00000000;
			blue = 8'd00000000;
		end
	 endfunction
	 
	 
endmodule


