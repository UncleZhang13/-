`timescale 1ns/1ns

module seller2(
	input wire clk  ,
	input wire rst  ,
	input wire d1 ,
	input wire d2 ,
	input wire sel ,
	
	output reg out1,
	output reg out2,
	output reg out3
);
//*************code***********//
parameter S0 = 0, 
          S1 = 1, 
          S2 = 2, 
          S3 = 3, 
          S4 = 4, 
          S5 = 5, 
          S6 = 6;

reg [3:0] state, next_state;
wire [1:0] input_state;

assign input_state = {d2, d1};

always @(posedge clk or negedge rst) begin
    if(!rst) state <= 0;
    else state <= next_state;
end

always @(*) begin
    if(!sel)
        case(state)
            S0: case(input_state)
                2'b01: next_state = S1;
                2'b10: next_state = S2;
                default: next_state = next_state; 
            endcase
            S1: case(input_state)
                2'b01: next_state = S2;
                2'b10: next_state = S3;
                default: next_state = next_state; 
            endcase
            S2: case(input_state)
                2'b01: next_state = S3;
                2'b10: next_state = S4;
                default: next_state = next_state; 
            endcase
            default: next_state = 0;
        endcase
    else begin
        case(state)
            S0: case(input_state)
                2'b01: next_state = S1;
                2'b10: next_state = S2;
                default: next_state = next_state; 
            endcase
            S1: case(input_state)
                2'b01: next_state = S2;
                2'b10: next_state = S3;
                default: next_state = next_state; 
            endcase
            S2: case(input_state)
                2'b01: next_state = S3;
                2'b10: next_state = S4;
                default: next_state = next_state; 
            endcase
            S3: case(input_state)
                2'b01: next_state = S4;
                2'b10: next_state = S5;
                default: next_state = next_state; 
            endcase
            S4: case(input_state)
                2'b01: next_state = S5;
                2'b10: next_state = S6;
                default: next_state = next_state; 
            endcase
            default: next_state = 0;
        endcase        
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        out1 <= 0;
        out2 <= 0;
        out3 <= 0;
    end
    else begin
        if(!sel) begin
            case(next_state)
            S3: begin
                out1 <= 1;
                out2 <= 0;
                out3 <= 0;
            end
            S4: begin
                out1 <= 1;
                out2 <= 0;
                out3 <= 1;
            end
            default: begin
                out1 <= 0;
                out2 <= 0;
                out3 <= 0;
            end
            endcase
        end
        else begin
            case(next_state)
            S5: begin
                out1 <= 0;
                out2 <= 1;
                out3 <= 0;
            end
            S6: begin
                out1 <= 0;
                out2 <= 1;
                out3 <= 1;
            end
            default: begin
                out1 <= 0;
                out2 <= 0;
                out3 <= 0;
            end
            endcase
        end
    end
end

//*************code***********//
endmodule