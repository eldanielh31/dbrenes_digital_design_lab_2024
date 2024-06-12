module dmem(input logic clk, we,
				input logic [31:0] a, wd,
				output logic [31:0] rd);
	
	logic [31:0] RAM[1023:0];

    // Initialize memory from file
    initial begin
        $readmemh("C:/Users/manue/Escritorio/dbrenes_digital_design_lab_2024/proyecto_final/VGA/dmem.hex", RAM);
    end

    assign rd = RAM[a[31:2]]; // word aligned

	
	always_ff @(posedge clk)
	
		if (we) begin 
			RAM[a[31:2]] <= wd;
		end
		
//		else begin
//			rd = RAM[a[31:2]]; // word aligned
//		end
		
endmodule 