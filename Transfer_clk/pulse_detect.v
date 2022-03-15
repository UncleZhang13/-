`timescale 1ns/1ns

module pulse_detect(
	input 				clk_fast	, 
	input 				clk_slow	,   
	input 				rst_n		,
	input				data_in		,

	output  		 	dataout
);

reg data_in_r;
always @(posedge clk_fast or negedge rst_n) begin
	if(!rst_n) data_in_r <= 0;
	else if(data_in) data_in_r <= ~data_in_r;
	else if(!data_in) data_in_r <= data_in_r;
end

reg [2:0]dataout_r1;
always @(posedge clk_slow or negedge rst_n) begin
	if(!rst_n) dataout_r1 <= 0;
	else dataout_r1 <= {dataout_r1[1:0], data_in_r};
end

assign dataout = dataout_r1[2] ^ dataout_r1[1];

endmodule