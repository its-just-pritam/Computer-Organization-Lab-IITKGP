`timescale 1ns / 1ps

//Assignment 3
//Problem 3
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

//Serial Binary Multiplier using Right Shift

module Bin_MUL_RS(clk,rst,load,a,b,product);
 
 input [5:0] a,b;
 input clk,rst,load;
 output reg [11:0] product;
  
  reg C;
  reg [11:0] T,S;
  reg [3:0] count;
  
  always @(posedge clk or posedge rst)
  begin
    if(rst)
    begin
        count = 4'b0000;
        product = 0;
        T = {6'b000000,b};
        S = {a,6'b000000};
        C = 0;
    end
    else if(count < 4'b0110)
    begin
      
      if(T[0] == 1'b1)
      {C,T} = T + S;
      
      T = T >> 1;
      T[11] = C;
      product = T;
      count = count + 1;
      
    end
  end
 
endmodule