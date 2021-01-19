`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2020 20:22:14
// Design Name: 
// Module Name: Serial_Add_TB
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

//Bit Serial Adder Testbench

module Serial_Add_TB();

    reg [7:0] A,B;
    reg clk, reset;
    
    wire [7:0] Sum;
    wire Cout;
    
    Ser_ADD func(Cout,Sum,A,B,clk,reset);
    
    initial begin
        $monitor("A = %b, B = %b, reset = %b, Sum=%b", A, B, reset, Sum);

        clk = 0;
        A = 8'b00101010; B = 8'b00101010; reset = 1; #20;
        A = 8'b00111010; B = 8'b00111010; reset = 0; #100;
        $finish;
    end

    always #5 clk = !clk;

endmodule
