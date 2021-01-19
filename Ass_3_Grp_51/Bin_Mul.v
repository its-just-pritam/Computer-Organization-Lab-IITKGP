`timescale 1ns / 1ps

//Assignment 3
//Problem 1
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

//Half Adder

module HA(sum,carry,a,b);

	output sum,carry;
	input a,b;
	
	assign sum = a^b;
	assign carry = a&b;
	
endmodule

//Full Adder

module FA(S,Cout,A,B,Cin);

    input A,B,Cin;
    output Cout,S;
    wire T1,T2,T3;
    
    xor XOR_1(T1,A,B);
    xor XOR_2(S,T1,Cin);
    
    and AND_1(T2,A,B);
    and AND_2(T3,Cin,T1);
    or OR_1(Cout,T2,T3);

endmodule

//Combinational Binary Multiplier

module Bin_Mul(a,b,product);
    
    input [5:0] a,b;
    output [11:0] product;
    
    wire [35:0] T;
    wire [25:0] c;
    
    //Multiplication
    assign T[0] = a[0] & b[0];
    assign T[1] = a[0] & b[1];
    assign T[2] = a[0] & b[2];
    assign T[3] = a[0] & b[3];
    assign T[4] = a[0] & b[4];
    assign T[5] = a[0] & b[5];
    
    assign T[6] = a[1] & b[0];
    assign T[7] = a[1] & b[1];
    assign T[8] = a[1] & b[2];
    assign T[9] = a[1] & b[3];
    assign T[10] = a[1] & b[4];
    assign T[11] = a[1] & b[5];
    
    assign T[12] = a[2] & b[0];
    assign T[13] = a[2] & b[1];
    assign T[14] = a[2] & b[2];
    assign T[15] = a[2] & b[3];
    assign T[16] = a[2] & b[4];
    assign T[17] = a[2] & b[5];
    
    assign T[18] = a[3] & b[0];
    assign T[19] = a[3] & b[1];
    assign T[20] = a[3] & b[2];
    assign T[21] = a[3] & b[3];
    assign T[22] = a[3] & b[4];
    assign T[23] = a[3] & b[5];
    
    assign T[24] = a[4] & b[0];
    assign T[25] = a[4] & b[1];
    assign T[26] = a[4] & b[2];
    assign T[27] = a[4] & b[3];
    assign T[28] = a[4] & b[4];
    assign T[29] = a[4] & b[5];
    
    assign T[30] = a[5] & b[0];
    assign T[31] = a[5] & b[1];
    assign T[32] = a[5] & b[2];
    assign T[33] = a[5] & b[3];
    assign T[34] = a[5] & b[4];
    assign T[35] = a[5] & b[5];
    
    //Addition
    assign product[0] = T[0];
    
  	HA H0(product[1],c[0],T[1],T[6]);
    
  	wire p20;
  	FA H1(p20,c[1],T[2],T[7],c[0]);
  	HA F1(product[2],c[2],p20,T[12]);
    
  	wire p30,p31;
  	FA H2(p30,c[3],T[3],T[8],c[1]);
    HA F2(p31,c[4],p30,T[13]);
  	HA F3(product[3],c[5],p31,T[18]);
    
  	wire p40,p41,p42;
  	FA H3(p40,c[6],T[4],T[9],c[3]);
  	HA F4(p41,c[7],p40,T[14]);
    HA F5(p42,c[8],p41,T[19]);
    HA F6(product[4],c[9],p42,T[24]);
    
  	wire p50,p51,p52,p53;
  	FA H4(p50,c[10],T[5],T[10],c[6]);
    HA F7(p51,c[11],p50,T[15]);
    HA F8(p52,c[12],p51,T[20]);
    HA F9(p53,c[13],p52,T[25]);
    HA F10(product[5],c[14],p53,T[30]);

  	wire p60,p61,p62;
  	FA H5(p60,c[15],T[11],T[16],c[10]);
    HA F11(p61,c[16],p60,T[21]);
    HA F12(p62,c[17],p61,T[26]);
    HA F13(product[6],c[18],p62,T[31]);
    
    wire p70,p71;
  	FA H6(p70,c[19],T[17],T[22],c[15]);
    HA F14(p71,c[20],p70,T[27]);
    HA F15(product[7],c[21],p71,T[32]);
    
    wire p80;
  	FA H7(p80,c[22],T[23],T[28],c[19]);
    HA F16(product[8],c[23],p80,T[33]);
    
  	FA H8(product[9],c[24],T[29],T[34],c[22]);
    
    HA H9(product[10],c[25],T[35],c[24]);
    
  	assign product[11] = c[25];

endmodule
