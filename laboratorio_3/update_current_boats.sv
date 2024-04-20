module update_current_boats(
	input clock,
	input reset, 
	input logic [2:0]countBoat,
	output logic [2:0] current_boats
);

	always @(posedge clock) begin
    if (!reset) begin
        current_boats <= countBoat;
    end
end

endmodule 