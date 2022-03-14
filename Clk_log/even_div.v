`timescale 1ns/1ns

module even_div
    (
    input     wire rst ,
    input     wire clk_in,
    output    wire clk_out2,
    output    wire clk_out4,
    output    wire clk_out8
    );
//*************code***********//
reg[2:0] cnt_2, cnt_4, cnt_8;
reg clk_out2_r, clk_out4_r, clk_out8_r;

assign clk_out2 = clk_out2_r;
assign clk_out4 = clk_out4_r;
assign clk_out8 = clk_out8_r;

always @(posedge clk_in or negedge rst) begin
    if(!rst) cnt_2 <= 0;
    else if(cnt_2 == 0) cnt_2 <= 0;
    else cnt_2 <= 0;
end

always @(posedge clk_in or negedge rst) begin
    if(!rst) cnt_4 <= 0;
    else if(cnt_4 == 1) cnt_4 <= 0;
    else cnt_4 <= cnt_4 + 1;
end

always @(posedge clk_in or negedge rst) begin
    if(!rst) cnt_8 <= 0;
    else if(cnt_8 == 3) cnt_8 <= 0;
    else cnt_8 <= cnt_8 + 1;
end

always @(posedge clk_in or negedge rst) begin
    if(!rst) begin
        clk_out2_r <= 0;  
        clk_out4_r <= 0;
        clk_out8_r <= 0;
    end
    else begin
       if(cnt_2 == 0) clk_out2_r <= ~clk_out2_r;
       if(cnt_4 == 0) clk_out4_r <= ~clk_out4_r;
       if(cnt_8 == 0) clk_out8_r <= ~clk_out8_r;
    end
end


//*************code***********//
endmodule