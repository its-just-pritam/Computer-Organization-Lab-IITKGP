`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2020 02:06:23
// Design Name: 
// Module Name: HBA_TB
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

//Hybrid Adder Testbench

module HBA_TB();

    reg [7:0] A;
    reg [7:0] B;
    reg Cin;
    
    wire [7:0] Sum;
    wire Cout;
    
    HBA Hybrid_1(A,B,Cin,Sum,Cout);
    
    initial
    begin
        A = 8'b00000000;
        B = 8'b00000000;
        Cin = 0;
        #400 $finish;
    end
    
    always #10 A = A + 4;
    always #25 B = B + 7;
    always #40 Cin = ~Cin;
    
    

endmodule
