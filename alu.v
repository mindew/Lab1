`include "bitslice.v"

`define XOR xor #20
`define AND1 and #10
`define AND3 and #30
`define NOT not #10


// *************defined gates from bitslice.v**************
//`define AND and #20
// `define OR or #20
// `define NOT not #10
// `define XOR xor #20
// `define AND3 and #30
// `define OR4 or #40

// `define ADD_ALU  3'd0
// `define SUB_ALU  3'd1
// `define XOR_ALU  3'd2
// `define SLT_ALU  3'd3
// `define AND_ALU  3'd4
// `define NAND_ALU 3'd5
// `define NOR_ALU  3'd6
// `define OR_ALU   3'd7
// *********************************************************


module ALU
(
output[31:0]  result,     // result
output        carryout,   // carryout bitstream
output        zero,       // returns 1 if the answer is all zeros, 0 other cases
output        overflow,   // overflow bitstream
input[31:0]   operandA,   // first input bitstream
input[31:0]   operandB,   // second input bitstream
input[2:0]    command     // 3 bits control signal
);

  wire carryout1, notCommand1, notCommand2, subtract;

  // get the value of subtract
  `NOT notGate(notCommand1, command[1]);
  `NOT notGate2(notCommand2, command[2]);
  `AND3 andGate(subtract, command[0], notCommand1, notCommand2);

  structuralBitSlice bitslice1(result[0], carryout1, command, operandA[0], operandB[0], subtract);

  genvar i;
  generate
    for (i=1; i<31; i=i+1)
    begin:genblock
      wire _carryout2;
      structuralBitSlice bitslice1(result[i], carryout2, command, operandA[i], operandB[i], carryout1);
      structuralBitSlice bitslice2(result[i+1], carryout1, command, operandA[i+1], operandB[i+1], carryout2);
    end
  endgenerate

  `XOR xorGate(overflow, carryout1, carryout2);
  `AND1 andGate2(carryout, carryout1);

endmodule
