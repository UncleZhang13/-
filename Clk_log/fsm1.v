`timescale 1ns/1ns

module fsm1(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//
reg[1:0] state, next_state;

always @(posedge clk or negedge rst) begin
    if(!rst) state <= 0;
    else state <= next_state;
end

always @(*) begin
    case(state)
    0: next_state <= (data)? 1 : 0;
    1: next_state <= (data)? 2 : 1;
    2: next_state <= (data)? 3 : 2;
    3: next_state <= (data)? 0 : 3;
    endcase
end

always @(posedge clk or negedge rst) begin
    if (!rst) flag <= 0;
    else if ((state == 3) && (data)) flag <= 1;
    else flag <= 0;
end

//*************code***********//
endmodule