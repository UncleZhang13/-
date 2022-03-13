`timescale 1ns/1ns

module triffic_light
    (
		input rst_n, //异位复位信号，低电平有效
        input clk, //时钟信号
        input pass_request,
		output wire[7:0]clock,
        output reg red,
		output reg yellow,
		output reg green
    );
    parameter IDLE = 0,
              RED = 1,
              YELLOW = 2,
              GREEN = 3;

    reg p_red, p_yellow, p_green;
    reg [7:0] cnt;
    reg[1:0] state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 10;
        end
        else if(pass_request && green && (cnt > 10)) begin
            cnt <= 10;
        end
        else if (!green && p_green) begin
            cnt <= 60;
        end
        else if(!yellow && p_yellow) begin
            cnt <= 5;
        end
        else if (!red && p_red) begin
            cnt <= 10;
        end
        else begin
            cnt <= cnt - 1;
        end
    end

    assign clock = cnt;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= IDLE;
            p_green <= 0;
            p_yellow <= 0;
            p_red <= 0;
        end
        else case (state)
            IDLE: begin
                p_green <= 0;
                p_red <= 0;
                p_yellow <= 0;
                state <= RED;
            end
            RED: begin
                p_red <= 1;
                p_green <= 0;
                p_yellow <= 0;
                if(cnt == 3) begin
                    state <= YELLOW;
                end
                else begin
                    state <= RED;
                end
            end
            YELLOW: begin
                p_red <= 0;
                p_yellow <= 1;
                p_green <= 0;
                if(cnt == 3) begin
                    state <= GREEN;
                end
                else begin
                    state <= YELLOW;
                end
            end
            GREEN: begin
                p_red <= 0;
                p_yellow <= 0;
                p_green <= 1;
                if(cnt == 3) begin
                    state <= RED;
                end
                else begin
                    state <= GREEN;
                end
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            red <= 0;
            yellow <= 0;
            green <= 0;
        end
        else begin
            red <= p_red;
            green <= p_green;
            yellow <= p_yellow;
        end
    end
	
endmodule