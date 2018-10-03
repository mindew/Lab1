// Adder testbench
`timescale 1 ns / 1 ps
`include "alu.v"


module manualTestALUSlice();

  reg [31:0]   operandA, operandB;
  reg [2:0]    command;
  wire [31:0]  result;
  wire        carryout, zero, overflow;


  ALU alu(.result(result), .carryout(carryout), .overflow(overflow), .operandA(operandA), .operandB(operandB), .command(command));

  initial begin
    operandA=32'd0;
    operandB=32'd0;
    command=3'b100; // TODO: PUT COMMMAND HERE FOR ADDING
    #1000
    $display("%b | result| ", result);
    $display("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTt",);
  end


endmodule


module testALU();
    wire [31:0] operandA;
    wire [31:0] operandB;
    wire [2:0] command;
    wire [31:0] result;
    wire carryout;
    wire zero;
    wire overflow;
    reg   begintest; 
    wire    endtest;     
    wire    alupassed; 

    ALU alu(.result(result), .carryout(carryout), .overflow(overflow), .operandA(operandA), .operandB(operandB), .command(command));

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


    initial begin
        begintest=0;
        #10;
        begintest=1;
        #1000;
    end
    

    always @(endtest) begin
        $display("ALU passed?: %b", alupassed);
    end


endmodule



module lab1testbench
(
// Test bench driver signal connections
input           begintest,  // Triggers start of testing
output reg      endtest,    // Raise once test completes
output reg      alupassed,  // Signal test result

// Register File ALU connections
input[31:0]  result,
input        carryout,
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
    command=3'd0;
  end

  // Once 'begintest' is asserted, start running test cases
  always @(begintest) begin // always @(posedge begintest) begin
    endtest = 0;
    alupassed = 1;
    #10
  

  // Test Case ADD: 
    operandA=32'd0;
    operandB=32'd0;
    command=3'b000; // TODO: PUT COMMMAND HERE FOR ADDING
    #1000

  if(( result !== 32'd0) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin // inputs????
    alupassed = 0;
    $display("Test Case 1 Failed 0+0");
    $display("Reuslt %b",result);
  end


  // Test Case SUB: 
    operandA=32'd300;
    operandB=32'd100;
    command=3'b001; // TODO: PUT COMMMAND HERE FOR ADDING
    #1000

  if(( result !== 32'd200) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin // inputs????
    alupassed = 0;
    $display("Test Case 1 Failed 300-100");
    $display("Reuslt %b",result);
  end


  // Test Case XOR: 
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b010; // TODO: PUT COMMMAND HERE FOR ADDING
    #1000

  if(( result !== 32'b011100011) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin // inputs????
    alupassed = 0;
    $display("Test Case 1 Failed XOR");
    $display("Reuslt %b",result);
  end



  // Test Case SLT: 
    operandA=32'd200;
    operandB=32'd100;
    command=3'b011;
    #1000

  if(( result !== 32'b1) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case 1 Failed SLT");
    $display("Reuslt %b",result);
  end

  // Test Case AND: 
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b100;
    #1000

  if(( result !== 32'b100011100) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case 1 Failed AND");
    $display("Reuslt %b",result);
  end

  // Test Case NAND: 
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b101;
    #1000

  if(( result !== 32'b011100011) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case Failed NAND");
    $display("Reuslt %b",result);
  end


  // Test Case OR: 
    operandA=32'b100011100;
    operandB=32'b111111111;
    command=3'b111;
    #1000

  if(( result !== 32'b111111111) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    alupassed = 0;
    $display("Test Case Failed OR");
    $display("Reuslt %b",result);
  end


  // Test Case NOR: 
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