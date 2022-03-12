`timescale 1ns/1ns
module ram_mod(
	input clk,
	input rst_n,
	
	input write_en,
	input [7:0]write_addr,
	input [3:0]write_data,
	
	input read_en,
	input [7:0]read_addr,
	output reg [3:0]read_data
);

reg [3:0] write_data_r [0:7];
integer i;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      for(i = 0; i < 7; i = i + 1)
        write_data_r[i] <= 0; 
    end
    else if (write_en) begin
        write_data_r[write_addr] <= write_data;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        read_data <= 0;
    end
    else if (read_en) begin
        read_data <= write_data_r[read_addr];
    end
    else begin
      read_data <= 0;
    end
end
	

endmodule