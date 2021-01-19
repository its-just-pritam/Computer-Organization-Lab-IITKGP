//Assignment 4
//Problem 1
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module two_complementer_tb;

	reg inp;
	reg clk;
	reg reset;

	wire out;

	two_complementer uut (inp,clk,reset,out);

	reg [15:0]sequence;
	reg [15:0]output_seq;
	integer i;

	initial
	begin
		
		clk = 0;
		reset = 1;
		inp = 0;
		assign sequence =  16'b0111011001101000;
		i=0;
		
		#5;

		reset =0;
		for( i = 0; i <= 15; i = i + 1)
		begin
			inp = sequence[i];
			clk = 1;
			#2;
			clk = 0;
			#2;
			output_seq[i] = out;
			$display(" Input = ", inp, ", Output = ", out);

		end

	end
      
endmodule

