`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2020 01:47:56
// Design Name: 
// Module Name: RCA
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
//Problem 1
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

//Full Adder

module FA(Cout,S,A,B,Cin);

    input A,B,Cin;
    output Cout,S;
    wire T1,T2,T3;
    
    xor XOR_1(T1,A,B);
    xor XOR_2(S,T1,Cin);
    
    and AND_1(T2,A,B);
    and AND_2(T3,Cin,T1);
    or OR_1(Cout,T2,T3);

endmodule

//Ripple Carry Adder

module RCA(a,b,cin,sum,cout);

    input [7:0] a;
    input [7:0] b;
    input cin;
    
    output [7:0] sum;
    output cout;
    wire [6:0] T;
    
    FA FullAdd_1(T[0],sum[0],a[0],b[0],cin);
    FA FullAdd_2(T[1],sum[1],a[1],b[1],T[0]);
    FA FullAdd_3(T[2],sum[2],a[2],b[2],T[1]);
    FA FullAdd_4(T[3],sum[3],a[3],b[3],T[2]);
    FA FullAdd_5(T[4],sum[4],a[4],b[4],T[3]);
    FA FullAdd_6(T[5],sum[5],a[5],b[5],T[4]);
    FA FullAdd_7(T[6],sum[6],a[6],b[6],T[5]);
    FA FullAdd_8(cout,sum[7],a[7],b[7],T[6]);

endmodule

