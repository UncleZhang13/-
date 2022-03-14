`timescale 1ns/1ns

module sequence_test2(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//
parameter S0 = 0,
          S1 = 1,
          S10 = 2,
          S101 = 3,
          S1011 = 4;
reg[2:0] state, next_state;

always @(posedge clk or negedge rst) begin
    if(!rst) state <= 0;
    else state <= next_state;
end

always @(posedge clk or negedge rst) begin
    if(!rst) flag <= 0;
    else if(state == S1011) flag <= 1;
    else flag <= 0;
end

always @(*) begin
    case(state)
        S0: next_state = (data)? S1 : S0;
        S1: next_state = (data)? S1 : S10;
        S10: next_state = (data)? S101 : S0;
        S101: next_state = (data)? S1011 : S10;
        S1011: next_state = (data)? S1 : S10;
        default: next_state = S0;
    endcase
end

//*************code***********//
endmodule