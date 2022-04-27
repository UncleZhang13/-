`timescale 1ns/1ns

module det_moore(
   input                clk   ,
   input                rst_n ,
   input                din   ,
 
   output	reg         Y   
);
reg[2:0] state, next_state;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) state <= 0;
    else state <= next_state;
end

always @(*) begin
    case(state)
    0: next_state = (din)? 1 : 0;
    1: next_state = (din)? 2 : 1;
    2: next_state = (din)? 2 : 3; 
    3: next_state = (din)? 4 : 0;
    4: next_state = 0;
    default: next_state = 0;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) Y <= 0;
    if(state == 4) Y <= 1;
    else Y <= 0;
end

endmodule