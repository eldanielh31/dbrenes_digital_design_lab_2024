module update_boat_row_col(
	input clock,
	input reset,
	input reg [4:0] boat_row,
	input reg [4:0] boat_col,
	output reg [4:0] current_boat_row, 
	output reg [4:0] current_boat_col
	);


always @(posedge clock) begin
    if (!reset) begin
        current_boat_row <= boat_row;
        current_boat_col <= boat_col;
    end
end

endmodule 