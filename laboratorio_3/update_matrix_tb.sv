module update_matrix_tb;

    // Parámetros
    parameter TIME_PERIOD = 40;

    // Señales de entrada
    logic hit;
    logic fire;
    logic [4:0] row;
    logic [4:0] col;

    // Señales de salida
    reg [1:0] matrix_pc [0:4][0:4];

    // Instancia del módulo bajo prueba
    update_matrix_pc dut (
        .hit(hit),
        .fire(fire),
        .row(row),
        .col(col),
        .matrix_pc(matrix_pc)
    );

    // Inicialización
    initial begin
	 
		  matrix_pc = '{'{0, 0, 0, 0, 0}, '{0, 0, 1, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}};
        // Valores iniciales de las señales de entrada
        hit = 1'b0;
        fire = 1'b0;
        row = 5'b0;
        col = 5'b0;

        // Test Case 1: Disparo exitoso
        hit = 1'b1;
        fire = 1'b1;
        row = 5'b10; // Por ejemplo
        col = 5'b01; // Por ejemplo
        #TIME_PERIOD ;
        // Verificar resultado

        // Test Case 2: Disparo fallido
        hit = 1'b0;
        fire = 1'b1;
        row = 5'b00; // Por ejemplo
        col = 5'b11; // Por ejemplo
        #TIME_PERIOD ;
        // Verificar resultado

        // Test Case 3: Disparo sin activación
        hit = 1'b0;
        fire = 1'b0;
        row = 5'b00; // Por ejemplo
        col = 5'b00; // Por ejemplo
        #TIME_PERIOD ;
        // Verificar resultado

        // Test Case 4: Otro caso de prueba (opcional)
        // ...

  
    end

endmodule
