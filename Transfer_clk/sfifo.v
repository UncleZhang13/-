`timescale 1ns/1ns
/**********************************RAM************************************/
module dual_port_RAM #(parameter DEPTH = 16,
					   parameter WIDTH = 8)(
	 input wclk
	,input wenc
	,input [$clog2(DEPTH)-1:0] waddr  //深度对2取对数，得到地址的位宽。
	,input [WIDTH-1:0] wdata      	//数据写入
	,input rclk
	,input renc
	,input [$clog2(DEPTH)-1:0] raddr  //深度对2取对数，得到地址的位宽。
	,output reg [WIDTH-1:0] rdata 		//数据输出
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

/*****************读写地址产生(二进制)********************/
    reg [ADDR_WIDTH:0] waddr_bin;
    reg [ADDR_WIDTH:0] raddr_bin;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) waddr_bin <= 'd0;
        else if (!wfull && winc) waddr_bin <= waddr_bin + 1'b1;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) raddr_bin <= 'd0;
        else if (!rempty && rinc) raddr_bin <= raddr_bin + 1'b1;
    end

/*****************空满判断********************/
wire [ADDR_WIDTH:0] tr_syn;
assign tr_syn = (waddr_bin[ADDR_WIDTH] == raddr_bin[ADDR_WIDTH]) ? (waddr_bin[ADDR_WIDTH:0] - raddr_bin[ADDR_WIDTH:0]) :
                                                                   (DEPTH + waddr_bin[ADDR_WIDTH-1:0] - raddr_bin[ADDR_WIDTH-1:0]);
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        wfull <= 0;
        rempty <= 0;
    end
    else if(tr_syn == 0) begin
        rempty <= 1'b1;
    end
    else if(tr_syn == DEPTH) begin
        wfull <= 1'b1;
    end
    else begin
        wfull <= 0;
        rempty <= 0;
    end
end

/*****************例化********************/
	wire [ADDR_WIDTH-1:0] waddr;
	wire [ADDR_WIDTH-1:0] raddr;
	assign waddr = waddr_bin[ADDR_WIDTH-1:0];
	assign raddr = raddr_bin[ADDR_WIDTH-1:0];

    dual_port_RAM #(
        .DEPTH ( DEPTH ),
        .WIDTH (WIDTH) )
    inst_dual_port_RAM (
        .wclk              (clk),
        .wenc              (winc & !wfull),
        .waddr             (waddr),
        .wdata             (wdata),
        .rclk              (clk),
        .renc              (rinc & !rempty),
        .raddr             (raddr),
        .rdata             (rdata)
    );

endmodule