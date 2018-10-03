// Adder testbench
`timescale 1 ns / 1 ps
`include "bitslice.v"


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
  initial begin // all the inpupts
    control=3'b000;
    a=0;
    b=0;
    carryin=0;
  end

  // Once 'begintest' is asserted, start running test cases
  always @(begintest) begin // always @(posedge begintest) begin
    endtest = 0;
    bitpassed = 1;
    #10

////////////////////////////// ADD TESTS //////////////////////////////////////////////////////

 $display("///////////// ADD TESTS /////////////////////////");


  // Test Case 1: 
    control=3'b000;
    a=0;
    b=0;
    carryin=0; // ADD

  if(( sum !== 0) || (carryout !== 0)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 1 Failed 0+0");
    $display("%b SUM OUTPUT", sum);
  end



  // Test Case 2: 
    control=3'b000;
    a=1;
    b=0;
    carryin=0; // ADD

  if(( sum !== 1) || (carryout !== 0)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 2 Failed 1+0");
    $display("%b SUM OUTPUT", sum);
  end


  // Test Case 3: 
    control=3'b000;
    a=0;
    b=1;
    carryin=0; // ADD

  if(( sum !== 1) || (carryout !== 0)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 3 Failed 0+1");
    $display("%b SUM OUTPUT", sum);
  end


  // Test Case 3: 
    control=3'b000;
    a=1;
    b=1;
    carryin=0; // ADD

  if(( sum !== 0) || (carryout !== 1)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 4 Failed 1+1");
    $display("%b SUM OUTPUT", sum);
  end


  // Test Case 4: 
    control=3'b000;
    a=0;
    b=1;
    carryin=1; // ADD

  if(( sum !== 0) || (carryout !== 1)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 5 Failed 1+0 + CI");
    $display("%b SUM OUTPUT", sum);
  end

////////////////////////////// SUB TESTS //////////////////////////////////////////////////////
    
    $display("///////////// SUB TESTS /////////////////////////");


  // Test Case 1: 
    control=3'b001;
    a=0;
    b=0;
    carryin=0;

  if(( sum !== 0) || (carryout !== 0)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 1 Failed 0-0");
    $display("%b SUM OUTPUT", sum);
  end



  // Test Case 2: 
    control=3'b001;
    a=1;
    b=0;
    carryin=0;

  if(( sum !== 1) || (carryout !== 0)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 2 Failed 1-0");
    $display("%b SUM OUTPUT", sum);
  end


  // Test Case 3: 
    control=3'b001;
    a=0;
    b=1;
    carryin=0; 

  if(( sum !== 0) || (carryout !== 1)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 3 Failed 0-1");
    $display("%b SUM OUTPUT", sum);
  end


  // Test Case 3: 
    control=3'b001;
    a=1;
    b=1;
    carryin=0; // ADD

  if(( sum !== 0) || (carryout !== 0)) begin // need to add (zero !== 0) and overflow?
    bitpassed = 0;
    $display("Test Case 4 Failed 1-1");
    $display("%b SUM OUTPUT", sum);
  end

  ////////////////////////////// XOR TESTS //////////////////////////////////////////////////////
    
    $display("///////////// XOR TESTS /////////////////////////");

    




  #5
  endtest = 1;

end

endmodule