`timescale 1ns/1ns

module seq_circuit(
   input                C   ,
   input                clk ,
   input                rst_n,
 
   output   wire        Y   
);
   reg [1:0] state, next_state;

   always @(posedge clk or negedge rst_n) begin
      if(!rst_n) state <= 2'b00;
      else state <= next_state;
   end

   always @(*) begin
      case(state)
      2'b00: begin
         if(C == 0) next_state = 2'b00;
         else next_state = 2'b01;
      end
      2'b01: begin
         if(C == 0) next_state = 2'b11;
         else next_state = 2'b01;
      end
      2'b11: begin
         if(C == 0) next_state = 2'b11;
         else next_state = 2'b10;
      end
      2'b10: begin
         if(C == 0) next_state = 2'b00;
         else next_state = 2'b10;
      end
      endcase
   end

   assign Y = (state == 2'b11) | ((state == 2'b10) & (C == 1));
endmodule