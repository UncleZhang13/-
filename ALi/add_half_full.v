`timescale 1ns/1ns

module add_half(
   input                A   ,
   input                B   ,
 
   output	wire        S   ,
   output   wire        C   
);

assign S = A ^ B;
assign C = A & B;
endmodule

/***************************************************************/
module add_full(
   input                A   ,
   input                B   ,
   input                Ci  , 

   output	wire        S   ,
   output   wire        Co   
);
wire S_1, C_1, C_2;
add_half add1(A, B, S_1, C_1);
add_half add2(S_1, Ci, S, C_2);
assign Co = C_1 | C_2;
endmodule