`timescale 1ns/1ns

module ali16(
input clk,
input rst_n,
input d,
output reg dout
 );
reg[1:0] rst;
//*************code***********//
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        rst <= 2'b00;
    end
    else begin
        rst <= {rst[0], 1'b1};
    end
end

always @(posedge clk or negedge rst[1]) begin
    if(!rst[1]) begin
        dout <= 0;
    end
    else begin
        dout <= d;
    end
end

//*************code***********//
endmodule