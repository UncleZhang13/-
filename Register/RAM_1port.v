
`timescale 1ns/1ns


module RAM_1port(
    input clk,
    input rst,
    input enb,
    input [6:0]addr,
    input [3:0]w_data,
    output wire [3:0]r_data
);
//*************code***********//
    reg [3:0] r_data_r;

always @(posedge clk or negedge rst) begin
    if(!rst) begin 
        
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        
    end
end

//*************code***********//
endmodule