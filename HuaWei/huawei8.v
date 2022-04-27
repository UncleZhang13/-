`timescale 1ns/1ns

module huawei8//四位超前进位加法器
(
	input wire [3:0]A,
	input wire [3:0]B,
	output wire [4:0]OUT
);

//*************code***********//
wire [3:0] P, G, F;
wire [4:1] C;

Add1 inst_Add1 (.a(A[0]), .b(B[0]), .C_in(1'b0), .f(F[0]), .g(G[0]), .p(P[0]));
Add1 inst_Add2 (.a(A[1]), .b(B[1]), .C_in(C[1]), .f(F[1]), .g(G[1]), .p(P[1]));
Add1 inst_Add3 (.a(A[2]), .b(B[2]), .C_in(C[2]), .f(F[2]), .g(G[2]), .p(P[2]));
Add1 inst_Add4 (.a(A[3]), .b(B[3]), .C_in(C[3]), .f(F[3]), .g(G[3]), .p(P[3]));

CLA_4 inst_CLA1 (.P(P), .G(G), .C_in(1'b0), .Ci(C), .Gm(), .Pm());

assign OUT = {C[4], F};

//*************code***********//
endmodule

//////////////下面是两个子模块////////

module Add1
(
		input a,
		input b,
		input C_in,
		output f,
		output g,
		output p
		);
        assign g = a & b;
        assign p = a | b;
        assign f = a ^ b ^ C_in;
endmodule

module CLA_4(
		input [3:0]P,
		input [3:0]G,
		input C_in,
		output [4:1]Ci,
		output Gm,
		output Pm
	);
    assign Ci[1] = G[0] | P[0] & C_in;
    assign Ci[2] = G[1] | P[1] & Ci[1];
    assign Ci[3] = G[2] | P[2] & Ci[2];
    assign Ci[4] = G[3] | P[3] & Ci[3];
	
    assign Gm = G[3] | P[3] & G[2] | P[3] & P[2] & G[1] | P[3] & P[2] & P[1] & G[0];

    assign Pm = P[3] & P[2] & P[1] & P[0];

endmodule