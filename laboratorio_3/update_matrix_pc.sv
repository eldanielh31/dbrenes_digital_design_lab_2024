module update_matrix_pc(input logic hit, input logic fire, input logic [4:0] row, input logic [4:0] col, output [1:0] matrix_pc [0:4][0:4]);
	
	always_comb begin
		
		if (matrix_pc[row][col] == 2'd1 && hit == 1) begin 
			matrix_pc[row][col] = 2'd2;
			for (int i = 0;i < 5;i = i + 1) begin
				for (int j = 0;j < 5;j = j + 1) begin
					if (matrix_pc [i][j] == 2'd0) begin
						matrix_pc [i][j] = 2'd1;
					end
				end
			end 
		end else if (matrix_pc[row][col] == 2'd0 && fire != 0 && hit == 0) begin
			matrix_pc[row][col] = 2'd3;
		end
	end

endmodule 