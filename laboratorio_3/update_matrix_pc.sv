module update_matrix_pc(
    input logic hit,
    input logic fire,
    input logic [4:0] row,
    input logic [4:0] col,
    output reg [2:0] matrix_pc [0:4][0:4]
);

always_comb begin
    // Copiar el valor actual de matrix_pc a una variable temporal
    reg [2:0] temp_matrix_pc [0:4][0:4];
    temp_matrix_pc = matrix_pc;

    // Asignar los valores según las condiciones
    if (hit && fire) begin
        temp_matrix_pc[row][col] = 3'b101;
    end else if (!hit && fire) begin
        temp_matrix_pc[row][col] = 3'b100;
    end else begin
        temp_matrix_pc[row][col] = 3'd000;
    end

    // Asignar la matriz temporal a matrix_pc
    matrix_pc = temp_matrix_pc;
end

endmodule
