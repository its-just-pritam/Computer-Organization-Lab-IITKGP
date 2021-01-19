`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2020 02:18:41
// Design Name: 
// Module Name: RCA_TB
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

//Ripple Carry Adder Testbench

module RCA_TB();

    reg [7:0] a;
    reg [7:0] b;
    reg cin;
    
    wire [7:0] sum;
    wire cout;
    
    RCA Ripple(a,b,cin,sum,cout);
    
    initial begin
        a = 8'b00000000;
        b = 8'b00000000;
        cin = 0;
        #200 $finish;
    end
    
    always #5 a = a + 1;
    always #10 b = b + 1;
    always #20 cin = ~cin;

endmodule
