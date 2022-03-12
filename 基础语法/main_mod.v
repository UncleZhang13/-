`timescale 1ns/1ns
module main_mod(
	input clk,
	input rst_n,
	input [7:0]a,
	input [7:0]b,
	input [7:0]c,
	
	output [7:0]d
);
    wire [7:0] c1, c2;
    min_mode ins1 (clk, rst_n, a, b, c1);
    min_mode ins2 (clk, rst_n, b, c, c2);
    min_mode ins3 (clk, rst_n, c1, c2, d);
endmodule

module min_mode(
    input clk,
    input rst_n,
    input [7:0]a,
    input [7:0]b,

    output reg [7:0]c
);
always @(posedge clk or negedge rst_n)
        if(!rst_n)
            c <= 0;
        else if (a > b) 
            c <= b;
        else 
            c <= a;
endmodule       