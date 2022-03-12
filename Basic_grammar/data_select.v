`timescale 1ns/1ns
module data_select(
	input clk,
	input rst_n,
	input signed[7:0]a,
	input signed[7:0]b,
	input [1:0]select,
	output reg signed [8:0]c
);

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        c <= 0;
    end
    else case (select)
        0: c <= a;
        1: c <= b;
        2: c <= a + b;
        3: c <= a - b;
    endcase
end
endmodule