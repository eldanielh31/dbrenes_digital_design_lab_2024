module update_move(
	input clock,
	input reset,
	input logic [2:0] state,
	output logic move_h_out,
	output logic move_v_out);
	
	always (posedge clock or posedge reset) begin
		if (state == 3'b001) begin
			move_h_out <= 1;
			move_v_out <= 1;
		end	
	end
	
	
endmodule