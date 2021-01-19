//Assignment 5
//Problem 1
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module ALU_4bit_TB();
  
  reg [3:0] A,B,S;
  reg Min,Cin;
  wire [3:0] F;
  wire Cout;
  
  ALU_4bit func(F,Cout,A,B,Min,S,Cin);
    
  initial
  begin
    $monitor("A = %b, B = %b, S = %b, M = %b, Cout = %d, F = %b",A,B,S,Min,Cout,F);
    
    A = 4'b0101;
    B = 4'b1001;
    Min = 0;
    Cin = 1;
    S = 4'b0000;
    
    #640 $finish;
  end
    
  always #20 Min = ~Min;
  always #40 S = S + 1;
  
endmodule

