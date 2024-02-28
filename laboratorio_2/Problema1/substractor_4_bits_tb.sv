module substractor_4_bits_tb;

  reg [3:0] A;
  reg [3:0] B;
  wire [3:0] Difference;
  wire Bout;

  subtractor_4_bits uut (
    .A(A),
    .B(B),
    .Difference(Difference),
    .Bout(Bout)
  );

  initial begin
    // Caso de prueba 1: A > B
    A = 4'b1101;
    B = 4'b0011;

    #30; // Espera un poco

    // Caso de prueba 2: A < B
    A = 4'b0011;
    B = 4'b1101;
	 

  end

endmodule
