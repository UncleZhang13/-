`timescale 1ns/1ns

module sale(
   input                clk   ,
   input                rst_n ,
   input                sel   ,//sel=0,5$dranks,sel=1,10&=$drinks
   input          [1:0] din   ,//din=1,input 5$,din=2,input 10$
 
   output   reg  [1:0] drinks_out,//drinks_out=1,output 5$ drinks,drinks_out=2,output 10$ drinks
   output	reg        change_out   
);
reg [1:0] state, next_state;
parameter IDLE = 0, S1 = 1, S2 = 2, S3 = 3;
wire [2:0] mode = {din, sel};


always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        IDLE: begin
            if(din == 1) next_state = S1;
            else if(din ==  2) next_state = S2;
            else next_state = IDLE;
        end
        S1: case(mode)
            3'b000: next_state = IDLE;
            3'b010: next_state = S1;
            3'b100: next_state = S2;
            3'b001: next_state = S1;
            3'b011: next_state = S2;
            3'b101: next_state = S3;
            default: next_state = IDLE;
        endcase
        S2: case(mode)
            3'b000: next_state = IDLE;
            3'b010: next_state = S1;
            3'b100: next_state = S2;
            3'b001: next_state = IDLE;
            3'b011: next_state = S1;
            3'b101: next_state = S2;
            default: next_state = IDLE;
        endcase
        S3: case(mode)
            3'b000: next_state = IDLE;
            3'b010: next_state = S1;
            3'b100: next_state = S2;
            3'b001: next_state = IDLE;
            3'b011: next_state = S1;
            3'b101: next_state = S2;
            default: next_state = IDLE;
        endcase
    default: next_state = IDLE;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        drinks_out <= 0;
    end
    else if (sel==0) begin
        if(state==IDLE&(din==1 || din==2)) drinks_out <= 1;
        else if(state==S1&(din==1 || din==2)) drinks_out <= 1;
        else if(state==S2&(din==1 || din==2)) drinks_out <= 1;
        else if(state==S3&(din==1 || din==2)) drinks_out <= 1;
        else drinks_out <= 0;
    end
    else if (sel==1) begin
        if(state==IDLE&(din==2)) drinks_out <= 2;
        else if(state==S1&(din==1 || din==2)) drinks_out <= 2;
        else if(state==S2&(din==2)) drinks_out <= 2;
        else if(state==S3&(din==2)) drinks_out <= 2;
        else drinks_out <= 0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        change_out <= 0;
    end
    else if (sel==0) begin
        if(state==IDLE&(din==2)) change_out <= 1;
        else if(state==S1&(din==2)) change_out <= 1;
        else if(state==S2&(din==2)) change_out <= 1;
        else if(state==S3&(din==2)) change_out <= 1;
        else change_out <= 0;
    end
    else if (sel==1) begin
        if(state==S1&(din==2)) change_out <= 1;
        else change_out <= 0;
    end
    else change_out <= 0;
end

endmodule