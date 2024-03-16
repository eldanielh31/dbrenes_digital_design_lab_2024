module FSM (
    input logic clk, // Clock signal
    input logic rst, // Reset signal
    input logic maintenance,   // Button press signal
    output logic [7:0] error_code,  // Error code signal
    output logic [7:0] maintenance_counter, // Maintenance count signal
    output logic [7:0] cicles_counter // Cycles count signal
);
    logic [1:0] state, next_state;
    reg [7:0] maintenance_count;
    reg [7:0] cicles_count;

    // Actual state logic
    always_ff @(posedge clk or posedge rst) begin
	 
        if (rst) begin
            state <= 2'b00;
				maintenance_count <= 8'b0;
            cicles_count <= 8'b0;
        end
		  
		  else begin
		  
            state <= next_state;
				
				if (state == 2'b01) begin
					maintenance_count <= maintenance_count + 8'b1;
					cicles_count <= 8'b0;
				end
			  
				else if (state == 2'b10) begin
					cicles_count <= cicles_count + 8'b1;
				end
				
				
        end
		  
    end

    // Next state logic
    always_comb begin
        case (state)
            // Init state
            2'b00: if (maintenance) next_state = 2'b01; else next_state = 2'b10;

            // Maintenance state
            2'b01: next_state = 2'b00;

            // 200 cycles state
            2'b10: if (cicles_count >= 200) next_state = 2'b11; else next_state = 2'b00;

            // Error state
            2'b11: next_state = 2'b11;

            default: next_state = 2'b00;
        endcase
    end

    // Output logic
    assign error_code = (state == 2'b11) ? 8'hFF : 8'h00; // Error code 0xFF when waiting
    assign maintenance_counter = maintenance_count;
	 assign cicles_counter = cicles_count;

endmodule
