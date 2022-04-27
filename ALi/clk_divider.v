`timescale 1ns/1ns

module clk_divider
    #(parameter dividor = 5)
( 	input clk_in,
	input rst_n,
	output clk_out
);
    reg [$clog2(dividor)-1'b1 : 0] cnt;
    reg clk1, clk2;
    
    always@(posedge clk_in or negedge rst_n)
        if(!rst_n)
            cnt <= 'b0;
        else if(cnt == dividor-1'b1)
            cnt <= 'b0;
        else
            cnt <= cnt + 1'b1;
    
    always@(posedge clk_in or negedge rst_n)
        if(!rst_n)
            clk1 <= 1'b0;
        else if(cnt == dividor-1'b1)
            clk1 <= 1'b0;
        else if(cnt == dividor >> 1'b1)
            clk1 <= 1'b1;
        else
            clk1 <= clk1;
    
    always@(negedge clk_in or negedge rst_n)
        if(!rst_n)
            clk2 <= 1'b0;
        else if(cnt == dividor-1'b1)
            clk2 <= 1'b0;
        else if(cnt == dividor >> 1'b1)
            clk2 <= 1'b1;
        else
            clk2 <= clk2;
    
    assign clk_out = clk1 | clk2;
    
endmodule
