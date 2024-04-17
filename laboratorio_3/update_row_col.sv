module update_row_col(
	input clock,
	input reset,
	input reg [4:0] select_row,
	input reg [4:0] select_col,
	output reg [4:0] current_row, 
	output reg [4:0] current_col
	);


always @(posedge clock) begin
    if (!reset) begin
        current_row <= select_row;
        current_col <= select_col;
    end
end

endmodule 