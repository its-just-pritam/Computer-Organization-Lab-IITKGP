//Assignment 5
//Problem 3
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module carry_select_adder_tb();
    reg [15:0]A;
    reg [15:0]B;
    reg cin;
    wire [15:0]sum;
    wire cout;
    
    carry_select_adder t1(A,B,cin,cout,sum); 
    
    initial begin
    
      $monitor("Time = %g",$time," A = %d, B = %d, Cin = %d : Sum = %d, Cout = %d",A,B,cin,sum,cout);
    
    #10 A= 16'b0000000000011111; B=16'b000000000001100; cin=1'b0;
    
    #10 A= 16'b1100011000011111; B=16'b000000110001100; cin=1'b1;
    
    #10 A= 16'b1111111111111111; B=16'b100000000000000; cin=1'b1;
    
    #10 A= 16'b1001001001001001; B=16'b1001001001001001; cin=1'b1;
    
    end

endmodule
