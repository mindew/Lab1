// Adder testbench
`timescale 1 ns / 1 ps
`include "alu.v"


module testALU();
    reg [31:0] operandA;
    reg [31:0] operandB;
    reg [2:0] command;
    wire [31:0] result;
    wire carryout;
    wire zero;
    wire overflow;

    ALU alu(.result(result), .carryout(carryout), .overflow(overflow), .operandA(operandA), .operandB(operandB), .command(command));

    initial begin

    $dumpfile("alu.vcd");
    $dumpvars();


    lab1testbench tester( .begintest(begintest), .endtest(endtest), .alupassed(alupassed), .result(result), .carryout(carryout), .overflow(overflow), .operandA(operandA), .operandB(operandB), .command(command));


    initial begin
        begintest=0;
        #10;
        begintest=1;
        #1000;
    end

    always @(endtest) begin
        $display("ALU passed?: %b", alupassed);
    end

    $finish();

    end

endmodule



module lab1testbench
(
// Test bench driver signal connections
input           begintest,  // Triggers start of testing
output reg      endtest,    // Raise once test completes
output reg      alupassed,  // Signal test result

// Register File ALU connections
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);


// THE INPUT AND OUTPUTS ARE BACKWARDS IN THE TEST


// Left to do
  // Initialize register driver signals
  initial begin // all the inpupts
    operandA=32'd0;
    operandB=32'd0;
    command=3'd0;
  end

  // Once 'begintest' is asserted, start running test cases
  always @(begintest) begin // always @(posedge begintest) begin
    endtest = 0;
    alupassed = 1;
    #10

  // Test Case 1: 
    operandA=32'd04;
    operandB=32'd02;
    command=3'd0; // TODO: PUT COMMMAND HERE FOR ADDING

  if(( result !== 6) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin // inputs????
    alupassed = 0;
    $display("Test Case 1 Failed 4+2");
  end

  // Test Case 2: 
    operandA=32'b0101;
    operandB=32'b0011;
    command=3'd0; // TODO: PUT COMMMAND HERE FOR SLT

  if(( result !== 001) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin // WHAT FORMAT SHOULD THESE BE IN??
    dutpassed = 0;
    $display("Test Case 2 Failed");
  end

  #5
  endtest = 1;

end

endmodule