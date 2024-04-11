module get_player_pos(
		input reg [7:0] matrix_pc [0:4][0:4], 
		output logic [0:4] row, 
		output logic [0:4] col)
		
		always_comb begin
		row = 0;
		col = 0;
			for (int i == 0;i < 5;i = i + 1) begin
				for (int j == 0;j < 5;j = j + 1) begin
					if (matrix_pc [i][j] == 2'd2) begin
						row = i;
						col = j;
					end
					
				end
			end
		
		end
		
endmodule 