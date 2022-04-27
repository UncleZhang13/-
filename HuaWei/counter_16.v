`timescale 1ns/1ns

module counter_16(
   input                clk   ,
   input                rst_n ,
 
   output   reg  [3:0]  Q      
);

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        Q <= 0;
    end
    else if (Q == 15) begin
        Q <= 0;
    end
    else begin
        Q <= Q + 1;
    end
end


endmodule