//Assignment 5
//Problem 2
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module ALU_16bit_TB();
  
  reg [15:0] A,B;
  reg [3:0] S;
  reg M;
  wire [15:0] F;
  
  ALU_16bit func(F,A,B,M,S);
    
  initial
  begin
    $monitor("A = %b, B = %b, S = %b, M = %b, F = %b",A,B,S,M,F);
    
  	A = 16'b0101001100001001;
    B = 16'b1001010101000110;
    M = 0;
    S = 4'b0000;
    
    #640 $finish;
  end
    
  always #20 M = ~M;
  always #40 S = S + 1;
  
endmodule

