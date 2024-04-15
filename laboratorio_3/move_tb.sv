module move_tb;

    // Definición de constantes
    localparam CLK_PERIOD = 10; // Periodo del reloj en unidades de tiempo de simulación
    localparam SIM_TIME = 100; // Tiempo total de simulación
    
    // Declaración de señales
    reg clock = 0; // Señal de reloj
    reg reset = 0; // Señal de reset
    reg move_h = 1; // Señal de movimiento horizontal
    reg move_v = 1; // Señal de movimiento vertical
    reg direction = 0; // Dirección de movimiento
	 reg [4:0] current_row = 1;
	 reg [4:0] current_col = 1;
    reg [4:0] select_row; // Registro de selección de fila
    reg [4:0] select_col; // Registro de selección de columna
    
    // Instanciación del módulo move
    move move_inst (
        .clock(clock),
        .reset(reset),
        .move_h(move_h),
        .move_v(move_v),
        .direction(direction),
		  .current_row(current_row),
		  .current_col(current_col),
        .select_row(select_row),
        .select_col(select_col)
    );
	 
//    update_row_col update_inst (
//		.clock(clock),
//		.current_row(current_row),
//		.current_col(current_col),
//      .select_row(select_row),
//      .select_col(select_col)
//	 );
    // Generación de señales de reloj
    always #((CLK_PERIOD / 2)) clock = !clock;
    
    // Simulación de comportamiento
    initial begin
        // Inicializar valores
        reset = 1;
        #20; // Esperar un tiempo
        reset = 0;
        
        // Simular movimiento horizontal
        move_h = 0;
        direction = 1;
        #10;
		  
		  move_h = 0;
        direction = 1;
        #10;
        
        // Simular movimiento vertical
		  move_h = 1;
        move_v = 0;
        direction = 0;
        #10;
        
        // Terminar la simulación
       
    end

endmodule

