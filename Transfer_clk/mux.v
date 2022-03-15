`timescale 1ns/1ns

module mux(
	input 				clk_a	, 
	input 				clk_b	,   
	input 				arstn	,
	input				brstn   ,
	input		[3:0]	data_in	,
	input               data_en ,

	output reg  [3:0] 	dataout
);

reg a_data_en, b_data_en1, b_data_en2;

always @(posedge clk_a or negedge arstn) begin
    if(!arstn) begin
        a_data_en <= 0;
    end
    else begin
        a_data_en <= data_en;
    end
end

always @(posedge clk_b or negedge brstn) begin
    if(!brstn) begin
        b_data_en1 <= 0;
        b_data_en2 <= 0;
    end
    else begin
        b_data_en1 <= a_data_en;
        b_data_en2 <= b_data_en1;
    end
end

always @(posedge clk_b or negedge brstn) begin
    if(!brstn) dataout <= 0;
    else if(b_data_en2) dataout <= data_in;
end

endmodule