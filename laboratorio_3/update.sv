module update(input logic move_h, input logic move_v, output reg [2:0] matrix [0:4][0:4],
    output reg [2:0] matrix_pc [0:4][0:4]);
	 
	 
	select_pos select_inst(
		.move_h(move_h),
		.move_v(move_v),
		.matrix(matrix),
		.matrix_pc(matrix_pc)
	);
	 
	 always_comb begin 
		for(int i = 0; i < 5; i++)begin
			for(int j = 0; j < 5;j++) begin
				matrix[i][j] = matrix_pc[i][j];
			end
		end
	 end
	 
endmodule 