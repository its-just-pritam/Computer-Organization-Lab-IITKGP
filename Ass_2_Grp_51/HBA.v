`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2020 01:53:26
// Design Name: 
// Module Name: HBA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//Assignment 2
//Problem 2
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

//Carry Lookahead Adder

module CLA(A,B,Cin,Sum,Cout);

    input [3:0] A,B;
    input Cin;
    output [3:0] Sum;
    output Cout;
    
    wire [3:0] G,P,C;
    
    assign G[0] = (A[0]&B[0]),
    G[1] = (A[1]&B[1]),
    G[2] = (A[2]&B[2]),
    G[3] = (A[3]&B[3]);
    
    assign P[0] = (A[0]^B[0]),
    P[1] = (A[1]^B[1]),
    P[2] = (A[2]^B[2]),
    P[3] = (A[3]^B[3]);
    
    assign C[0] = Cin;
    assign C[1] = G[0]|(P[0]&C[0]);
    assign C[2] = G[1]|(P[1]&C[1]);
    assign C[3] = G[2]|(P[2]&C[2]);
    assign Cout = G[3]|(P[3]&C[3]);
    
    assign Sum[0] = (P[0]^C[0]),
    Sum[1] = (P[1]^C[1]),
    Sum[2] = (P[2]^C[2]),
    Sum[3] = (P[3]^C[3]);

endmodule

//Hybrid Adder

module HBA(A,B,Cin,Sum,Cout);

    input [7:0] A,B;
    input Cin;
    output [7:0] Sum;
    output Cout;
    
    wire [3:0] A1,B1,A2,B2,S1,S2;
    wire cout;
    
    assign A1[0] = A[0], B1[0] = B[0],
    A1[1] = A[1], B1[1] = B[1],
    A1[2] = A[2], B1[2] = B[2],
    A1[3] = A[3], B1[3] = B[3],
    A2[0] = A[4], B2[0] = B[4],
    A2[1] = A[5], B2[1] = B[5],
    A2[2] = A[6], B2[2] = B[6],
    A2[3] = A[7], B2[3] = B[7];
    
    CLA CarryLook_1(A1,B1,Cin,S1,cout);
    CLA CarryLook_2(A2,B2,cout,S2,Cout);
    
    assign Sum[0] = S1[0],
    Sum[1] = S1[1],
    Sum[2] = S1[2],
    Sum[3] = S1[3],
    Sum[4] = S2[0],
    Sum[5] = S2[1],
    Sum[6] = S2[2],
    Sum[7] = S2[3];

endmodule