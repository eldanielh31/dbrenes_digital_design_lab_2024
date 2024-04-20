module SieteSeg #(parameter N=3)(
	input reg [N-1:0] amount_boats, // Registro de la cantidad de barcos
	input reg [N-1:0] boats_player, // Registro de los barcos restantes del jugador
	input reg [N-1:0] boats_pc, // Registro de los barcos restantes de la computadora
	output reg [0:6] segAmount, // Salida del siete segmentos de la cantidad de barcos
	output reg [0:6] segPlayer, // Salidad del siete segmentos que muestra los barcos restantes del jugador
	output reg [0:6] segPc // Salidad del siete segmentos que muestra los barcos restantes de la computadora
	); 
	  
	  always @(*) begin
			
		 //Caso de la cantidad de barcos
		 case (amount_boats)
			3'b000: segAmount = 7'b1000000;
			3'b001: segAmount = 7'b1111001;
			3'b010: segAmount = 7'b0100100;
			3'b011: segAmount = 7'b0110000;
			3'b100: segAmount = 7'b0011001;
			3'b101: segAmount = 7'b0010010;
			default: segAmount = 7'b1000000;
		 endcase
		 
		 //Caso de la cantidad de barcos restantes del jugador
		 case (boats_player)
			3'b000: segPlayer = 7'b1000000;
			3'b001: segPlayer = 7'b1111001;
			3'b010: segPlayer = 7'b0100100;
			3'b011: segPlayer = 7'b0110000;
			3'b100: segPlayer = 7'b0011001;
			3'b101: segPlayer = 7'b0010010;
			default: segPlayer = 7'b1000000;
		 endcase
		 
		 //Caso de la cantidad de barcos restantes de la computadora
		 case (boats_pc)
			3'b000: segPc = 7'b1000000;
			3'b001: segPc = 7'b1111001;
			3'b010: segPc = 7'b0100100;
			3'b011: segPc = 7'b0110000;
			3'b100: segPc = 7'b0011001;
			3'b101: segPc = 7'b0010010;
			default: segPc = 7'b1000000;
		 endcase
	end

  
endmodule