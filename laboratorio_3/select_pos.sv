module select_pos (
    input logic move_h,
    input logic move_v,
	 input logic direction,
	 input reg [2:0] matrix [0:4][0:4],
    inout logic [2:0] matrix_pc [0:4][0:4]
);

always_comb begin
	for(int i = 0; i < 5;i++)begin
		for(int j = 0; j < 5;j++)begin
			matrix_pc[i][j] <= matrix[i][j];
		end
	end
    if (move_h && direction) begin
        // Mover hacia la derecha
        for (int i = 0; i < 5; i++) begin
            for (int j = 3; j >= 0; j--) begin
                if (matrix_pc[i][j] == 1'b1 && j != 4) begin
                    matrix_pc[i][j] <= 1'b0;
                    matrix_pc[i][j+1] <= 1'b1;
                end
            end
        end
    end

    else if (move_v && direction) begin
        // Mover hacia arriba
        for (int i = 1; i < 5; i++) begin
            for (int j = 0; j < 5; j++) begin
                if (matrix_pc[i][j] == 1'b1 && i != 0) begin
                    matrix_pc[i][j] <= 1'b0;
                    matrix_pc[i-1][j] <= 1'b1;
                end
            end
        end
    end
end

endmodule


