`timescale 1ns/1ns

module RTL(
	input clk,
	input rst_n,
	input data_in,
	output reg data_out
	);

    reg data_in_reg;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            data_in_reg <= 0;
        end
        else begin
            data_in_reg <= data_in;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            data_out <= 0;
        end
        else begin
            data_out <= data_in & ~data_in_reg;
        end
    end
endmodule