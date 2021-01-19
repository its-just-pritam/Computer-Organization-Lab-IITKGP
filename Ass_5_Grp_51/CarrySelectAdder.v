//Assignment 5
//Problem 3
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module carry_select_adder(a,b,carryIn,carryOut,sum);
    input [15:0] a;
    input [15:0] b;
    input carryIn;
    output carryOut;
    output [15:0] sum;
    
    wire Carry0,Carry10,Carry11,Carry20,Carry21,Carry30,Carry31;
    wire carryf0,carryf1;
    wire c0,c1,c2,c3;
    wire [3:0] s0;
    wire [3:0] s1;
    wire [3:0] s2;
    wire [3:0] s3;
    wire [3:0] s4;
    wire [3:0] s5;
    
    // The First Sum, doesn't need a mux.
    ripple_carry_adder Adder1(.A(a[3:0]),.B(b[3:0]),.CarryIn(carryIn),.CarryOut(Carry0),.Sum(sum[3:0]));
   
    // The Second Sum
    ripple_carry_adder Adder20(.A(a[7:4]),.B(b[7:4]),.CarryIn(0),.CarryOut(Carry10),.Sum(s0));
    
    ripple_carry_adder Adder21(.A(a[7:4]),.B(b[7:4]),.CarryIn(1),.CarryOut(Carry11),.Sum(s1));
    
    MUX Mux1(.In0(s0),.In1(s1),.c0(Carry10),.c1(Carry11),.sel(Carry0),.outs(sum[7:4]),.outc(Carryf0));
    
    // The Third Sum
    ripple_carry_adder Adder30(.A(a[11:8]),.B(b[11:8]),.CarryIn(0),.CarryOut(Carry20),.Sum(s2));
    
    ripple_carry_adder Adder31(.A(a[11:8]),.B(b[11:8]),.CarryIn(1),.CarryOut(Carry21),.Sum(s3));
        
    MUX Mux2(.In0(s2),.In1(s3),.c0(Carry20),.c1(Carry21),.sel(Carryf0),.outs(sum[11:8]),.outc(Carryf1));
    
    // The Fourth and final Sum.
    ripple_carry_adder Adder40(.A(a[15:12]),.B(b[15:12]),.CarryIn(0),.CarryOut(Carry30),.Sum(s4));
    
    ripple_carry_adder Adder41(.A(a[15:12]),.B(b[15:12]),.CarryIn(1),.CarryOut(Carry31),.Sum(s5));
    
    MUX Mux3(.In0(s4),.In1(s5),.c0(Carry30),.c1(Carry31),.sel(Carryf1),.outs(sum[15:12]),.outc(carryOut));
    
endmodule
    
module full_adder(S, Cout, A, B, Cin);
   input  A;
   input  B;
   input  Cin;
   output S;
   output Cout;   
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   
   xor(w1, A, B);
   xor(S, Cin, w1);
   and(w2, A, B);   
   and(w3, A, Cin);
   and(w4, B, Cin);   
   or(Cout, w2, w3, w4);
endmodule

module ripple_carry_adder(A,B,CarryIn,CarryOut,Sum);
    input [3:0] A;    // 4 bit Augend
    input [3:0] B;    // 4 bit Addend
    input CarryIn;    // Input Carry
    output [3:0] Sum; // 4-bit Sum
    output CarryOut;  // 1-bit Output Carry

    wire c0; // The carry out bit of adder1 and carry in bit of adder2
    wire c1; // The carry out bit of adder2 and carry in bit of adder3 
    wire c2; // The carry out bit of adder3 and carry in bit of adder4
    
    // Least significant bit
    full_adder adder1(.S(Sum[0]),.Cout(c0),.A(A[0]),.B(B[0]),.Cin(CarryIn));
    
    full_adder adder2(.S(Sum[1]),.Cout(c1),.A(A[1]),.B(B[1]),.Cin(c0));
    
    full_adder adder3(.S(Sum[2]),.Cout(c2),.A(A[2]),.B(B[2]),.Cin(c1));
    
    // Most significant bit
    full_adder adder4(.S(Sum[3]),.Cout(CarryOut),.A(A[3]),.B(B[3]),.Cin(c2));

endmodule

module MUX(In0,In1,c0,c1,sel,outs,outc);
    input [3:0] In0;
    input [3:0] In1;
    input c0,c1,sel;
    output [3:0] outs;
    output outc;

    assign outs=(sel==1'b1)?In1:In0;
    assign outc=(sel==1'b1)?c1:c0;
endmodule

