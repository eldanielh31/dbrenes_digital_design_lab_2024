`timescale 1ns/1ps

module arm_tb;

  // Testbench signals
  logic clk;
  logic reset;
  logic [31:0] PC;
  logic [31:0] Instr;
  logic MemWrite;
  logic [31:0] ALUResult;
  logic [31:0] WriteData;
  logic [31:0] ReadData;

  // Decoder signals
  logic [1:0] Op;
  logic [5:0] Funct;
  logic [3:0] Rd;
  logic [1:0] FlagW;
  logic PCS, RegW, MemW;
  logic MemtoReg, ALUSrc;
  logic [1:0] ImmSrc, RegSrc, ALUControl;
  
  assign Op = Instr[24:23];
  assign Funct = Instr[25:20];
  assign Rd = Instr[15:12];

  // Instantiate the arm module
  arm uut (
    .clk(clk),
    .reset(reset),
    .PC(PC),
    .Instr(Instr),
    .MemWrite(MemWrite),
    .ALUResult(ALUResult),
    .WriteData(WriteData),
    .ReadData(ReadData)
  );

  // Instantiate the decoder module
  decoder dec(
    .Op(Op), 
    .Funct(Funct), 
    .Rd(Rd),
    .FlagW(FlagW), 
    .PCS(PCS), 
    .RegW(RegW), 
    .MemW(MemW),
    .MemtoReg(MemtoReg), 
    .ALUSrc(ALUSrc), 
    .ImmSrc(ImmSrc), 
    .RegSrc(RegSrc), 
    .ALUControl(ALUControl)
  );

  // Generate a clock signal
  always begin
    clk = 0; #5;
    clk = 1; #5;
  end

  // Test procedure
  initial begin
    // Initialize signals
    reset = 1;
    Instr = 32'h00000000;
    ReadData = 32'h00000000;

    // Apply reset
    #10;
    reset = 0;
    #10;

    // Apply test instruction
    Instr = 32'hE2802005;
    #10;

    // Wait for some time to observe outputs
    #50;
    $display("PC: %h, Instr: %h, MemWrite: %b, ALUResult: %h, WriteData: %h, ReadData: %h", 
              PC, Instr, MemWrite, ALUResult, WriteData, ReadData);

    // Display decoder outputs
    $display("Decoder Outputs:");
    $display("FlagW: %b, PCS: %b, RegW: %b, MemW: %b, MemtoReg: %b, ALUSrc: %b", 
              FlagW, PCS, RegW, MemW, MemtoReg, ALUSrc);
    $display("ImmSrc: %b, RegSrc: %b, ALUControl: %b", 
              ImmSrc, RegSrc, ALUControl);

    // Finish the simulation
    $stop;
  end

endmodule

