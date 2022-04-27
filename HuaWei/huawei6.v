`timescale 1ns/1ns

module huawei6(
	input wire clk0  ,
	input wire clk1  ,
	input wire rst  ,
	input wire sel ,
	output wire clk_out
);
//*************code***********//
reg sel0, sel1;

always @(negedge clk0 or negedge rst) begin
    if(!rst) sel0 <= 0;
    else sel1 <= !sel0 & sel;
end

always @(negedge clk1 or negedge rst) begin
    if(!rst) sel1 <= 0;
    else sel0 <= !sel1 & !sel;
end

assign clk_out = (sel0 & clk0) | (sel1 & clk1);

//*************code***********//
endmodule