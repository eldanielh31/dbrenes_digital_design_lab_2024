module controls(input logic direction, input logic move_h, input logic move_v, output x, output y);

always_comb begin 

	if (direction == 1'd0 && move_h == 1) begin 
		x = x - 1;
	end
	else if (direction == 1'd1 && move_h == 1) begin 
		x = x + 1;
	end
	else if (direction == 1'd0 && move_v == 1) begin 
		y = y - 1;
	end
	else if (direction == 1'd1 && move_v == 1) begin 
		y = y + 1;
	end
	
end

endmodule 