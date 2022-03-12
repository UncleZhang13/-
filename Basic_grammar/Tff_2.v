`timescale 1ns/1ns
module Tff_2 (
input wire data, clk, rst,
output reg q  
);
//*************code***********//
reg q1;
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            q1 <= 0;
            q <= 0;
        end
        else begin
            if (data) begin
            q1 <= !q1;
            end
            if (q1) begin
            q <= !q;
            end
        end
    end
//*************code***********//
endmodule