module ALU (
  input [3:0] A,
  input [3:0] B,
  input [1:0] op,
  output [3:0] C,
  output [1:0] flag
);

  always @* begin
    case (op)
      2'b00: C = A + B; // suma
      2'b01: C = A - B; // resta
      2'b10: C = A * B; // multiplicación
      default: C = 5'b00000;
    endcase
  end

endmodule
