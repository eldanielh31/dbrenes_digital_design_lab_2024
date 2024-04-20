module PseudoRandomModule (
    input logic clk, // Reloj
    input logic rst, // Señal de reset
    output logic [2:0] rand_val1, // Primer valor pseudorandom
    output logic [2:0] rand_val2 // Segundo valor pseudorandom
);
    // Variables internas para el generador pseudorandom
    logic [2:0] seed = 3'b101; // Semilla inicial (puedes cambiarla)
    logic [2:0] next_val;

    // Lógica de generación pseudorandom
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            seed <= 3'b101; // Reiniciar la semilla en caso de reset
        end else begin
            // Algoritmo simple de generación pseudorandom
            next_val = (seed + 1) % 5; // Incrementar y hacer módulo 5
            seed <= next_val;
        end
    end

    // Asignar los valores generados a las salidas
    assign rand_val1 = next_val;
    assign rand_val2 = (next_val + 1) % 5; // Valor siguiente (módulo 5)

endmodule
