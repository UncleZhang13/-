`timescale 1ns/1ns

module valid_ready(
	input 				clk 		,   
	input 				rst_n		,
	input		[7:0]	data_in		,
	input				valid_a		,
	input	 			ready_b		,
 
 	output		 		ready_a		,
 	output	reg			valid_b		,
	output  reg [9:0] 	data_out
);

reg [2:0] cnt;
wire add_cnt, end_cnt;

    assign ready_a = (~valid_b) | ready_b;
    assign add_cnt = valid_a && ready_a;
    assign end_cnt = valid_a && ready_a && (cnt == 3);


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 0;
        end
        else if (end_cnt) begin
            cnt <= 0;
        end
        else if(add_cnt) begin
            cnt <= cnt + 1;
        end
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            valid_b <= 0;
        end
        else if (end_cnt) begin
            valid_b <= 1;
        end
        else if(ready_b) begin
            valid_b <= 0;
        end
        else begin
            valid_b <= valid_b;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            data_out <= 0;
        end
        else if(add_cnt && cnt == 0) begin
            data_out <= data_in;
        end
        else if (add_cnt) begin
            data_out <= data_out + data_in;
        end
        else begin
            data_out <= data_out;
        end
    end



endmodule