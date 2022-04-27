`timescale 1ns/1ns

module add_4(
   input         [3:0]  A   ,
   input         [3:0]  B   ,
   input                Ci  , 

   output	wire [3:0]  S   ,
   output   wire        Co   
);
wire [3:0]C_i;
add_full add_1(A[0], B[0], Ci, S[0], C_i[0]);
add_full add_2(A[1], B[1], C_i[0], S[1], C_i[1]);
add_full add_3(A[2], B[2], C_i[1], S[2], C_i[2]);
add_full add_4(A[3], B[3], C_i[2], S[3], C_i[3]);
assign Co  = C_i[3];
endmodule

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

wire c_1;
wire c_2;
wire sum_1;

add_half add_half_1(
   .A   (A),
   .B   (B),
         
   .S   (sum_1),
   .C   (c_1)  
);
add_half add_half_2(
   .A   (sum_1),
   .B   (Ci),
         
   .S   (S),
   .C   (c_2)  
);

assign Co = c_1 | c_2;
endmodule