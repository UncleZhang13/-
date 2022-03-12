`timescale 1ns/1ns

module encoder_0(
   input      [8:0]         I_n   ,
   
   output reg [3:0]         Y_n   
);
always @(*) begin
	casex(I_n)
	9'b1_1111_1111: Y_n[3:0] = 4'b1111; 
	9'b0_xxxx_xxxx: Y_n[3:0] = 4'b0110; 
	9'b1_0xxx_xxxx: Y_n[3:0] = 4'b0111; 
	9'b1_10xx_xxxx: Y_n[3:0] = 4'b1000; 
	9'b1_110x_xxxx: Y_n[3:0] = 4'b1001; 
	9'b1_1110_xxxx: Y_n[3:0] = 4'b1010; 
	9'b1_1111_0xxx: Y_n[3:0] = 4'b1011;
	9'b1_1111_10xx: Y_n[3:0] = 4'b1100; 
	9'b1_1111_110x: Y_n[3:0] = 4'b1101; 
	9'b1_1111_1110: Y_n[3:0] = 4'b1110; 
	default: Y_n = 4'b0000;
	endcase
end

endmodule