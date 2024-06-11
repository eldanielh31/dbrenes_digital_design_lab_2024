module tb_dmem;

    // Entradas
    reg clk;
    reg we;
    reg [31:0] a;
    reg [31:0] wd;

    // Salidas
    wire [31:0] rd;

    // Instanciación del módulo de memoria
    dmem uut (
        .clk(clk),
        .we(we),
        .a(a),
        .wd(wd),
        .rd(rd)
    );

    // Generador de reloj
    always #5 clk = ~clk; // Periodo de 10 unidades de tiempo (100 MHz)

    initial begin
        // Inicialización de señales
        clk = 0;
        we = 0;
        a = 0;
        wd = 0;

        // Esperar hasta que la memoria se inicialice
        #10;

        // Leer todas las direcciones una por una
        $display("Lectura de direcciones inicializadas:");
        for (int i = 0; i < 1024; i = i + 1) begin
            a = i * 4; // Direcciones alineadas a palabras (32 bits)
            #10; // Esperar un ciclo de reloj
            $display("Direccion: %0d, Dato: %h", a, rd);
        end

        // Escribir y luego leer algunas direcciones para verificar la escritura
        $display("Escritura y verificación:");
        for (int i = 0; i < 10; i = i + 1) begin
            a = i * 4; // Direcciones alineadas a palabras (32 bits)
            wd = 32'hDEADBEEF + i; // Datos de prueba
            we = 1;
            #10; // Esperar un ciclo de reloj
            we = 0;
            #10; // Esperar un ciclo de reloj para la lectura
            $display("Direccion: %0d, Dato escrito: %h, Dato leido: %h", a, wd, rd);
        end

        // Fin de la simulación
        $stop;
    end

    initial begin
        $dumpfile("tb_dmem.vcd");
        $dumpvars(0, tb_dmem);
    end

endmodule
