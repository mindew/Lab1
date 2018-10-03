`include "bitslice.v"

`define AND3 and #30
`define NOT not #10

module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);

  wire carryout1, notCommand1, notCommand2, subtract;

  // get the value of subtract
  `NOT notGate(notCommand1, command[1]);
  `NOT notGate2(notCommand2, command[2]);
  `AND3 andGate(subtract, command[0], notCommand1, notCommand2);

  structuralBitSlice bitslice1(result[0], carryout1, command, operandA[0], operandB[0], subtract);

  genvar i;
  generate
    for (i=1; i<31; i=i+2)
    begin:genblock
      wire carryout2;
      structuralBitSlice bitslice1(result[i], carryout2, command, operandA[i], operandB[i], carryout1);
      structuralBitSlice bitslice2(result[i+1], carryout1, command, operandA[i+1], operandB[i+1], carryout2);
    end
  endgenerate

endmodule
