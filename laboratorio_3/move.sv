module move(
    input clock,
	 input reset,
    input wire move_h,
    input wire move_v,
    input wire direction,
	 input reg [4:0] current_row,
	 input reg [4:0] current_col,
    output reg [4:0] select_row,
    output reg [4:0] select_col
);

always @(posedge clock or posedge reset) begin
	 if (reset) begin
		select_col <= 5'd0;
		select_row <= 5'd0;
	 end
	 else begin
		 if (!move_h && direction && current_col < 4) begin
			  // Incrementar select_col cuando move_h es 0 y direction es 1
			  select_col <= current_col + 1;
			  select_row <= current_row;
		 end
		 else if (!move_h && !direction && current_col > 0) begin
			  // Incrementar select_col cuando move_h es 0 y direction es 1
			  select_col <= current_col - 1;
			  select_row <= current_row;
		 end
		 else if (!move_v && direction && current_row > 0) begin
			  // Incrementar select_row cuando move_v es 0 y direction es 0
			  select_row <= current_row - 1;
			  select_col <= current_col;
		 end
		 else if (!move_v && !direction && current_row < 4) begin
			  // Incrementar select_row cuando move_v es 0 y direction es 0
			  select_row <= current_row + 1;
			  select_col <= current_col;
		 end
		 else if (move_h && move_v)begin
			select_row <= current_row;
			select_col <= current_col;
		 end
	 end
end

endmodule