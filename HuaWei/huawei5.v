`timescale 1ns/1ns
module huawei5(
	input wire clk  ,
	input wire rst  ,
	input wire [3:0]d ,
	output wire valid_in ,
	output wire dout
	);

//*************code***********//
reg[1:0] cnt;
reg valid;
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        cnt <= 3;
        valid <= 0;
    end
    else if(cnt == 0) begin 
        cnt <= 3;
        valid <= 1;
    end
    else begin 
        cnt <= cnt - 1;
        valid <= 0;
    end
end

reg[3:0] d_r;
always @(posedge clk or negedge rst) begin
    if(!rst) d_r <= 0;
    else if(cnt==0) d_r <= d;
end

assign dout = d_r[cnt];
assign valid_in = valid;

//*************code***********//

endmodule