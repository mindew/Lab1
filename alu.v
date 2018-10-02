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
  // pseudo right now, need to use lut or something to get subtract val
	// example of what one will look like (I think)
  structuralBitSlice bitslice1(result[0], carryout1, command, operandA[0], operandB[0], subtract);
  structuralBitSlice bitslice2(result[1], carryout2, command, operandA[1], operandB[1], carryout1);
  ...
endmodule
