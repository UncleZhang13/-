`timescale 1ns/1ns
module encoder_83(
   input      [7:0]       I   ,
   input                  EI  ,
   
   output wire [2:0]      Y   ,
   output wire            GS  ,
   output wire            EO    
);
assign Y[2] = EI & (I[7] | I[6] | I[5] | I[4]);
assign Y[1] = EI & (I[7] | I[6] | ~I[5]&~I[4]&I[3] | ~I[5]&~I[4]&I[2]);
assign Y[0] = EI & (I[7] | ~I[6]&I[5] | ~I[6]&~I[4]&I[3] | ~I[6]&~I[4]&~I[2]&I[1]);

assign EO = EI&~I[7]&~I[6]&~I[5]&~I[4]&~I[3]&~I[2]&~I[1]&~I[0];

assign GS = EI&(I[7] | I[6] | I[5] | I[4] | I[3] | I[2] | I[1] | I[0]);
//assign GS = EI&(| I);
         
endmodule

module encoder_164(
   input      [15:0]      A   ,
   input                  EI  ,
   
   output wire [3:0]      L   ,
   output wire            GS  ,
   output wire            EO    
);

   wire EO1;
   wire [2:0] L1, L2;
   wire GS1, GS2;
   encoder_83 inst1 (A[15:8], EI, L1[2:0],  GS1, EO1);
   encoder_83 inst2 (A[7:0], EO1, L2[2:0], GS2, EO);
   
   assign GS = GS1 || GS2; 

   assign L[3] = GS1;
   assign L[2] = L1[2] || L2[2];
   assign L[1] = L1[1] || L2[1];
   assign L[0] = L1[0] || L2[0];

    
    
endmodule