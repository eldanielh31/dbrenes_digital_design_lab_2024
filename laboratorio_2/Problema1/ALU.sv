module ALU #(parameter N=4)( //Main module

  input logic [N-1:0] A, //Input 1
  input logic [N-1:0] B, //Input 2
  input logic [1:0] op, //Arimetic or logic operation
  
  output logic [N-1:0] C, //Result of the operation it executes
  output reg [6:0] seg, // Var for the seven segments output
  output reg flagN, //Flag for negative numbers
  output reg flagC, //Flag for a carry
  output reg flagZ, //Flag for a 0
  output reg flagV //Flag for a overflow
);

  wire [N-1:0] sum_result; //Output of the adder
  wire Cout; //Carry of the adder

  wire [N-1:0] sub_result; //Output of the subtractor
  wire Bout; //Carry of the subtractor
  
  //Instance of the adder module
  adder_4_bits #(N) uut_adder (
    .A(A),
    .B(B),
    .Sum(sum_result),
    .Cout(Cout), 
    .flagC(flagC)
  );
	
  //Instance of the subtractor module
  substractor_4_bits #(N) uut_sub (
    .A(A),
    .B(B),
    .Difference(sub_result),
    .Bout(Bout),
    .flagN(flagN)
  );

  always_comb begin
    case (op)
      2'b00: C = sum_result; //Result of the adder
      2'b01: C = sub_result; //Result of the subtractor
      2'b10: C = A * B; //Result of the multiplication
		2'b11: C = A & B; //Result for and
      default: C = 4'b0000; //Default value
    endcase
	 
	 //Checks if the result of the operation is 0
    if (C == 0 && flagC != 1) begin
      flagZ = 1;
    end
	 
    else begin
      flagZ = 0;
    end
	 
  end
  
  always @* begin
   case(C)
      4'h0: seg = 7'b1000000; // BCD: 0
      4'h1: seg = 7'b1111001; // BCD: 1
      4'h2: seg = 7'b0100100; // BCD: 2
      4'h3: seg = 7'b0110000; // BCD: 3
      4'h4: seg = 7'b0011001; // BCD: 4
      4'h5: seg = 7'b0010010; // BCD: 5
      4'h6: seg = 7'b0000010; // BCD: 6
      4'h7: seg = 7'b1111000; // BCD: 7
      4'h8: seg = 7'b0000000; // BCD: 8
      4'h9: seg = 7'b0010000; // BCD: 9
      4'hA: seg = 7'b0001000; // BCD: A 
      4'hB: seg = 7'b0000011; // BCD: B 
      4'hC: seg = 7'b1000110; // BCD: C 
      4'hD: seg = 7'b0100001; // BCD: D 
      4'hE: seg = 7'b0000110; // BCD: E 
      4'hF: seg = 7'b0001110; // BCD: F 
      default: seg = 7'b1111111; // Display nothing if BCD is out of range
   endcase
end
  
endmodule


