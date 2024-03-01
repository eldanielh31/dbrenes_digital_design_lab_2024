module adder_4_bits_tb;

  reg [3:0] A;
  reg [3:0] B;
  wire [3:0] Sum;
  wire Cout;
  reg flagV, flagC, flagZ;

  adder_4_bits uut (
    .A(A),
    .B(B),
    .Sum(Sum),
    .Cout(Cout),
	 .flagV(flagV),
	 .flagC(flagC),
  );

  initial begin
    // Asigna valores a las entradas A y B
    A = 4'b0010;
    B = 4'b1101;
    // Espera un poco para que la suma se complete
    #40;
	 A = 4'b1000;
    B = 4'b1101;
    // Espera un poco para que la suma se complete
    #40;
	 A = 4'b0000;
    B = 4'b1111;
    // Espera un poco para que la suma se complete
    #40;
	 A = 4'b1010;
    B = 4'b0001;
    // Espera un poco para que la suma se complete
   
  end

endmodule 