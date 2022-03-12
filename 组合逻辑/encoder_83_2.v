`timescale 1ns/1ns

module encoder_83(
   input      [7:0]       I   ,
   input                  EI  ,
   
   output wire [2:0]      Y   ,
   output wire            GS  ,
   output wire            EO    
);
reg [2:0] Y_reg;
reg GS_reg;
reg EO_reg;

assign GS = GS_reg;
assign EO = EO_reg;
assign Y = Y_reg;

always @(*) begin
   if(!EI) begin 
      Y_reg = 3'b0;
      GS_reg = 0;
      EO_reg = 0;
   end
   else begin
      casex(I)
      8'b0000_0000: begin
                        Y_reg <= 3'b0;
                        GS_reg <= 0;
                        EO_reg <= 1;
                     end
      8'b1xxx_xxxx: begin
                        Y_reg <= 3'b111;
                        GS_reg <= 1;
                        EO_reg <= 0;
                     end                     
      8'b01xx_xxxx: begin
                        Y_reg <= 3'b110;
                        GS_reg <= 1;
                        EO_reg <= 0;
                     end 
      8'b001x_xxxx: begin
                        Y_reg <= 3'b101;
                        GS_reg <= 1;
                        EO_reg <= 0;
                     end 
      8'b0001_xxxx: begin
                        Y_reg <= 3'b100;
                        GS_reg <= 1;
                        EO_reg <= 0;
                     end 
      8'b0000_1xxx: begin
                        Y_reg <= 3'b011;
                        GS_reg <= 1;
                        EO_reg <= 0;
                     end 
      8'b0000_01xx: begin
                        Y_reg <= 3'b010;
                        GS_reg <= 1;
                        EO_reg <= 0;
                     end 
      8'b0000_001x: begin
                        Y_reg <= 3'b001;
                        GS_reg <= 1;
                        EO_reg <= 0;
                     end 
      8'b0000_0001: begin
                        Y_reg <= 3'b000;
                        GS_reg <= 1;
                        EO_reg <= 0;
                     end 
      default:       begin
                        Y_reg <= 3'b0;
                        GS_reg <= 0;
                        EO_reg <= 1;
                     end
      endcase
   end
end
endmodule