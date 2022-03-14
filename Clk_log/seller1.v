`timescale 1ns/1ns
module seller1(
	input wire clk  ,
	input wire rst  ,
	input wire d1 ,
	input wire d2 ,
	input wire d3 ,
	
	output reg out1,
	output reg [1:0]out2
);
//*************code***********//

reg [2:0] state, next_state;

always @(posedge clk or negedge rst) begin
    if(!rst) state <= 0;
    else state <= next_state;
end

always @(*) begin
    case(state)
        0: begin
            if(d1) next_state = 1;
            else if(d2) next_state = 2;
            else if(d3) next_state = 4;
            else next_state = next_state;
        end
        1: begin
            if(d1) next_state = 2;
            else if(d2) next_state = 3;
            else if(d3) next_state = 5;
            else next_state = next_state;
        end
        2: begin
            if(d1) next_state = 3;
            else if(d2) next_state = 4;
            else if(d3) next_state = 6;
            else next_state = next_state;
        end
        default: next_state = 0;
    endcase
end

    always@(posedge clk or negedge rst)begin
        if(!rst)begin
            out1 <= 0;
            out2 <= 0;
        end else begin
            case(next_state)
                3: begin out1 <= 1; out2 <= 2'b00; end 
                4: begin out1 <= 1; out2 <= 2'b01; end 
                5: begin out1 <= 1; out2 <= 2'b10; end 
                6: begin out1 <= 1; out2 <= 2'b11; end 
                default: begin out1 <=0; out2 <= 2'b00; end 
            endcase
        end
    end
//*************code***********//
endmodule