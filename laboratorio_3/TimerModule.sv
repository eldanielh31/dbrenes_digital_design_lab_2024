module TimerModule (
    input logic clk, // Reloj
    input logic rst, // Señal de reset
    input logic start, // Señal de inicio (input)
    output logic done // Señal de finalización
);
    // Contador interno
    logic [3:0] count = 4'b0000;
    logic [3:0] duration = 15; // Duración en segundos (ajusta según tus necesidades)

    // Lógica de conteo
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 4'b0000; // Reiniciar el contador en caso de reset
        end else if (start) begin
            // Incrementar el contador si la señal de inicio está activa
            count <= count + 1;
        end
    end

    // Generar señal de finalización después de 15 segundos
    assign done = (count >= duration * 1000 / 2); // Convertir segundos a milisegundos

endmodule
