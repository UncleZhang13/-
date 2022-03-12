`timescale 1ns/1ns

module s_to_p(
	input 				clk 		,   
	input 				rst_n		,
	input				valid_a		,
	input	 			data_a		,
 
 	output	reg 		ready_a		,
 	output	reg			valid_b		,
	output  reg [5:0] 	data_b
);
reg[5:0] data_b_reg;
reg[2:0] cnt;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        ready_a <= 0;
    end
    else begin
        ready_a <= 1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        cnt <= 0;
        valid_b <= 0;
    end
    else if(valid_a) begin
        if(cnt == 5) begin
            valid_b <= 1;
            cnt <= 0;
        end
        else begin
            valid_b <= 0;
            cnt <= cnt + 1;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        data_b_reg <= 0;
    end
    else if(valid_a && ready_a) begin
        data_b_reg <= {data_a, data_b_reg[5:1]};
    end
    else begin
        data_b_reg <= data_b_reg;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        data_b <= 0;
    end
    else if(cnt == 5) begin
        data_b <= {data_a, data_b_reg[5:1]};
    end
    else begin
           data_b <= data_b; 
    end
end


endmodule