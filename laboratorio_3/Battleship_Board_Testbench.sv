module Battleship_Board_Testbench;

    // Parámetros del módulo
    localparam ROW_SIZE = 3;
    localparam COL_SIZE = 3;
    localparam TOTAL_CELLS = ROW_SIZE * COL_SIZE;

    // Señales de entrada
    logic [2:0] row;
    logic [2:0] col;
    logic ship_assign;
    logic shoot;
    logic [2:0] state;
    logic [2:0] amount_boats;
    logic [2:0] current_boats;

    // Señales de salida
    logic [49:0] board;
    logic shootState;
    logic [2:0] countBoats;

    // Instanciar el módulo bajo prueba
    Battleship_Board dut (
        .row(row),
        .col(col),
        .ship_assign(ship_assign),
        .shoot(shoot),
        .state(state),
        .amount_boats(amount_boats),
        .current_boats(current_boats),
        .board(board),
        .shootState(shootState),
        .countBoats(countBoats)
    );

    // Generar estímulos
    initial begin
        // Caso de prueba 1: Asignación de barcos
        row = 3'b001;
        col = 3'b001;
        ship_assign = 1'b1;
        shoot = 1'b0;
        state = 3'b000;
        amount_boats = 3'b101;
        current_boats = 3'b000;
        #10;

        // Caso de prueba 2: Disparo
        row = 3'b010;
        col = 3'b010;
        ship_assign = 1'b0;
        shoot = 1'b1;
        state = 3'b000;
        amount_boats = 3'b101;
        current_boats = 3'b001;
        #10;

        // Añadir más casos de prueba según sea necesario

        // Finalizar simulación
        $finish;
    end

endmodule

