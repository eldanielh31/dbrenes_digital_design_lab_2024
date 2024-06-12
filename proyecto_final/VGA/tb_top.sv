`timescale 1ns / 1ps

module tb_top;

    // Entradas
    reg clk;
    reg reset;
    reg enable;
    reg [3:0] vocales;

    // Salidas
    wire [6:0] segA;
    wire vgaclk;
    wire hsync;
    wire vsync;
    wire sync_b;
    wire blank_b;
    wire [7:0] r;
    wire [7:0] g;
    wire [7:0] b;

    // Instanciación del módulo a probar
    top uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .vocales(vocales),
        .segA(segA),
        .vgaclk(vgaclk),
        .hsync(hsync),
        .vsync(vsync),
        .sync_b(sync_b),
        .blank_b(blank_b),
        .r(r),
        .g(g),
        .b(b)
    );

    // Generador de reloj
    always #10 clk = ~clk; // Periodo de 20 unidades de tiempo (50 MHz)

    initial begin
        // Inicialización de señales
        clk = 0;
        reset = 1;
        enable = 0;
        vocales = 4'd0;

        // Secuencia de prueba
        #40;
        reset = 0;
        #20;
        enable = 1;
        #20;
        vocales = 4'd1; // Prueba con vocal A
        #100;
        vocales = 4'd2; // Prueba con vocal E
        #100;
        vocales = 4'd3; // Prueba con vocal I
        #100;
        vocales = 4'd4; // Prueba con vocal O
        #100;
        vocales = 4'd5; // Prueba con vocal U
        #100;

        // Fin de la simulación
        $stop;
    end

    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
    end

endmodule
