`timescale 1ns / 1ps

//Assignment 3
//Problem 3
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

//Testbench of Serial Binary Multiplier using Right Shift

module Bin_MUL_RS_TB();
  
 reg [5:0] a,b;
 reg clk,rst,load;
 wire [11:0] product;
  
  Bin_MUL_RS func(clk,rst,load,a,b,product);
 
 initial
 begin
   $monitor("a= %d, b = %d, rst = %b, prod = %d",a,b,rst,product);

    clk = 0;
    a = 6'b010101; b = 6'b000011; rst = 1; #20;
    a = 6'b010101; b = 6'b000011; rst = 0; #120;
    $finish;
 end

 always #5 clk = !clk;
  
  //Comment the region from line 1 to line 2 if using Vivado

  //....line 1.....
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
  //....line 2.....
  
endmodule