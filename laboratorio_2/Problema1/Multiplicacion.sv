
///////////////////////////////////////////////////////////
//////////////////////  -- MULTIPLICACION --  ///////////////////////
///////////////////////////////////////////////////////////

module MULTIPLICACION_op #(parameter N=4) (
    input logic [N-1:0] a,
    input logic [N-1:0] b,
    output reg [N-1:0] result,
    output reg flagC,
    output reg flagV,
    output reg flagZ
);

    always_comb begin
        // Initialize variables
        flagC = 0;
        flagV = 0;
        flagZ = 0;
        
        // Custom multiplication algorithm
        result = 0;
        for (int i = 0; i < N; i = i + 1) begin
            if (b[i] == 1'b1) begin
                result = result + (a << i);
            end
        end
        
        // Overflow flag
        flagV = ((a[N-1] & b[N-1] & (~result[N-1])) | ((~a[N-1]) & (~b[N-1]) & result[N-1]));
        
        // Zero flag
        flagZ = (result == 0);
        
        // Negative flag (if needed)
        // flagN = (result[N-1] == 1);
    end
endmodule
