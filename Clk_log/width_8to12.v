`timescale 1ns/1ns

module width_8to12(
	input 				   clk 		,   
	input 			      rst_n		,
	input				      valid_in	,
	input	[7:0]			   data_in	,
 
 	output  reg			   valid_out,
	output  reg [11:0]   data_out
);
reg[2:0] cnt;
reg[11:0] data_out_r;
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		cnt <= 0;
		data_out <= 0;
		valid_out <= 0;
		data_out_r <= 0;
	end
	if(valid_in) begin
		data_out_r <= data_in[7:0];
		if(cnt == 1) begin
			cnt <= 2;
			data_out <= {data_out_r, data_in[7:4]};
			valid_out <= 1;
		end
		else if(cnt == 2) begin
			cnt <= 0;
			data_out <= {data_out_r[3:0], data_in};
			valid_out <= 1;
		end
		else begin
			cnt <= cnt + 1;
			valid_out <= 0;
		end
	end
	else begin
		valid_out <= 0;
	end

end
endmodule