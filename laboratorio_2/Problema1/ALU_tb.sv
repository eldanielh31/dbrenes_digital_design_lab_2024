module ALU_tb;

  reg [3:0] A;
  reg [3:0] B;
  reg [1:0] op;
  wire [3:0] C;
  wire [1:0] flag;

  ALU uut (
    .A(A),
    .B(B),
    .op(op),
    .C(C),
    .flag(flag)
  );

  initial begin
    // Caso de prueba para suma con carry-out
    A = 4'b1111;
    B = 4'b0001;
    op = 2'b00;
    #30; // Espera un poco
	 A = 4'b1110;
    B = 4'b0001;
    op = 2'b00;
  end

endmodule
