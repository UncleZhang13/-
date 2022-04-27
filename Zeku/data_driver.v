`timescale 1ns/1ns
module data_driver(
	input clk_a,
	input rst_n,
	input data_ack,
	output reg [3:0]data,
	output reg data_req
	);
    reg [4:0] cnt;
    reg data_ack_r1, data_ack_r2;

    always @(posedge clk_a or negedge rst_n) begin
        if(!rst_n) begin
            data_ack_r1 <= 0;
            data_ack_r2 <= 0;
        end
        else begin
            data_ack_r1 <= data_ack;
            data_ack_r2 <= data_ack_r1;
        end
    end

    always @(posedge clk_a or negedge rst_n) begin
        if(!rst_n) begin
            data <= 0;
        end
        else if (data_ack_r1 & !data_ack_r2) begin
            if(data == 7) data <= 0;
            else data <= data + 1;
        end
        else begin
            data <= 0;
        end
    end

    always @(posedge clk_a or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 0;
        end
        else if (data_ack_r1 & !data_ack_r2)  begin
            cnt <= 0;
        end
        else if(data_req) begin
            cnt <= cnt;
        end
        else begin
            cnt <= cnt + 1;
        end
    end

    always @(posedge clk_a or negedge rst_n) begin
        if(!rst_n) begin
            data_req <= 0;
        end
        else if(cnt == 4) begin
            data_req <= 1;
        end
        else if (data_ack_r1 & !data_ack_r2) begin
            data_req <= 0;
        end
        else begin
            data_req <= data_req;
        end
    end

endmodule

module data_receiver(
    input clk_b,
    input rst_n,
    input [3:0]data,
    input data_req,
    output reg data_ack
);
    reg [3:0] data_r;
    reg data_req_r1, data_req_r2;

    always @(posedge clk_b or negedge rst_n) begin
        if(!rst_n) begin
            data_req_r1 <= 0;
            data_req_r2 <= 0;
        end
        else begin
            data_req_r1 <= data_req;
            data_req_r2 <= data_req_r1;
        end
    end

    always @(posedge clk_b or negedge rst_n) begin
        if(!rst_n) begin
            data_ack <= 0;
        end
        else if(data_req_r1 & !data_req_r2) begin
            data_ack <= 1;
            data_r <= data;
        end
        else begin
            data_ack <= 0;
            data_r <= data_r;
        end
    end

endmodule