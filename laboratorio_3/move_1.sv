module matrix_update(
    input logic move_h,
    inout reg [2:0] matrix_pc [0:4][0:4]
);

initial begin
	matrix_pc[1][1] = 3'b001;
end

always @* begin
    integer i, j;
    for (i = 0; i < 5; i = i + 1) begin
        for (j = 0; j < 5; j = j + 1) begin
            if (move_h && (j != 0) && (matrix_pc[i][j] == 3'b001 || matrix_pc[i][j] == 3'b011)) begin
                matrix_pc[i][j] = 3'b000;
                matrix_pc[i][j-1] = matrix_pc[i][j];
            end else begin
                matrix_pc[i][j] = matrix_pc[i][j];
            end
        end
    end
end

endmodule