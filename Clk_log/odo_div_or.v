`timescale 1ns/1ns

module odo_div_or
   (
    input    wire  rst ,
    input    wire  clk_in,
    output   wire  clk_out7
    );

//*************code***********//
//可实现N奇数分频,占空比50%

parameter N = 7;

reg clk_1, clk_2;
reg [2:0] cnt;

always @(posedge clk_in or negedge rst) begin
    if(!rst) cnt <= 0;
    else if (cnt == N - 1) cnt <= 0;
    else cnt <= cnt + 1; 
end

always @(posedge clk_in or negedge rst) begin
    if(!rst) clk_1 <= 0;
    else if ((cnt == N >> 1) || (cnt == N - 1)) clk_1 <= ~clk_1;
    else clk_1 <= clk_1;
end

always @(negedge clk_in or negedge rst) begin
    if(!rst) clk_2 <= 0;
    else if ((cnt == N >> 1) || (cnt == N - 1)) clk_2 <= ~clk_2;
    else clk_2 <= clk_2;
end

assign clk_out7 = clk_1 | clk_2;

//*************code***********//
endmodule