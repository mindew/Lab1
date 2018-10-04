// ALU testbench
`timescale 1 ns / 1 ps
`include "alu.v"

// potential issues: type mismatch --> backward declaration?
// command A & B are initially declared as decimal.... --> they're being called as binary later
// operations such as SLT should return only one bit

// module manualTestALUSlice();

//   wire[31:0]  result;
//   wire        carryout, zero, overflow;
//   reg[31:0]   operandA, operandB;
//   reg[2:0]    command;


//   // Instantiate ALU register file
//   ALU alu(
//     .result(result),
//     .carryout(carryout),
//     .overflow(overflow),
//     .operandA(operandA),
//     .operandB(operandB),
//     .command(command)
//     );

//   //Test harness asserts 'begintest' for 1000 times steps, starting at time 10
//   initial begin
//     operandA=32'd0;
//     operandB=32'd0;
//     command=3'b0; // TODO: PUT COMMMAND HERE FOR ADDING
//     #1000
//     $display("%b | result | ", result);
//     //$display("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT",);
//   end

// endmodule


module testALU();
    wire [31:0] operandA;     // first bitstream
    wire [31:0] operandB;     // second bitstream
    wire [2:0] command;       // 3 bits control signal
    wire [31:0] result;       // result
    wire carryout;            // carryout bits
    wire zero;
    wire overflow;            // overflow bits
    reg   begintest;
    wire    endtest;
    wire    alupassed;

    // Instantiate ALU register file
    ALU alu(
      .result(result),
      .carryout(carryout),
      .overflow(overflow),
      .operandA(operandA),
      .operandB(operandB),
      .command(command)
      );


    // Instantiate test bench
    lab1testbench tester
    (
        .begintest(begintest),
        .endtest(endtest),
        .alupassed(alupassed),
        .result(result),
        .carryout(carryout),
        .overflow(overflow),
        .operandA(operandA),
        .operandB(operandB),
        .command(command)
    );


    // Test harness asserts 'begintest' for 1000 time stemps, starting at time 10
    initial begin
        begintest=0;
        #10;
        begintest=1;
        #1000;
    end

    // Display test results ('alupassed' signal) once 'endtest' goes high
    always @(endtest) begin
        $display("ALU test passed?: %b", alupassed);
    end


endmodule



module lab1testbench
(
// Test bench driver signal connections
input           begintest,  // Triggers start of testing
output reg      endtest,    // Raise once test completes
output reg      alupassed,  // Signal test result

// Register File ALU connections
input[31:0]  result,    // result
input        carryout,  // carryout bitstream
input        zero,
input        overflow,
output reg[31:0]   operandA,
output reg[31:0]   operandB,
output reg[2:0]    command
);


// THE INPUT AND OUTPUTS ARE BACKWARDS IN THE TEST


// Left to do
  // Initialize register driver signals
  initial begin // all the inpupts
    operandA=32'd0;
    operandB=32'd0;
    command=3'b000;
  end

  // Once 'begintest' is asserted, start running test cases
  always @(begintest) begin // TODO:always @(posedge begintest) begin
    endtest = 0;
    alupassed = 1;
    #10


  // Test Case 1 ADD: 32bits of 0 + 32bits of 0
    operandA=32'd0;
    operandB=32'd0;
    command=3'b000;
    #1000

  if(( result !== 32'd0) || (carryout !== 0) || (overflow !==0) || (zero !== 1)) begin // inputs????
    alupassed = 0;
    $display("Test Case 1 Failed 0+0 co %b of %b z %b", carryout, overflow, zero);
    $display("Result %b",result);
  end


  // Test Case 2 SUB: 32bits of d300 - 32bits of d100
    operandA=32'd300;
    operandB=32'd100;
    command=3'b001; // TODO: PUT COMMMAND HERE FOR ADDING
    #1000

  if(( result !== 32'd200) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin // inputs????
    alupassed = 0;
    $display("Test Case 2 Failed 300-100");
    $display("Result %b",result);
  end


  // Test Case 3 XOR: should return 011100011
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b010; // TODO: PUT COMMMAND HERE FOR ADDING
    #1000

  if(( result !== 32'b011100011) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin // inputs????
    alupassed = 0;
    $display("Test Case 3 Failed XOR");
    $display("Result %b",result);
  end



  // Test Case 4 SLT: should return 1
    operandA=32'd200;
    operandB=32'd100;
    command=3'b011;
    #1000

  if(( result !== 32'b1) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case 4 Failed SLT");
    $display("Result %b",result);
  end

  // Test Case 5 AND: should return 100011100
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b100;
    #1000

  if(( result !== 32'b100011100) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case 5 Failed AND");
    $display("Result %b",result);
  end

  // Test Case 6 NAND: should return 011100011
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b101;
    #1000

  if(( result !== 32'b011100011) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case 6 Failed NAND");
    $display("Result %b",result);
  end


  // Test Case 7 OR: should return 111111111
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b111;
    #1000

  if(( result !== 32'b111111111) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case 7 Failed OR");
    $display("Result %b",result);
  end


  // Test Case 8 NOR: should return 000000000
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b111;
    #1000

  if(( result !== 32'b000000000) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case Failed NOR");
    $display("Reuslt %b",result);
  end


  #5
  endtest = 1;
  end

endmodule
