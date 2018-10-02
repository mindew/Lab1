// Adder circuit

`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50

module structuralBitSlice
(
    output sum,
    output carryout,
    input control0,
    input control1,
    input control2,
    input a,
    input b,
    input carryin

);

 wire AxorB, AxorBxorC, AxorBC, AB, notControl1, notControl2, subtract, newB;

 'NOT notGate(notControl1, control1);
 'NOT notGate2(notControl2, control2);
 'AND andGate(subtract, control0, notControl1, notControl2);
 'XOR xorGate(newB, subtract, b);
 `XOR xorGate1(AxorB, a, b);
 `XOR xorGate2(sum, AxorB, carryin);
 `AND andGate1(AB, a, b);
 `AND andGate2(AxorBC, carryin, AxorB);
 `OR orGate( carryout, AB, AxorBC);



endmodule
