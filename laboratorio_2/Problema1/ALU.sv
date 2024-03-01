module ALU #(parameter N=4)(
  input logic [N-1:0] A,
  input logic [N-1:0] B,
  input logic [1:0] op,
  output logic [N-1:0] C,
  output reg flagN,
  output reg flagC,
  output reg flagZ,
  output reg flagV
);

  wire [N-1:0] sum_result; // Salida del sumador
  wire Cout; // Acarreo del sumador

  wire [N-1:0] sub_result; // Salida del restador
  wire Bout; // Acarreo del restador
  
  
  adder_4_bits #(N) uut_adder (
    .A(A),
    .B(B),
    .Sum(sum_result),
    .Cout(Cout),
    .flagV(flagV), 
    .flagC(flagC)
  );

  substractor_4_bits #(N) uut_sub (
    .A(A),
    .B(B),
    .Difference(sub_result),
    .Bout(Bout),
    .flagV(), 
    .flagC(),
    .flagN(flagN)
  );

  always_comb begin
    case (op)
      2'b00: C = sum_result; // Suma
      2'b01: C = sub_result; // Resta
      2'b10: C = A * B; // Multiplicación
      default: C = 4'b0000; // Valor predeterminado
    endcase

    flagC = Bout;
    if (C == 4'b0000 && flagC != 1) begin
      flagZ = 1;
    end
    else begin
      flagZ = 0;
    end
  end

endmodule


