//Assignment 4
//Problem 3
//Semseter 5
//Group No. 51
//Pritam Mallick (18CS10042)
//Smayan Das (18CS30011)

`timescale 1ns / 1ps

//Parallel Loader
module PIPO(dataOut,dataIn,load,clk);

  input load,clk;
  input [7:0] dataIn;
  output reg [7:0] dataOut;
  
  always @(posedge clk)
    if(load)
      dataOut <= dataIn;
  
endmodule

//Full Adder
module FA(Cout,S,A,B,Cin);

    input A,B,Cin;
    output Cout,S;
    wire T1,T2,T3;
    
    xor XOR_1(T1,A,B);
    xor XOR_2(S,T1,Cin);
    
    and AND_1(T2,A,B);
    and AND_2(T3,Cin,T1);
    or OR_1(Cout,T2,T3);

endmodule


//Ripple Carry Adder
module RCA(a,b,cin,sum,cout);

    input [7:0] a;
    input [7:0] b;
    input cin;
    
    output [7:0] sum;
    output cout;
    wire [6:0] T;
    
    FA FullAdd_1(T[0],sum[0],a[0],b[0],cin);
    FA FullAdd_2(T[1],sum[1],a[1],b[1],T[0]);
    FA FullAdd_3(T[2],sum[2],a[2],b[2],T[1]);
    FA FullAdd_4(T[3],sum[3],a[3],b[3],T[2]);
    FA FullAdd_5(T[4],sum[4],a[4],b[4],T[3]);
    FA FullAdd_6(T[5],sum[5],a[5],b[5],T[4]);
    FA FullAdd_7(T[6],sum[6],a[6],b[6],T[5]);
    FA FullAdd_8(cout,sum[7],a[7],b[7],T[6]);

endmodule

//Subtract Module
module Subtract(out,in1,in2);

  input [7:0] in1,in2;
  output reg [7:0] out;
  
  wire cout;
  wire [7:0] T1,T2;
  RCA Adder1(in1,~in2,8'b00000001,T1,cout);
  RCA Adder2(in2,~in1,8'b00000001,T2,cout);
  
  always @(*) begin
    if( in1 > in2 ) 
      out = T1;
    else if( in1 < in2 )
      out = T2;
  end
  
endmodule

//Comaprision Module
module Compare(lt,gt,eq,data1,data2);

  input [7:0] data1,data2;
  output lt,gt,eq;
  
  assign lt = (data1 < data2);
  assign gt = (data1 > data2);
  assign eq = (data1 == data2);
  
endmodule

//Multiplexer
module MUX(out,in1,in2,sel);

  input sel;
  input [7:0] in1,in2;
  output [7:0]out;
  
  assign out = sel ? in2 : in1;
  
endmodule

//Data Path Module
module DataPath(gt,lt,eq,ldA,ldB,sel1,sel2,selIn,dataIn,clk);

  input ldA,ldB,sel1,sel2,selIn,clk;
  input [7:0] dataIn;
  
  output gt,lt,eq;
  wire [7:0] A,B,X,Y,bus,sub;
  
  PIPO P1(A,bus,ldA,clk);
  PIPO P2(B,bus,ldB,clk);
  MUX M1(X,A,B,sel1);
  MUX M2(Y,A,B,sel2);
  MUX M3(bus,sub,dataIn,selIn);
  Subtract SUB(sub,X,Y);
  Compare COMP(lt,gt,eq,A,B);
  
endmodule


//Control Path Module
module ControlPath(ldA,ldB,sel1,sel2,selIn,Exit,clk,lt,gt,eq,Start);
  
  input clk,lt,gt,eq,Start;
  output reg ldA,ldB,sel1,sel2,selIn,Exit;
  
  reg [2:0] S;
  parameter S0 = 3'b000;
  parameter S1 = 3'b001;
  parameter S2 = 3'b010;
  parameter S3 = 3'b011;
  parameter S4 = 3'b100;
  parameter S5 = 3'b101;
  
  always @(posedge clk)
  begin
    case(S)
      
      S0: begin
        //$display("State %d",S);
        if(Start) S <= S1;
      end
      
      S1: begin
        //$display("State %d",S);
        S <= S2;
      end
      
      S2: begin
        //$display("State %d",S);
        if(eq) S <= S5;
        else if(lt) S <= S3;
        else if(gt) S <= S4;
      end
      
      S3: begin
        //$display("State %d",S);
        if(eq) S <= S5;
        else if(lt) S <= S3;
        else if(gt) S <= S4;
      end
      
      S4: begin
        //$display("State %d",S);
        if(eq) S <= S5;
        else if(lt) S <= S3;
        else if(gt) S <= S4;
      end
      
      S5: S <= S5;
      
      default: S <= S0;
      
    endcase
  end
  
  always @(S)
  begin
    case(S)
      
      S0: begin
          selIn = 1;
          ldA = 1;
          ldB = 0;
          Exit = 0;
        end
      
      S1: begin
          selIn = 1;
          ldA = 0;
          ldB = 1;
        end
      
      S2: begin
        if(eq) begin
        Exit = 1;
      end
      else if(lt) begin
        sel1 = 1;
        sel2 = 0;
        selIn = 0;
        #2 ldA = 0;
        ldB = 1;
      end
        else if(gt) begin
        sel1 = 0;
        sel2 = 1;
        selIn = 0;
        #2 ldA = 1;
        ldB = 0;
      end
        //$display("lt=%d, gt=%d, eq=%d",lt,gt,eq);
      end
      
      S3: begin
        if(eq) begin
        Exit = 1;
      end
      else if(lt) begin
        sel1 = 1;
        sel2 = 0;
        selIn = 0;
        #2 ldA = 0;
        ldB = 1;
      end
        else if(gt) begin
        sel1 = 0;
        sel2 = 1;
        selIn = 0;
        #2 ldA = 1;
        ldB = 0;
      end
      //$display("lt=%d, gt=%d, eq=%d",lt,gt,eq);
      end
      
      S4: begin
        if(eq) begin
        Exit = 1;
      end
      else if(lt) begin
        sel1 = 1;
        sel2 = 0;
        selIn = 0;
        #2 ldA = 0;
        ldB = 1;
      end
        else if(gt) begin
        sel1 = 0;
        sel2 = 1;
        selIn = 0;
        #2 ldA = 1;
        ldB = 0;
      end
      //$display("lt=%d, gt=%d, eq=%d",lt,gt,eq);
      end
      
      S5: begin
        Exit = 1;
        sel1 = 0;
        sel2 = 0;
        ldA = 0;
        ldB = 0;
      end
      
      default begin
        ldA = 0;
        ldB = 0;
      end
      
    endcase
  end
  
endmodule