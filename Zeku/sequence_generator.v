`timescale 1ns/1ns

module sequence_generator(
	input clk,
	input rst_n,
	output reg data
	);

	wire [5:0] data_r;
	assign data_r = 6'b110100;

	reg[2:0] cnt;
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt <= 0;
		end
		else if (cnt >= 5) begin
			cnt <= 0;
		end
		else cnt <= cnt + 1;
	end

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			data <= 0;
		end
		else data <= data_r[cnt];
	end

endmodule