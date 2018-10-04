`include "bitslice.v"

`define XOR xor #20
`define AND1 and #10
`define AND3 and #30
`define NOT not #10
`define NOR32 nor #320


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

  wire notCommand1, notCommand2, subtract;
  wire[31:0] carryoutArray;

  // get the value of subtract
  `NOT notGate(notCommand1, command[1]);
  `NOT notGate2(notCommand2, command[2]);
  `AND3 andGate(subtract, command[0], notCommand1, notCommand2);

  structuralBitSlice bitslice1(result[0], carryoutArray[0], command, operandA[0], operandB[0], subtract);

  genvar i;
  generate
    for (i=1; i<32; i=i+1)
    begin:genblock
      structuralBitSlice bitslice1(result[i], carryoutArray[i], command, operandA[i], operandB[i], carryoutArray[i-1]);
    end
  endgenerate

  `XOR xorGate(overflow, carryoutArray[30], carryoutArray[31]);
  `AND1 andGate2(carryout, carryoutArray[31]);
  `NOR32 norGate(zero, result[0], result[1], result[2], result[3], result[4], result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15],result[16],result[17],result[18],result[19],result[20],result[21],result[22],result[23],result[24],result[25],result[26],result[27],result[28],result[29],result[30],result[31]);



endmodule
