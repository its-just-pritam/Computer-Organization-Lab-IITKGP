`timescale 1ns / 1ps

//Assignment 3
//Problem 2
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

//Serial Binary Multiplier using Left Shift

module Bin_MUL_LS(clk,rst,load,a,b,product);
 
 input [5:0] a,b;
 input clk,rst,load;
 output reg [11:0] product;
  
  reg C;
  reg [11:0] T;
  reg [3:0] count;
  
  always @(posedge clk or posedge rst)
  begin
    if(rst)
    begin
      	count = 4'b0000;
      	product = 0;
      	T = {12'b000000000000};
      	C = 0;
    end
    else if(count < 4'b0110)
    begin
      
      if( b[count] == 1'b0 )
        T = 12'b000000000000;
      else if( b[count] == 1'b1 )
        T = {6'b000000,a};
      
      T = T << count;
      {C,product} = product + T + C;
      
      count = count + 1;
      
    end
  end
 
endmodule