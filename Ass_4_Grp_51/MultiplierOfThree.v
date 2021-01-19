//Assignment 4
//Problem 2
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module MulOfThree(clk,reset,inp,out);
  
  	input clk,reset,inp;
  	output reg out;
  
	reg [1:0] state;
  	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
  
	always @(posedge clk,posedge reset)
    begin
      
		if(reset) begin
			state <= 0;
			out <= 1;
		end
		else begin
          
			case(state)
              
			S0: begin
				if(inp) begin
					state <= S1;
					out <= 0;
				end
				else begin
					state <= S0;
					out <= 1;
				end
			end
			S1: begin
				if(inp) begin
					state <= S0;
					out <= 1;
				end
				else begin
					state <= S2;
					out <= 0;
				end
			end
			S2: begin
				if(inp) begin
					state <= S2;
					out <= 0;
				end
				else begin
					state <= S1;
					out <= 0;
				end
			end
              
			endcase
          
		end
	end
  
endmodule