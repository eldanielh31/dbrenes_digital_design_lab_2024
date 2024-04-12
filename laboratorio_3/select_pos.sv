module select_pos(
    input logic direction,
    input logic move_h,
    input logic move_v,
    input reg [2:0] matrix [0:4][0:4],
    output reg [2:0] matrix_pc [0:4][0:4]
);

always_comb begin
    // Inicializar la matriz_pc con los mismos valores que la matriz original
    for (int i = 0; i < 5; i++) begin
        for (int j = 0; j < 5; j++) begin
            matrix_pc[i][j] = matrix[i][j];
        end
    end

    // Mover los elementos "1" una posición a la derecha si direction es 1 y move_h es 1
    if (direction && move_h) begin
        for (int i = 0; i < 5; i++) begin
            for (int j = 0; j < 4; j++) begin
                if (matrix_pc[i][j] == 3'b001 || matrix_pc[i][j] == 3'b011) begin
                    matrix_pc[i][j+1] = matrix_pc[i][j];
                    matrix_pc[i][j] = 3'b000;
                end
            end
        end
    end

    // Mover los elementos "1" una posición hacia arriba si direction es 1 y move_v es 1
    if (direction && move_v) begin
        for (int j = 0; j < 5; j++) begin
            for (int i = 0; i < 4; i++) begin
                if (matrix_pc[i][j] == 3'b001 || matrix_pc[i][j] == 3'b011) begin
                    matrix_pc[i+1][j] = matrix_pc[i][j];
                    matrix_pc[i][j] = 3'b000;
                end
            end
        end
    end

    // Mover los elementos "1" una posición a la izquierda si direction es 0 y move_h es 1
    if (!direction && move_h) begin
        for (int i = 0; i < 5; i++) begin
            for (int j = 4; j > 0; j--) begin
                if (matrix_pc[i][j] == 3'b001 || matrix_pc[i][j] == 3'b011) begin
                    matrix_pc[i][j-1] = matrix_pc[i][j];
                    matrix_pc[i][j] = 3'b000;
                end
            end
        end
    end

    // Mover los elementos "1" una posición hacia abajo si direction es 0 y move_v es 1
    if (!direction && move_v) begin
        for (int j = 0; j < 5; j++) begin
            for (int i = 4; i > 0; i--) begin
                if (matrix_pc[i][j] == 3'b001 || matrix_pc[i][j] == 3'b011) begin
                    matrix_pc[i-1][j] = matrix_pc[i][j];
                    matrix_pc[i][j] = 3'b000;
                end
            end
        end
    end
end

endmodule


