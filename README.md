# Lab1
CompArch Lab 1: Arithmetic Logic Unit

For this lab, we built an Arithmetic Logic Unit (ALU). We did this by building a bitslice module which is able to perform the specified operations including ADD, SUB, XOR, SLT, AND, NAND, NOR, and OR and then instantiating 32 of these. 
To test our bit slice, simply run 

```javascript
iverilog -o bitslice bitslice.t.v
./bitslice
```
This will run various tests on the bitslice. In order to use the bitslice, make an instance of the module with the following inputs:
```javascript
    BitSlice bitslice
    (
      .sum(sum),
      .carryout(carryout),
      .control(control),
      .a(a),
      .b(b),
      .carryin(carryin)
    );

```
Similarly, to run a test on our ALU, run

```javascript
iverilog -o alu alu.t.v
./bitslice
```

This will run various tests on the ALU. In order to use the ALU, make an instance of the module with the following inputs and accroding to the following command table:

```javascript
    ALU alu(
      .result(result),
      .carryout(carryout),
      .zero(zero),
      .overflow(overflow),
      .operandA(operandA),
      .operandB(operandB),
      .command(command)
      );
```



| Operation	| Result 		| Sets flags?	| ALU Control 	|
|-----------|---------------|---------------|---------------|
| ADD		| `R=A+B`		| Yes			| `b000`		|
| SUB		| `R=A-B`		| Yes			| `b001`		|
| XOR		| `R=A^B`		| No			| `b010`		|
| SLT		| `R=(A<B)?1:0`	| No			| `b011`		|
| AND		| `R=A&B`		| No			| `b100`		|
| NAND		| `R=~(A&B)`	| No			| `b101`		|
| NOR		| `R=~(A\|B)`	| No			| `b110`		|
| OR		| `R=A\|B`		| No			| `b111`		|

