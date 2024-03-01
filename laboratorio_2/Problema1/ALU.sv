module ALU (
  input logic [3:0] A,
  input logic [3:0] B,
  input logic [1:0] op,
  output logic [3:0] C,
  output reg flagN,
  output reg flagC,
  output reg flagZ,
  output reg flagV
);

  wire [3:0] sum_result; // Salida del sumador
  wire logic Cout;

  adder_4_bits uut_adder (
    .A(A),
    .B(B),
    .Sum(sum_result),
    .Cout(Cout)
  );

always_comb begin
  case (op)
    2'b00: C = sum_result; // Suma
    2'b01: C = A - B; // resta
    2'b10: C = A * B; // multiplicación
    default: C = 5'b00000;
  endcase
end


endmodule
