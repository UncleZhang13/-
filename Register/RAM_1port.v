
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
    reg [3:0] r_data_r[127:0];
    integer i;
always @(posedge clk or negedge rst) begin
    if(!rst) begin 
        for(i = 0; i < 127; i = i + 1)
            r_data_r[i] <= 0;
    end
    else if (enb) begin
        r_data_r[addr] <= w_data; 
    end
end

assign r_data = (!enb)? r_data_r[addr] : 0;


//*************code***********//
endmodule