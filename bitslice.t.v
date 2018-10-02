// Adder testbench
`timescale 1 ns / 1 ps
`include "bitslice.v"


module test4BitFullAdder();
    reg [3:0] addr0, addr1;
    wire [3:0] sum;
    wire carryout, overflow;

    FullAdder4bit adder(.sum(sum), .carryout(carryout), .overflow(overflow), .a(addr0), .b(addr1));

    initial begin

    $dumpfile("4bitadder.vcd");
    $dumpvars();

    $display("A3 A2 A1 A0 B3 B2 B1 B0 | Overflow | Expected Overflow  | Sum3 Sum2 Sum1 Sum0 | Sum Should Be | Carry Out | Expected Carry Out");

    // Cases 1-4 Extremes
    addr0[0]=0;addr0[1]=0;addr0[2]=0;addr0[3]=0;addr1[0]=0;addr1[1]=0;addr1[2]=0;addr1[3]=0; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      0000     |     %b     | 0 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[0]=1;addr0[1]=1;addr0[2]=1;addr0[3]=1;addr1[0]=1;addr1[1]=1;addr1[2]=1;addr1[3]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      1110     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[0]=1;addr0[1]=1;addr0[2]=0;addr0[3]=0;addr1[0]=1;addr1[1]=1;addr1[2]=0;addr1[3]=0; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      0110     |     %b     | 0 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[0]=0;addr0[1]=0;addr0[2]=1;addr0[3]=1;addr1[0]=0;addr1[1]=0;addr1[2]=1;addr1[3]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      1000     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );

    // Cases 5-6: No Carry Out
    addr0[3]=0;addr0[2]=0;addr0[1]=0;addr0[0]=1;addr1[3]=0;addr1[2]=1;addr1[1]=0;addr1[0]=0; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      0101     |     %b     | 0 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=0;addr0[2]=1;addr0[1]=0;addr0[0]=1;addr1[3]=1;addr1[2]=0;addr1[1]=1;addr1[0]=0; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      1111     |     %b     | 0 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    
    // Cases 7-10: With Carry Out
    addr0[3]=0;addr0[2]=1;addr0[1]=0;addr0[0]=1;addr1[3]=0;addr1[2]=1;addr1[1]=0;addr1[0]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 1                  | %b    %b    %b    %b    |      1010     |     %b     | 0 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=1;addr0[2]=1;addr0[1]=0;addr0[0]=1;addr1[3]=0;addr1[2]=0;addr1[1]=1;addr1[0]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      0000     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=1;addr0[2]=0;addr0[1]=1;addr0[0]=0;addr1[3]=1;addr1[2]=1;addr1[1]=0;addr1[0]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 1                  | %b    %b    %b    %b    |      0111     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=1;addr0[2]=0;addr0[1]=1;addr0[0]=0;addr1[3]=1;addr1[2]=1;addr1[1]=0;addr1[0]=0; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 1                  | %b    %b    %b    %b    |      0110     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );

    // Cases 11-16
    addr0[3]=0;addr0[2]=1;addr0[1]=0;addr0[0]=0;addr1[3]=1;addr1[2]=1;addr1[1]=0;addr1[0]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      0001     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=1;addr0[2]=0;addr0[1]=0;addr0[0]=1;addr1[3]=0;addr1[2]=1;addr1[1]=1;addr1[0]=0; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      1111     |     %b     | 0 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=1;addr0[2]=1;addr0[1]=0;addr0[0]=1;addr1[3]=0;addr1[2]=1;addr1[1]=1;addr1[0]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      0100     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=0;addr0[2]=1;addr0[1]=1;addr0[0]=1;addr1[3]=1;addr1[2]=0;addr1[1]=0;addr1[0]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      0000     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=0;addr0[2]=0;addr0[1]=0;addr0[0]=1;addr1[3]=1;addr1[2]=1;addr1[1]=1;addr1[0]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      0000     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    addr0[3]=1;addr0[2]=0;addr0[1]=1;addr0[0]=1;addr1[3]=1;addr1[2]=1;addr1[1]=0;addr1[0]=1; #1000
    $display("%b  %b  %b  %b  %b  %b  %b  %b  | %b        | 0                  | %b    %b    %b    %b    |      1000     |     %b     | 1 ", addr0[3], addr0[2], addr0[1], addr0[0],addr1[3], addr1[2], addr1[1], addr1[0], overflow, sum[3], sum[2], sum[1], sum[0], carryout );
    
    
    
    
    




    $finish();

    end

endmodule