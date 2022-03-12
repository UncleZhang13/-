`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input data,
	output reg match,
	output reg not_match
	);

   reg[5:0] data_reg;
    reg[3:0] cnt;
   always @(posedge clk or negedge rst_n) begin
      if(~rst_n) begin
         data_reg <= 0;
         cnt <= 0;
      end
      else begin
         data_reg <= {data, data_reg[5:1]};
          if(cnt == 5) cnt <= 0;
         else cnt <= cnt + 1;
      end
   end

   always @(posedge clk or negedge rst_n) begin
      if(~rst_n) begin
         match <= 0;
         not_match <= 0;
      end
       else if((cnt == 5) && (data_reg == 6'b011100)) begin
         match <= 1;
         not_match <= 0;
      end
       else if((cnt == 5) && (data_reg != 6'b011100)) begin
         match <= 0;
         not_match <= 1;
      end
      else begin
         match <= 0;
         not_match <= 0;
      end
   end

endmodule