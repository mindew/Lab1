// Bitslice testbench
`timescale 1 ns / 1 ps
`include "bitslice.v"

// For other tests such as XOR, AND, OR, NAND, NOR
// do we need to include other modules? we don't use sum and carry in

// module manualTestBitSlice();

//   reg [3:0] control;
//   reg a, b, carryin;
//   wire [3:0] sum;
//   wire carryout;

//   structuralBitSlice bitslice(.sum(sum), .carryout(carryout), .control(control), .a(a), .b(b), .carryin(carryin));

//   initial begin


//   // Cases 1-4 Extremes
//   a=1;b=0;carryin=0;control[0]=0;control[1]=0;control[2]=1; control[3]=0;#1000
//   $display("%b | carryout | %b | sum ", carryout, sum );
//   $display("%b SUM OUTPUT", control);
//   $display("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTt",);
//   end


// endmodule


module testBitSlice();
    wire [2:0] control;
    wire a;
    wire b;
    wire carryin;
    wire carryout;
    wire sum;
    reg   begintest;
    wire    endtest;
    wire    bitpassed;

    structuralBitSlice bitslice(.sum(sum), .carryout(carryout), .control(control), .a(a), .b(b), .carryin(carryin));

    testbenchBitSlice tester
    (
      .begintest(begintest),
      .endtest(endtest),
      .bitpassed(bitpassed),
      .sum(sum),
      .carryout(carryout),
      .control(control),
      .a(a),
      .b(b),
      .carryin(carryin)
    );

    // Test harness asserts 'begintest' for 1000 time steps, starting at time 10
    initial begin
        begintest=0;
        #10;
        begintest=1;
        #1000;
    end

    always @(endtest) begin
        $display("Bit Sliced passed?: %b", bitpassed);
    end


endmodule



module testbenchBitSlice
(
// Test bench driver signal connections
input           begintest,  // Triggers start of testing
output reg      endtest,    // Raise once test completes
output reg      bitpassed,  // Signal test result

input sum,
input carryout,
output reg [2:0]  control,
output reg a,
output reg b,
output reg carryin

);

  // Initialize register driver signals
  initial begin // all the inputs
    control=3'b000;
    a=0;
    b=0;
    carryin=0;
  end

  // Once 'begintest' is asserted, start running test cases
  initial @(begintest) begin // always @(posedge begintest) begin
    endtest = 0;
    bitpassed = 1;
    #50

 $display("///////////// ADD TESTS /////////////////////////");

  // Test Case 1:
   a=0;b=0;carryin=0;control[0]=0;control[1]=0;control[2]=0; #1000

  if(( sum !== 0) || (carryout !== 0)) begin
    bitpassed = 0;
    $display("Test Case 1 Failed 0+0");
  end

  // Test Case 2:
  a=1;b=0;carryin=0;control[0]=0;control[1]=0;control[2]=0; #1000

  if(( sum !== 1) || (carryout !== 0)) begin
    bitpassed = 0;
    $display("Test Case 2 Failed 1+0");
  end


  // Test Case 3:
  a=0;b=1;carryin=0;control[0]=0;control[1]=0;control[2]=0; #1000

  if(( sum !== 1) || (carryout !== 0)) begin
    bitpassed = 0;
    $display("Test Case 3 Failed 0+1");
  end


  // Test Case 4:
  a=1;b=1;carryin=0;control[0]=0;control[1]=0;control[2]=0; #1000

  if(( sum !== 0) || (carryout !== 1)) begin
    bitpassed = 0;
    $display("Test Case 4 Failed 1+1");
  end


  // Test Case 5:
  a=1;b=0;carryin=1;control[0]=0;control[1]=0;control[2]=0; #1000

  if(( sum !== 0) || (carryout !== 1)) begin
    bitpassed = 0;
    $display("Test Case 5 Failed 1+0 + CI");
  end

  $display("///////////// SUB TESTS /////////////////////////");


  // Test Case 1:
  a=0;b=0;carryin=1;control[0]=1;control[1]=0;control[2]=0; #1000

  if(( sum !== 0) || (carryout !== 1)) begin
    bitpassed = 0;
    $display("Test Case 1 Failed 0-0 %b  %b", sum, carryout);
  end



  // Test Case 2:
  a=1;b=0;carryin=0;control[0]=1;control[1]=0;control[2]=0; #1000

  if(( sum !== 0) || (carryout !== 1)) begin
    bitpassed = 0;
    $display("Test Case 2 Failed 1-0");
  end


  // Test Case 3:
  a=0;b=1;carryin=0;control[0]=1;control[1]=0;control[2]=0; #1000

  if(( sum !== 0) || (carryout !== 0)) begin
    bitpassed = 0;
    $display("Test Case 3 Failed 0-1");
  end


  // Test Case 4:
  a=1;b=1;carryin=1;control[0]=1;control[1]=0;control[2]=0; #1000

  if(( sum !== 0) || (carryout !== 1)) begin
    bitpassed = 0;
    $display("Test Case 4 Failed 1-1");
  end

  ////////////////////////////// XOR TESTS //////////////////////////////////////////////////////

    $display("///////////// XOR TESTS /////////////////////////");

  // Test Case 1:
  a=1;b=1;carryin=0;control[0]=0;control[1]=1;control[2]=0; #1000

  if(( sum !== 0)) begin
    bitpassed = 0;
    $display("Test Case 1 Failed xor 1,1");
  end

  // Test Case 2:
  a=1;b=0;carryin=0;control[0]=0;control[1]=1;control[2]=0; #1000

  if(( sum !== 1)) begin
    bitpassed = 0;
    $display("Test Case 2 Failed xor 1,0");
  end

  #5
  endtest = 1;

end

endmodule
