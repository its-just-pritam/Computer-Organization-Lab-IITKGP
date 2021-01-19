//Assignment 5
//Problem 4
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

//Full Adder

module FA(Cout,S,A,B,Cin);
  
  input A,B,Cin;
  output S,Cout;
  
  assign S = A ^ B ^ Cin; 
  assign Cout = (A & B) | (B & Cin) | (Cin & A);
  
endmodule

//Carry Save Adder

module CSA(S,C,X,Y,Z);
  
  input [15:0] X,Y,Z;
  output [15:0] S,C;
  
  FA FullAdder1(C[0],S[0],X[0],Y[0],Z[0]);
  FA FullAdder2(C[1],S[1],X[1],Y[1],Z[1]);
  FA FullAdder3(C[2],S[2],X[2],Y[2],Z[2]);
  FA FullAdder4(C[3],S[3],X[3],Y[3],Z[3]);
  
  FA FullAdder5(C[4],S[4],X[4],Y[4],Z[4]);
  FA FullAdder6(C[5],S[5],X[5],Y[5],Z[5]);
  FA FullAdder7(C[6],S[6],X[6],Y[6],Z[6]);
  FA FullAdder8(C[7],S[7],X[7],Y[7],Z[7]);
  
  FA FullAdder9(C[8],S[8],X[8],Y[8],Z[8]);
  FA FullAdder10(C[9],S[9],X[9],Y[9],Z[9]);
  FA FullAdder11(C[10],S[10],X[10],Y[10],Z[10]);
  FA FullAdder12(C[11],S[11],X[11],Y[11],Z[11]);
  
  FA FullAdder13(C[12],S[12],X[12],Y[12],Z[12]);
  FA FullAdder14(C[13],S[13],X[13],Y[13],Z[13]);
  FA FullAdder15(C[14],S[14],X[14],Y[14],Z[14]);
  FA FullAdder16(C[15],S[15],X[15],Y[15],Z[15]);
  
endmodule

//4-bit Carry Lookahead Adder

module CLA_4bit(a,b,cin,sum,cout);
  
  input [3:0] a,b;
  input cin;
  output [3:0] sum;
  output cout;

  wire [3:0] p,g,c;

  assign p=a^b;
  assign g=a&b;

  assign c[0] = cin;
  assign c[1] = g[0] | (p[0]&c[0]);
  assign c[2] = g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
  assign c[3] = g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
  assign cout = g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&p[0]&c[0];

  assign sum=p^c;
 
endmodule

//16-bit Carry Lookahead Adder

module CLA_16bit(a,b, cin, sum,cout);
  
  input [15:0] a,b;
  input cin;
  output [15:0] sum;
  output cout;
  wire c1,c2,c3;

  CLA_4bit cla1 (.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c1));
  CLA_4bit cla2 (.a(a[7:4]), .b(b[7:4]), .cin(c1), .sum(sum[7:4]), .cout(c2));
  CLA_4bit cla3(.a(a[11:8]), .b(b[11:8]), .cin(c2), .sum(sum[11:8]), .cout(c3));
  CLA_4bit cla4(.a(a[15:12]), .b(b[15:12]), .cin(c3), .sum(sum[15:12]), .cout(cout));
 
endmodule

//Tree generation of Carry Save Adders

module Tree(S,Cout,A,B,C,D,E,F,G,H,I);
  
  input [15:0] A,B,C,D,E,F,G,H,I;
  output [15:0] S;
  output Cout;
  
  wire [15:0] P1,P2,P3,Q1,Q2,Q3,R1,R2,R3,S1,S2,S3,T1,T2,T3,U1,U2,U3,V1,V2,V3;
  wire [16:0] temp1,temp2;
  
  CSA Select1(P1,P2,A,B,C);
  CSA Select2(Q1,Q2,D,E,F);
  CSA Select3(R1,R2,G,H,I);
  
  assign P3 = P2 << 1;
  assign Q3 = Q2 << 1;
  assign R3 = R2 << 1;
  
  CSA Select4(S1,S2,P1,P3,Q1);
  CSA Select5(T1,T2,Q3,R1,R3);
  
  assign T3 = T2 << 1;
  assign S3 = S2 << 1;
  
  CSA Select6(U1,U2,S1,S3,T1);
  
  assign U3 = U2 << 1;
  
  CSA Select7(V1,V2,U1,U3,T3);
  
  assign V3 = V2 << 1;
  
  CLA_16bit Lookahead(V1,V3,0,S,Cout);
  
endmodule