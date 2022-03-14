`timescale 1ns/1ns

module fsm2(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);

//*************code***********//
reg[2:0] state, next_state;
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        state <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
    0:begin
        if(data) begin
            next_state <= 1;
            flag <= 0;
        end
        else begin
            next_state <= 0;
            flag <= 0;
        end
    end 
    1:begin
        if(data) begin
            next_state <= 2;
            flag <= 0;
        end
        else begin
            next_state <= 1;
            flag <= 0;
        end
    end
    2:begin
        if(data) begin
            next_state <= 3;
            flag <= 0;
        end
        else begin
            next_state <= 2;
            flag <= 0;
        end
    end 
    3:begin
        if(data) begin
            next_state <= 4;
            flag <= 0;
        end
        else begin
            next_state <= 3;
            flag <= 0;
        end
    end 
    4:begin
        if(data) begin
            next_state <= 1;
            flag <= 1;
        end
        else begin
            next_state <= 0;
            flag <= 1;
        end
    end 
    default:begin
        next_state <= 0;
        flag <= 0;
    end
    endcase
end

//*************code***********//
endmodule