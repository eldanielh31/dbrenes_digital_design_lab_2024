module main_aux_tb;

    // Parámetros de simulación
    parameter SIM_TIME = 200; // Tiempo de simulación

    // Señales de entrada
    reg clock;
    reg reset;
    reg direction;
    reg move_h;
    reg move_v;
    reg fire;
    reg [2:0] amount_boats;

    // Señales de salida
    wire [6:0] segA;
    wire [7:0] red;
    wire [7:0] green;
    wire [7:0] blue;
    wire vgaclock;
    wire hsync;
    wire vsync;
    wire n_blank;

    // Instancia del módulo bajo prueba
    main_aux main_aux_inst (
        .clock(clock),
        .reset(reset),
        .direction(direction),
        .move_h(move_h),
        .move_v(move_v),
        .fire(fire),
        .amount_boats(amount_boats),
        .segA(segA),
        .red(red),
        .green(green),
        .blue(blue),
        .vgaclock(vgaclock),
        .hsync(hsync),
        .vsync(vsync),
        .n_blank(n_blank)
    );

    // Estímulos
    initial begin
        // Inicializar señales
        clock = 0;
        reset = 1;
        direction = 0;
        move_h = 0;
        move_v = 0;
        fire = 0;
        amount_boats = 3'b000;

        // Esperar un ciclo de reloj
        #5 reset = 0;

        // Generar estímulos
        // Por ejemplo, hacer que se dispare un arma
        #10 fire = 1;

        // Finalizar simulación
        #SIM_TIME $finish;
    end

    // Toggle clock
    always #5 clock = ~clock;

endmodule
