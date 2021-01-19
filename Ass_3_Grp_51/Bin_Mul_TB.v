`timescale 1ns / 1ps

//Assignment 3
//Problem 1
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

//Testbench of Combinational Binary Multiplier

module Bin_Mul_TB();

    reg [5:0] a,b;
    wire [11:0] product;
    
    Bin_Mul UBM(a,b,product);
    
    initial
    begin
        $monitor("a = %d, b = %d, product = %d", a, b, product);
    
        a = 6'b000000;
        b = 6'b000000;
        
        #100 $finish;
    end
    
    always #50 a = a + 10;
    always #30 b = b + 16;

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
