module seven_segment_display (
    input  logic [3:0] digit,     // Número de 4 bits (0-9)
    output logic [6:0] segments  // Salida de segmentos del display (a, b, c, d, e, f, g)
);

    always_comb begin
        case (digit)
            4'd0: segments = 7'b1000000; // 0
            4'd1: segments = 7'b1111001; // 1
            4'd2: segments = 7'b0100100; // 2
            4'd3: segments = 7'b0110000; // 3
            4'd4: segments = 7'b0011001; // 4
            4'd5: segments = 7'b0010010; // 5
            4'd6: segments = 7'b0000010; // 6
            4'd7: segments = 7'b1111000; // 7
            4'd8: segments = 7'b0000000; // 8
            4'd9: segments = 7'b0010000; // 9
				4'd10: segments = 7'b0001000; // A
            4'd11: segments = 7'b0000011; // b
            4'd12: segments = 7'b1000110; // C
            4'd13: segments = 7'b0100001; // d
            4'd14: segments = 7'b0000110; // E
            4'd15: segments = 7'b0001110; // F
            default: segments = 7'b1111111; // Apagado
        endcase
    end

endmodule
