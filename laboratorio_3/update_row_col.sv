module update_row_col(
	input reg [4:0] select_row, 
	input reg [4:0] select_col, 
	input clock, 
	output reg [4:0] current_row, 
	output reg [4:0] current_col);


always @(posedge clock) begin 
	current_row <= select_row;
	current_col <= select_col;
end

endmodule 