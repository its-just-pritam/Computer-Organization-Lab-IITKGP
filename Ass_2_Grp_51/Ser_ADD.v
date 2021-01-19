`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2020 15:27:34
// Design Name: 
// Module Name: Ser_ADD
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
//Problem 3
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

// D Flip-Flop

module DFF(Q,D,clk,enable,reset);

    input D,clk,reset,enable;
    output Q;
    
    reg Q;
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            Q = 1'b0;
        end
        else
        begin
        if(enable)
            Q = D;
        end
    end

endmodule

//Bit Serial Adder

module Ser_ADD(Cout,Sum,A,B,clk,reset);

    input [7:0] A;
    input [7:0] B;
    input clk,reset;
    output Cout;
    output [7:0] Sum;
    
    reg [7:0] Sum;
    reg [3:0] count;
    reg Cout,enable;
    wire cout,cin,sum;

    FA Adder_1(cout,sum,A[count],B[count],cin);
    DFF Flip_Flop_1(cin,cout,clk,enable,reset);
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            enable = 1;
            count = 4'b0000;
            Sum = 8'b00000000;
        end
        else
        begin
            if( count > 4'b0111 )
                enable = 0;
            else
            begin
            if(enable) begin
                Cout = cout;
                count = count + 1;
                Sum = Sum >> 1;
                Sum[7] = sum;
            end
            end
        end
    end

endmodule


