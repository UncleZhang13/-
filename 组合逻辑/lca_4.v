`timescale 1ns/1ns

module lca_4(
	input		[3:0]       A_in  ,
	input	    [3:0]		B_in  ,
    input                   C_1   ,
 
 	output	 wire			CO    ,
	output   wire [3:0]	    S
	);
    
	wire [3:0] G;
	wire [3:0] P;
	wire [4:0] C;

	assign C[0] = C_1;
    assign CO = C[4];
	
	G_port instg0 (A_in[0], B_in[0], G[0]);
	G_port instg1 (A_in[1], B_in[1], G[1]);
	G_port instg2 (A_in[2], B_in[2], G[2]);
	G_port instg3 (A_in[3], B_in[3], G[3]);

	P_port instp0 (A_in[0], B_in[0], P[0]);
	P_port instp1 (A_in[1], B_in[1], P[1]);
	P_port instp2 (A_in[2], B_in[2], P[2]);
	P_port instp3 (A_in[3], B_in[3], P[3]);

	S_port insts0 (P[0], C[0], S[0]);
	S_port insts1 (P[1], C[1], S[1]);
	S_port insts2 (P[2], C[2], S[2]);
	S_port insts3 (P[3], C[3], S[3]);

	C_port instc0 (G[0], P[0], C[0], C[1]);
	C_port instc1 (G[1], P[1], C[1], C[2]);
	C_port instc2 (G[2], P[2], C[2], C[3]);
	C_port instc3 (G[3], P[3], C[3], C[4]);
endmodule

module G_port(
	input A_in,
	input B_in,

	output G_out
); 
	assign G_out = A_in * B_in;
endmodule

module P_port(
	input A_in,
	input B_in,

	output P_out
);
	assign P_out = A_in ^ B_in;
endmodule

module S_port (
	input P_in,
	input C_in,

	output S_out
);
	assign S_out = P_in ^ C_in;
endmodule

module C_port (
	input G_in,
	input P_in,
	input C_in,

	output C_out
);
	assign C_out = G_in + P_in * C_in;
endmodule