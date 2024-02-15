module mainModule_tb;

  // Definición de parámetros
  parameter N = 6;
  
  // Definición de señales
  logic btn_decrement;
  logic btn_reset;
  logic [6:0] segA;
  logic [6:0] segB;

  // Instancia del módulo a testear
  mainModule dut (
    .btn_decrement(btn_decrement),
    .btn_reset(btn_reset),
    .segA(segA),
    .segB(segB)
  );

  // Simulación de los botones
  initial begin
	 btn_reset = 1'b1;
    btn_decrement = 1'b1; // Inicialmente no se presionan los botones

    // Prueba 1: Incrementar contador
    #10;
    btn_decrement = 1'b0; // Presionar botón de decremento
    #10;
    btn_decrement = 1'b1; // Liberar botón
    #10;
	 
	 // Prueba 1: Incrementar contador
    #10;
    btn_decrement = 1'b0; // Presionar botón de decremento
    #10;
    btn_decrement = 1'b1; // Liberar botón
    #10;
	 
	 // Prueba 1: Incrementar contador
    #10;
    btn_decrement = 1'b0; // Presionar botón de decremento
    #10;
    btn_decrement = 1'b1; // Liberar botón
    #10;
	 
    // Prueba 2: Resetear contador
    btn_reset = 1'b0; // Presionar botón de reset
    #10;
    btn_reset = 1'b1; // Liberar botón
    #10;
	 
	 // Prueba 1: Incrementar contador
    #10;
    btn_decrement = 1'b0; // Presionar botón de decremento
    #10;
    btn_decrement = 1'b1; // Liberar botón
	 

    $finish; // Terminar simulación
  end

endmodule