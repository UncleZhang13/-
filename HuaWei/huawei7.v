`timescale 1ns/1ns

module huawei7(
	input wire clk  ,
	input wire rst  ,
	output reg clk_out
);

//*************code***********//
reg[1:0] state, next_state;

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		state <= 0;
	end
	else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		0: next_state <= 1;
		1: next_state <= 2;
		2: next_state <= 3;
		3: next_state <= 0;
		default: next_state <= 0;
	endcase
end

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		clk_out <= 0;
	end
	else begin
		clk_out <= (state == 0)? 1 : 0;
	end
end
//*************code***********//
endmodule