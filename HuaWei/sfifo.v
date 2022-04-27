`timescale 1ns/1ns

/**********************************RAM************************************/
module dual_port_RAM #(parameter DEPTH = 16,
					   parameter WIDTH = 8)(
	 input wclk
	,input wenc
	,input [$clog2(DEPTH)-1:0] waddr  
	,input [WIDTH-1:0] wdata      	
	,input rclk
	,input renc
	,input [$clog2(DEPTH)-1:0] raddr  
	,output reg [WIDTH-1:0] rdata 		
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) begin
	if(wenc)
		RAM_MEM[waddr] <= wdata;
end 

always @(posedge rclk) begin
	if(renc)
		rdata <= RAM_MEM[raddr];
end 

endmodule  

/**********************************SFIFO************************************/
module sfifo#(
	parameter	WIDTH = 8,
	parameter 	DEPTH = 16
)(
	input 					clk		, 
	input 					rst_n	,
	input 					winc	,
	input 			 		rinc	,
	input 		[WIDTH-1:0]	wdata	,

	output reg				wfull	,
	output reg				rempty	,
	output wire [WIDTH-1:0]	rdata
);

parameter ADDR_WIDTH = $clog2(DEPTH);
reg [ADDR_WIDTH:0] waddr, raddr;
wire wen;
wire ren;

assign wen = winc & !wfull;
assign ren = rinc & !rempty;

wire [ADDR_WIDTH:0] cnt;

assign cnt = (waddr[ADDR_WIDTH] == raddr[ADDR_WIDTH])? (waddr[ADDR_WIDTH:0] - raddr[ADDR_WIDTH:0]):
                                                       (DEPTH + waddr[ADDR_WIDTH-1:0] - raddr[ADDR_WIDTH-1:0]);
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        wfull <= 0;
        rempty <= 0;
    end
    else if(cnt == 0) begin
        rempty <= 1;
        wfull <= 0;
    end
    else if(cnt == DEPTH) begin
        rempty <= 0;
        wfull <= 1;
    end
    else begin
        rempty <= 0;
        wfull <= 0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) waddr <= 0;
    else if (winc & (~wfull)) waddr <= waddr + 1;
    else waddr <= waddr; 
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) raddr <= 0;
    else if (rinc & (~rempty)) raddr <= raddr + 1;
    else raddr <= raddr; 
end

dual_port_RAM #(.DEPTH(DEPTH),
                .WIDTH(WIDTH)
)dual_port_RAM(
    .wclk (clk),  
    .wenc (wen),  
    .waddr(waddr[ADDR_WIDTH-1:0]), 
    .wdata(wdata),         
    .rclk (clk), 
    .renc (ren), 
    .raddr(raddr[ADDR_WIDTH-1:0]),  
    .rdata(rdata)         
);

endmodule