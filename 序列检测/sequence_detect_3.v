`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input a,
	output reg match
	);
   reg [3:0] state, next_state;
   always @(posedge clk or negedge rst_n) begin
      if(!rst_n) state <= 0;
      else state <= next_state;
   end

   always @(*) begin
      case(state)
         0: begin
            if(a == 1) next_state = 1;
            else next_state = 0;
         end
         1: begin
            if(a == 1) next_state = 2;
            else next_state = 0;
         end
         2: begin
            if(a == 1) next_state = 3;
            else next_state = 0;
         end
         3: begin
            next_state = 4;
         end
         4: begin
            next_state = 5;
         end
         5: begin
            if(a == 1) next_state = 6;
            else next_state = 0;
         end
         6: begin
            if(a == 1) next_state = 7;
            else next_state = 0;
         end
         7: begin
            if(a == 1) next_state = 0;
            else next_state = 8;
         end
         8: begin
            if(a == 1) next_state = 1;
            else next_state = 0;
         end
         default: next_state = 0;
      endcase
   end

   always @(posedge clk or negedge rst_n) begin
      if(!rst_n) match <= 0;
      else if(state == 8) match <= 1;
      else match <= 0;
   end

  
endmodule