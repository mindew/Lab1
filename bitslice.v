// Adder circuit

`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7


module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	invertB,
output reg	othercontrolsignal,
...
input[2:0]	ALUcommand
)

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invertB=0; othercontrolsignal = ?; end
      `SUB:  begin muxindex = 0; invertB=1; othercontrolsignal = ?; end
      `XOR:  begin muxindex = 1; invertB=0; othercontrolsignal = ?; end
      `SLT:  begin muxindex = 2; invertB=?; othercontrolsignal = ?; end
      `AND:  begin muxindex = 3; invertB=?; othercontrolsignal = ?; end
      `NAND: begin muxindex = 3; invertB=?; othercontrolsignal = ?; end
      `NOR:  begin muxindex = ?; invertB=?; othercontrolsignal = ?; end
      `OR:   begin muxindex = ?; invertB=?; othercontrolsignal = ?; end
    endcase
  end
endmodule

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
