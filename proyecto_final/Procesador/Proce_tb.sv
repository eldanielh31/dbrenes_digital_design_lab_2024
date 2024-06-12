`timescale 1ns / 1ps

module Proce_tb;
    logic clk;
    logic reset;
    logic [31:0] WriteData;
    logic [31:0] DataAdr;
    logic [31:0] rd;
    logic MemWrite;

    Proce proce_inst (
        .clk(clk), 
        .reset(reset),  
        .WriteData(WriteData), 
        .DataAdr(DataAdr), 
        .rd(rd), 
        .MemWrite(MemWrite)
    );

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        #1000 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $dumpfile("processor.vcd");
        $dumpvars(0, Proce_tb);
    end

    // Block to print WriteData, DataAdr, rd, MemWrite, PC, and Instr
    always_ff @(posedge clk) begin
        if (!reset) begin
            $display("Time: %0t | WriteData: %h | DataAdr: %h | rd: %h | MemWrite: %b", 
                      $time, WriteData, DataAdr, rd, MemWrite);
        end
    end
endmodule
