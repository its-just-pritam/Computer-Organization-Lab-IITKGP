//Assignment 5
//Problem 1
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

//4-bit Carry Lookahead Adder

module CLA(cout,sum,a,b,cin);
  
  input[3:0] a,b;
  input cin;
  output [3:0] sum;
  output cout;
  
  wire p0,p1,p2,p3,g0,g1,g2,g3,c0,c1,c2,c3,c4;
  
  assign p0=(a[0]^b[0]),
  p1=(a[1]^b[1]),
  p2=(a[2]^b[2]),
  p3=(a[3]^b[3]);
  
  assign g0=(a[0]&b[0]),
  g1=(a[1]&b[1]),
  g2=(a[2]&b[2]),
  g3=(a[3]&b[3]);
  
  assign c0=cin,
  c1=g0|(p0&cin),
  c2=g1|(p1&g0)|(p1&p0&cin),
  c3=g2|(p2&g1)|(p2&p1&g0)|(p2&p1&p0&cin),
  c4=g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&cin);
  
  assign sum[0]=p0^c0,
  sum[1]=p1^c1,
  sum[2]=p2^c2,
  sum[3]=p3^c3;
  
  assign cout=c4;
  
endmodule

//4-bit Combinational ALU with Carry-in and carry-out

module ALU_4bit(F,Cout,A,B,Min,S,Cin);
  
  input [3:0] A,B,S;
  input Min,Cin;
  output [3:0] F;
  output Cout;
  
  wire [15:0] T;
  wire [3:0] M,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16;
  wire zero;
  wire [3:0] F0,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15;
  wire C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12;
  
  assign zero = 4'b0000;
  
  assign M[0] = Min;
  assign M[1] = Min;
  assign M[2] = Min;
  assign M[3] = Min;
  
  assign T[0] = ~S[3] & ~S[2] & ~S[1] & ~S[0];
  assign T[1] = ~S[3] & ~S[2] & ~S[1] & S[0];
  assign T[2] = ~S[3] & ~S[2] & S[1] & ~S[0];
  assign T[3] = ~S[3] & ~S[2] & S[1] & S[0];
  assign T[4] = ~S[3] & S[2] & ~S[1] & ~S[0];
  assign T[5] = ~S[3] & S[2] & ~S[1] & S[0];
  assign T[6] = ~S[3] & S[2] & S[1] & ~S[0];
  assign T[7] = ~S[3] & S[2] & S[1] & S[0];
  assign T[8] = S[3] & ~S[2] & ~S[1] & ~S[0];
  assign T[9] = S[3] & ~S[2] & ~S[1] & S[0];
  assign T[10] = S[3] & ~S[2] & S[1] & ~S[0];
  assign T[11] = S[3] & ~S[2] & S[1] & S[0];
  assign T[12] = S[3] & S[2] & ~S[1] & ~S[0];
  assign T[13] = S[3] & S[2] & ~S[1] & S[0];
  assign T[14] = S[3] & S[2] & S[1] & ~S[0];
  assign T[15] = S[3] & S[2] & S[1] & S[0];
  
  //Case S = 0000
  
  assign F0 = ((M & ~A) | (~M & A));
  
  //Case S = 0001
  
  assign F1 = ((M & ~A & ~B) | (~M & (A | B)));
  
  //Case S = 0010
  
  assign F2 = ((M & ~A & B) | (~M & (A | ~B)));
  
  //Case S = 0011
  
  assign F3 = ((M & zero) | (~M & -1));
  
  //Case S = 0100
  
  assign T1 = A & ~B;
  CLA Adder1(C1,T2,A,T1,Cin);
  
  assign F4 = (M & ~(A & B)) | (~M & T2);
  
  //Case S = 0101
  
  assign T3 = A | B;
  CLA Adder2(C2,T4,T3,T1,Cin);
  
  assign F5 = (M & ~B) | (~M & T4);
  
  //Case S = 0110
  
  CLA Adder3(C3,T5,A,~B,1'b1);
  CLA Adder4(C4,T6,T5,4'b1110,1'b1);
  
  assign F6 = (M & (A ^ B)) | (~M & T6);
  
  //Case S = 0111
  
  assign T7 = A & B;
  CLA Adder5(C5,T8,T7,4'b1110,1'b1);
  
  assign F7 = (M & T1) | (~M & T8);
  
  //Case S = 1000
  
  CLA Adder6(C6,T9,A,T7,Cin);
  
  assign F8 = (M & (~A | B)) | (~M & T9);
  
  //Case S = 1001
  
  CLA Adder7(C7,T10,A,B,Cin);
  
  assign F9 = (M & (~A ^ B)) | (~M & T10);
  
  //Case S = 1010
  
  assign T11 = A | ~B;
  CLA Adder8(C8,T12,T11,T7,Cin);
  
  assign F10 = (M & B) | (~M & T12);
  
  //Case S = 1011
  
  assign F11 = (M & T7) | (~M & T8);
  
  //Case S = 1100
  
  CLA Adder9(C9,T13,A,A,Cin);
  
  assign F12 = (M & 4'b0001) | (~M & T13);
  
  //Case S = 1101
  
  CLA Adder10(C10,T14,T3,A,Cin);
  
  assign F13 = (M & T11) | (~M & T14);
  
  //Case S = 1110
  
  CLA Adder11(C11,T15,T11,A,Cin);
  
  assign F14 = (M & T3) | (~M & T15);
  
  //Case S = 1111
  
  CLA Adder12(C12,T16,A,4'b1110,1'b1);
  
  assign F15 = (M & A) | (~M & T16);
  
  //Assignment of F and Cout with the logic of a multiplexer 
  
  assign F[0] = (T[0] & F0[0]) | (T[1] & F1[0]) | (T[2] & F2[0]) | (T[3] & F3[0]) | (T[4] & F4[0]) | (T[5] & F5[0]) | (T[6] & F6[0]) | (T[7] & F7[0]) | (T[8] & F8[0]) |  (T[9] & F9[0]) | (T[10] & F10[0]) | (T[11] & F11[0]) | (T[12] & F12[0]) | (T[13] & F13[0]) | (T[14] & F14[0]) | (T[15] & F15[0]);
  
  assign F[1] = (T[0] & F0[1]) | (T[1] & F1[1]) | (T[2] & F2[1]) | (T[3] & F3[1]) | (T[4] & F4[1]) | (T[5] & F5[1]) | (T[6] & F6[1]) | (T[7] & F7[1]) | (T[8] & F8[1]) |  (T[9] & F9[1]) | (T[10] & F10[1]) | (T[11] & F11[1]) | (T[12] & F12[1]) | (T[13] & F13[1]) | (T[14] & F14[1]) | (T[15] & F15[1]);
  
  assign F[2] = (T[0] & F0[2]) | (T[1] & F1[2]) | (T[2] & F2[2]) | (T[3] & F3[2]) | (T[4] & F4[2]) | (T[5] & F5[2]) | (T[6] & F6[2]) | (T[7] & F7[2]) | (T[8] & F8[2]) |  (T[9] & F9[2]) | (T[10] & F10[2]) | (T[11] & F11[2]) | (T[12] & F12[2]) | (T[13] & F13[2]) | (T[14] & F14[2]) | (T[15] & F15[2]);
  
  assign F[3] = (T[0] & F0[3]) | (T[1] & F1[3]) | (T[2] & F2[3]) | (T[3] & F3[3]) | (T[4] & F4[3]) | (T[5] & F5[3]) | (T[6] & F6[3]) | (T[7] & F7[3]) | (T[8] & F8[3]) |  (T[9] & F9[3]) | (T[10] & F10[3]) | (T[11] & F11[3]) | (T[12] & F12[3]) | (T[13] & F13[3]) | (T[14] & F14[3]) | (T[15] & F15[3]);
  
  assign Cout = (T[4] & C1) | (T[5] & C2) | (T[8] & C6) | (T[9] & C7) | (T[10] & C8) | (T[12] & C9) | (T[13] & C10) | (T[14] & C11);
  
  
endmodule