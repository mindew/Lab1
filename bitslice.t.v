// Adder testbench
`timescale 1 ns / 1 ps
`include "bitslice.v"


module testBitSlice();
    reg [2:0] control;
    reg a;
    reg b;
    reg carryin;
    wire carryout;
    wire sum;

    BitSlice structuralBitSlice(.sum(sum), .carryout(carryout), .invert(invert), .control(control), .a(a), .b(b), .carryin(carryin));

    initial begin

    $dumpfile("bitslice.vcd");
    $dumpvars();


    lab1testbenchbitslice tester( .begintest(begintest), .endtest(endtest), .bitpassed(bitpassed), .sum(sum), .carryout(carryout), .invert(invert), .control(control), .a(a), .b(b), .carryin(carryin));


    initial begin
        begintest=0;
        #10;
        begintest=1;
        #1000;
    end

    always @(endtest) begin
        $display("Bit Sliced passed?: %b", bitpassed);
    end

    $finish();

    end

endmodule



module lab1testbenchbitslice
(
// Test bench driver signal connections
input           begintest,  // Triggers start of testing
output reg      endtest,    // Raise once test completes
output reg      bitpassed,  // Signal test result

output sum,
output carryout,
input[2:0]  control,
input a,
input b,
input carryin


);

  // Initialize register driver signals
  initial begin // all the inpupts
    control=3'b0;
    a=0;
    b=0;
    carryin=0;
  end

  // Once 'begintest' is asserted, start running test cases
  always @(begintest) begin // always @(posedge begintest) begin
    endtest = 0;
    bitpassed = 1;
    #10

  // Test Case 1: 
    control=3'b1
    a=0;
    b=0;
    carryin=0; // ADD

  if(( sum !== 0) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    bitpassed = 0;
    $display("Test Case 1 Failed 0+0");
  end

  // Test Case 2: 
    control=3'b1
    a=1;
    b=0;
    carryin=0; // ADD

  if(( sum !== 1) || (carryout !== 0) || (overflow !==0) || (zero !== 0)) begin
    bitpassed = 0;
    $display("Test Case 2 Failed 1+0");
  end

  #5
  endtest = 1;

end

endmodule