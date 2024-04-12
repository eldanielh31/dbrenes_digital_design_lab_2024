`timescale 1ns / 1ns

module main_aux_tb;

    // Parámetros de tiempo
    parameter PERIOD = 10; // Periodo del reloj en unidades de tiempo
    
    // Definir señales
    reg clock;
    reg reset;
    reg direction;
    reg move_h;
    reg move_v;
    reg fire;
    wire [7:0] red;
    wire [7:0] green;
    wire [7:0] blue;
    wire vgaclock;
    wire hsync;
    wire vsync;
    wire n_blank;

    // Instanciar el módulo bajo prueba
    main_aux dut (
        .clock(clock),
        .reset(reset),
        .direction(direction),
        .move_h(move_h),
        .move_v(move_v),
        .fire(fire),
        .red(red),
        .green(green),
        .blue(blue),
        .vgaclock(vgaclock),
        .hsync(hsync),
        .vsync(vsync),
        .n_blank(n_blank)
    );

    // Definir la matriz inicial
    reg [2:0] matrix_pc [0:4][0:4] = '{'{3'b000, 3'b001, 3'b000, 3'b000, 3'b000}, '{3'b000, 3'b000, 3'b000, 3'b000, 3'b000}, '{3'b000, 3'b000, 3'b000, 3'b000, 3'b000}, '{3'b000, 3'b000, 3'b000, 3'b000, 3'b000}, '{3'b000, 3'b000, 3'b000, 3'b000, 3'b000}};

    // Generar señal de reloj
    always #((PERIOD/2)) clock = ~clock;

    // Estimulación
    initial begin
        // Inicializar señales
        reset = 1;
        direction = 0;
        move_h = 0;
        move_v = 0;
        fire = 0;
        
        // Esperar un poco
        #100;

        // Liberar la señal de reset
        reset = 0;
        
        // Esperar un poco más
        #100;

        // Visualizar la matriz antes de entrar al controlador_vga
        $display("Matriz antes de entrar al controlador_vga:");
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                $write("%d ", matrix_pc[i][j]);
            end
            $write("\n");
        end
        $display("----------------------------------");
        
        // Simular eventos
        // Por ejemplo, puedes cambiar las señales como desees aquí
        
        // Ejemplo: Disparar
        fire = 1;
        #20;
        fire = 0;
        #20;

        // Ejemplo: Cambiar dirección y movimiento
        direction = 1;
        move_h = 1;
        move_v = 0;
        #20;
        direction = 0;
        move_h = 0;
        move_v = 1;
        #20;

        // Puedes seguir añadiendo más estímulos según lo necesites

        // Terminar simulación
        #100;
    end

endmodule
