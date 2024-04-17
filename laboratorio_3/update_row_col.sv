module update_row_col(
	input reg [4:0] select_row, 
	input reg [4:0] select_col, 
	input reg [4:0] temp_col,
	input reg [4:0] temp_row,
	input logic moved,
	input clock, 
	output reg [4:0] current_row, 
	output reg [4:0] current_col);


always @(posedge clock) begin 
	if (moved) begin
		current_row <= select_row;
		current_col <= select_col;
	end else begin
		current_row <= temp_row;
		current_col <= temp_col;
	end
end

endmodule 