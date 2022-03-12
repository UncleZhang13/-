`timescale 1ns/1ns

module decoder_38(
   input             E1_n   ,
   input             E2_n   ,
   input             E3     ,
   input             A0     ,
   input             A1     ,
   input             A2     ,
   
   output wire       Y0_n   ,  
   output wire       Y1_n   , 
   output wire       Y2_n   , 
   output wire       Y3_n   , 
   output wire       Y4_n   , 
   output wire       Y5_n   , 
   output wire       Y6_n   , 
   output wire       Y7_n   
);

reg [7:0]Y;
always @(*) begin
   casex({E3, E1_n, E2_n, A2, A1, A0})
   6'bx1x_xxx: Y = 8'b1111_1111;
   6'bxx1_xxx: Y = 8'b1111_1111;
   6'b0xx_xxx: Y = 8'b1111_1111;
   6'b100_000: Y = 8'b1111_1110;
   6'b100_001: Y = 8'b1111_1101;
   6'b100_010: Y = 8'b1111_1011;
   6'b100_011: Y = 8'b1111_0111;
   6'b100_100: Y = 8'b1110_1111;
   6'b100_101: Y = 8'b1101_1111;
   6'b100_110: Y = 8'b1011_1111;
   6'b100_111: Y = 8'b0111_1111;
   default: Y = 8'b1111_1111;
   endcase
end

assign {Y7_n, Y6_n, Y5_n, Y4_n, Y3_n, Y2_n, Y1_n, Y0_n} = Y;

endmodule