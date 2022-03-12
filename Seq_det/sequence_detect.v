`timescale 1ns/1ns

module seq_circuit(
      input                A   ,
      input                clk ,
      input                rst_n,
 
      output   wire        Y   
);

reg [1:0] state, next_state;
reg Y_reg;

always @(posedge clk or negedge rst_n) begin
   if(!rst_n) state <= 0;
   else state <= next_state;
end

always @(*) begin
   case(state)
   2'b00: if(A == 0) begin
            next_state <= 2'b01;
            Y_reg <= 0;
         end
         else begin
            next_state <= 2'b11;
            Y_reg <= 0;
         end
   2'b01: if(A == 0) begin
            next_state <= 2'b10;
            Y_reg <= 0;
         end
         else begin
            next_state <= 2'b00;
            Y_reg <= 0;
         end
   2'b10: if(A == 0) begin
            next_state <= 2'b11;
            Y_reg <= 0;
      end
      else begin
            next_state <= 2'b01;
            Y_reg <= 0;
      end
   2'b11: if(A == 0) begin
            next_state <= 2'b00;
            Y_reg <= 1;
      end
      else begin
            next_state <= 2'b10;
            Y_reg <= 1;
      end
   default: Y_reg <= 0;
   endcase
end

assign Y = Y_reg;

endmodule