module Battleship_Board_Testbench;

    // Definición de señales
    logic clk = 0;
    logic rst = 0;
    logic [3:0] row = 0;
    logic [3:0] col = 0;
    logic fire = 0;
    logic hit;
    logic [7:0] state;

    // Instanciar el módulo a testear
    Battleship_Board dut (
        .clk(clk),
        .rst(rst),
        .row(row),
        .col(col),
        .fire(fire),
        .hit(hit),
        .state(state)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    // Proceso de test
    initial begin
        // Reset
        rst = 1;
        #10 rst = 0;

        // Disparo a una celda sin barco
        row = 2;
        col = 3;
        fire = 1;
        #10;
        fire = 0;
        $display("Disparo a la celda [%0d, %0d], Estado: %b, Golpe: %b", row, col, state, hit);

        // Disparo a una celda con barco
        row = 0;
        col = 1;
        fire = 1;
        #10;
        fire = 0;
        $display("Disparo a la celda [%0d, %0d], Estado: %b, Golpe: %b", row, col, state, hit);

        // Disparo a una celda previamente disparada
        row = 2;
        col = 3;
        fire = 1;
        #10;
        fire = 0;
        $display("Disparo a la celda [%0d, %0d], Estado: %b, Golpe: %b", row, col, state, hit);

        // Fin de la simulación
        #10;
        $finish;
    end

endmodule
