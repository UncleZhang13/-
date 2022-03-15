`timescale 1ns/1ns

module div_M_N(
 input  wire clk_in,
 input  wire rst,
 output wire clk_out
);
parameter M_N = 8'd87; 
parameter c89 = 8'd24; // 8/9时钟切换点
parameter div_e = 5'd8; //偶数周期
parameter div_o = 5'd9; //奇数周期
//*************code***********//

// a + b = 10
// 8a + 9b = 87
// 解得 a = 3, b = 7
// 因此 8/9时间切换点为24

    reg [6:0] cnt87;
    reg [3:0] cnt8;
    reg [3:0] cnt9;
    reg clk_out_r;
    
    always @(posedge clk_in or negedge rst) begin
        if (!rst) begin
            cnt87 <= 0;
            cnt8 <= 0;
            cnt9 <= 0;
            clk_out_r <= 0;
        end
        else begin
            if (cnt87 <= c89 - 1) begin
                clk_out_r <= (cnt8 < (div_e >> 1)) ? 1 : 0;
                cnt8 <= (cnt8 == div_e - 1) ? 0 : cnt8 + 1;
            end
            if (cnt87 > c89 - 1) begin
                clk_out_r <= (cnt9 < (div_o >> 1)) ? 1 : 0;
                cnt9 <= (cnt9 == div_o - 1) ? 0 : cnt9 + 1;
            end
            cnt87 <= (cnt87 == M_N - 1) ? 0 : cnt87 + 1;
        end
    end

assign clk_out = clk_out_r;
//*************code***********//
endmodule