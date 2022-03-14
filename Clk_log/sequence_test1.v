`timescale 1ns/1ns

module sequence_test1(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//
parameter IDLE = 0,
          S1 = 1,
          S10 = 2,
          S101 = 3,
          S1011 = 4,
          S10111 = 5;
reg [5:0] state, next_state;
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        IDLE:next_state = (data)? S1:IDLE;
        S1:next_state = (data)? IDLE:S10;
        S10:next_state = (data)? S101:IDLE;
        S101:next_state = (data)? S1011:IDLE;
        S1011:next_state = (data)? S10111:IDLE;
        S10111: next_state = IDLE;
        default:next_state = IDLE;
    endcase
end

always @(posedge clk or negedge rst) begin
    if(!rst) flag <= 0;
    else if (next_state == S10111) flag <= 1;
    else flag <= 0;
end

//*************code***********//
endmodule