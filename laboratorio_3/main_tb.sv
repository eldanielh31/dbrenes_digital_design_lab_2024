module main_tb;

    // Parámetros de simulación
    parameter SIM_TIME = 200; // Tiempo de simulación

    // Señales de entrada
    logic clock;
    logic reset;
    logic direction;
    logic move_h;
    logic move_v;
    logic fire;
    logic place_boat;
    logic [2:0] amount_boats;

    // Señales de salida
    logic [6:0] segAmount;
    logic [6:0] segPlayer;
    logic [6:0] segPc;
    logic [7:0] red;
    logic [7:0] green;
    logic [7:0] blue;
    logic vgaclock;
    logic hsync;
    logic vsync;
    logic n_blank;

    // Instancia del módulo bajo prueba
    main dut (
        .clock(clock),
        .reset(reset),
        .direction(direction),
        .move_h(move_h),
        .move_v(move_v),
        .fire(fire),
        .place_boat(place_boat),
        .amount_boats(amount_boats),
        .segAmount(segAmount),
        .segPlayer(segPlayer),
        .segPc(segPc),
        .red(red),
        .green(green),
        .blue(blue),
        .vgaclock(vgaclock),
        .hsync(hsync),
        .vsync(vsync),
        .n_blank(n_blank)
    );

    // Generación del clock
    always #5 clock = ~clock;

    // Proceso de inicialización
    initial begin
        // Inicializar señales
        reset = 1'b1;
        direction = 1'b0;
        move_h = 1'b0;
        move_v = 1'b0;
        fire = 1'b0;
        place_boat = 1'b0;
        amount_boats = 3'b000;

        // Esperar un poco antes de desactivar el reset
        #10;
        reset = 1'b0;

        // Estímulo para un tiempo específico
        #20; // Simular movimiento horizontal
        move_h = 1'b1;
        direction = 1'b0; // Dirección izquierda
        #20; // Simular movimiento vertical
        move_v = 1'b1;
        direction = 1'b1; // Dirección arriba
        #20; // Simular disparo
        fire = 1'b1;
        #20; // Simular asignación de barco
        place_boat = 1'b1;
        amount_boats = 3'b001; // Un barco colocado

        // Finalizar la simulación
        #10;
        
    end

endmodule
