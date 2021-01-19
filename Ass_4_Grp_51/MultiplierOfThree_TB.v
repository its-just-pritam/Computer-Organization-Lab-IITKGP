//Assignment 4
//Problem 2
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module three_detector_tb;

  reg  clk,reset,inp;
  wire out;

  reg[15:0] num;
  integer i;

  MulOfThree func(clk,reset,inp,out);

  initial
  begin

    clk = 0;
    reset = 1;
    num = 16'b0011100010111000;
    #5 reset = 0;

    for(i=0;i<=15;i=i+1)
    begin

      inp = num[i];
      #2 clk = 1;
      #2 clk = 0;
      $display("S%d Input = %b, Output = %b",func.state,inp,out);

    end
          
  end

endmodule