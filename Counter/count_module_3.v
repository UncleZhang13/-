`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,
	input mode,
	output reg [3:0]number,
	output reg zero
	);

    reg [3:0] num;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            num <= 0;
        end
        else case (mode)
            0: begin
                if(num == 0) num <= 9;
                else num <= num - 1;
            end
            1: begin
                if(num == 9) num <= 0;
                else num <= num + 1;
            end
            default: num <= num;
        endcase
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