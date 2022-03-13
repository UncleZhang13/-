`timescale 1ns/1ns

module game_count
    (
		input rst_n, //异位复位信号，低电平有效
        input clk, 	//时钟信号
        input [9:0]money,
        input set,
		input boost,
		output reg[9:0]remain,
		output reg yellow,
		output reg red
    );
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            remain <= 0;
        end
        else if (set) begin
            remain <= remain + money;
        end
        else if ((remain == 0) | ((remain == 1)&boost)) begin
            remain <= remain;
        end
        else if (boost) begin
            remain <= remain - 2;
        end
        else begin
            remain <= remain - 1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            yellow <= 0;
            red <= 0;
        end
        else if ((remain == 0) | ((remain == 1)&boost)) begin
            red <= 1;
            yellow <= 0;
        end
        else if (remain <= 10) begin
            yellow <= 1;
            red <= 0;
        end
        else begin
            yellow <= 0;
            red <= 0;
        end
    end

endmodule