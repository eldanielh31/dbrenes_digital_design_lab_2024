module ALU_tb;

  reg [3:0] A;
  reg [3:0] B;
  reg [1:0] op;
  wire [3:0] C;
  reg flagV;
  reg flagZ;
  reg flagC;
  reg flagN;

  ALU uut (
    .A(A),
    .B(B),
    .op(op),
    .C(C),
    .flagN(flagN),
	 .flagC(flagC),
	 .flagV(flagV),
	 .flagZ(flagZ)
  );

  initial begin
    // Caso de prueba para suma con carry-out
    A = 4'b1111;
    B = 4'b0001;
    op = 2'b00;
    #30; // Espera un poco
	 A = 4'b1110;
    B = 4'b0001;
    op = 2'b01;
	 #30; // Espera un poco
	 A = 4'b0010;
    B = 4'b1001;
    op = 2'b01;
	 #30; // Espera un poco
	 A = 4'b0000;
    B = 4'b0000;
    op = 2'b00;
	 #30; // Espera un poco
	 A = 4'b0000;
    B = 4'b0000;
    op = 2'b01;
  end

endmodule
