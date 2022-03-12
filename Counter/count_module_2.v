`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,
	input set,
	input [3:0] set_num,
	output reg [3:0]number,
	output reg zero
	);

    reg [3:0] num;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            num <= 0;
        end
        else if(num == 15) begin
            num <= 0;
        end
        else if(set) begin
            num <= set_num;
        end
        else begin
            num <= num + 1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            zero <= 0;
        end
        else if (num == 0) begin
            zero <= 1;
        end
        else begin
            zero <= 0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            number <= 0;
        end
        else begin
            number <= num;
        end
    end

endmodule