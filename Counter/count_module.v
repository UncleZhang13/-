`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,

    output reg [5:0]second,
    output reg [5:0]minute
	);
	
	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            second <= 0;
        end
        else if (minute == 60) begin
            second <= 0;
        end
        else if (second == 60) begin
            second <= 1;
        end
        else begin
            second <= second + 1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            minute <= 0;
        end
        else if(second == 60) begin
            minute <= minute + 1;
        end
        else if(minute == 60) begin
            minute <= minute;
        end
    end
	
endmodule