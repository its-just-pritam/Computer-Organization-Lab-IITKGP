//Assignment 4
//Problem 1
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

module two_complementer(inp,clk,reset,out);

    input inp,clk,reset;
    output reg out;

	reg state;
	parameter S0 = 1'b0, S1 = 1'b1;
	 
	always@(posedge clk, posedge reset) 
	begin
		if(reset)
			state <= 0;
		else
		begin

			case(state)
				S0:
				begin
					if(inp==0)
					begin
						state <= S0;
						out <= 0;
					end
					else 
					begin
						state <= S1;
						out <= 1;
					end
				end

				S1:
				begin
					if(inp==0)
					begin
						state <= S1;
						out <= 1;
					end
					else 
					begin
						state <= S1;
						out <= 0;
					end
				end

			endcase
	 
	 	end
	 end

endmodule
