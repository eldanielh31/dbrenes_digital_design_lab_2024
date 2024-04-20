module Battleship_Board_Testbench;

    // Parámetros para definir el tamaño del tablero
    parameter ROWS = 5;
    parameter COLS = 5;

    // Definición de señales de entrada
    logic clk, rst, fire;
    logic [4:0] row, col;

    // Definición de señales de salida
    logic hit;
    logic [2:0] matrix_pc [0:4][0:4];

    // Instanciación del módulo bajo prueba
    Battleship_Board dut (
        .clk(clk),
        .rst(rst),
        .row(row),
        .col(col),
        .fire(fire),
        .hit(hit),
    );

    // Señal de clock
    always #5 clk = ~clk;

    // Estímulo inicial
    initial begin
        clk = 0;
        rst = 1;
        fire = 0;
        row = 0;
        col = 0;
        #40 rst = 0; // Desactivar el reset después de 10 unidades de tiempo
		  matrix_pc = '{'{0, 0, 0, 0, 0}, '{0, 1, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}, '{0, 0, 0, 0, 0}};

        // Primer disparo
        row = 1;
        col = 1;
        fire = 0;
        #40;

        // Segundo disparo
        row = 1;
        col = 3;
        fire = 0;
        #40;
		  
		  row = 2;
		  col = 2;
		  fire = 1;
		  #40;
  
    end

endmodule