module update_matrix_pc(input logic hit, input logic fire, input logic [4:0] row, input logic [4:0] col, output [1:0] matrix_pc [0:4][0:4]);
	
	initial begin
		matrix_pc[row][col] = 2'd1;
	end
	
	always_comb begin
		if (hit && fire) begin 
			matrix_pc[row][col] = 2'd2;
		end else if (!hit && fire) begin 
			matrix_pc[row][col] = 2'd3;
		end 
		else begin 
			matrix_pc[row][col] = 2'd1;
		end
	end
endmodule 