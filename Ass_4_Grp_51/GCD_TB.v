//Assignment 4
//Problem 3
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps


//GCD Testbench
module GCD_TB;

  reg [7:0] dataIn;
  reg clk,Start;
  wire Exit;
  
  DataPath DP(gt,lt,eq,ldA,ldB,sel1,sel2,selIn,dataIn,clk);
  
  ControlPath CP(ldA,ldB,sel1,sel2,selIn,Exit,clk,lt,gt,eq,Start);
  
  initial
  begin
    clk = 0;
    #5 Start = 1;
    #1000 $finish;
  end
  
  always #6 clk = ~clk;
 
  initial
  begin
    #13 dataIn = 119;
    #10 dataIn = 51;
  end
          
  initial
  begin
    $monitor($time, " A = %d, B = %d, GCD = %d, Completion Status = %b",DP.A,DP.B,DP.A,Exit);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
    

endmodule