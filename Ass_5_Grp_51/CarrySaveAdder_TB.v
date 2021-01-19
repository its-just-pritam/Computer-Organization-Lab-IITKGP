//Assignment 5
//Problem 4
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module Tree_TB();
  
  reg [15:0] A,B,C,D,E,F,G,H,I;
  wire [15:0] S;
  wire Cout;
  
  Tree func(S,Cout,A,B,C,D,E,F,G,H,I);
    
  initial
  begin
    $monitor("A=%d, B=%d, C=%d, D=%d, E=%d, F=%d, G=%d, H=%d, I=%d, S=%d",A,B,C,D,E,F,G,H,I,S);
    
  	A = 2;
    B = 3;
    C = 5;
    D = 9;
    E = 13;
    F = 18;
    G = 21;
    H = 32;
    I = 15;        
             
    #100 $finish;
  end
  
endmodule

