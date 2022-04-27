`timescale 1ns/1ns


module mul(
    input [3:0] a,
    input [3:0] b,
    output [7:0] c
);
    wire [7:0] tmp [3:0];
    genvar i;
    generate for (i=0; i<4; i=i+1) begin
        assign tmp[i] = a[i] ? b << i : 'd0;
    end
    endgenerate
    
    assign c = tmp[0] + tmp[1] + tmp[2] + tmp[3];
    
endmodule



module calculation(
	input clk,
	input rst_n,
	input [3:0] a,
	input [3:0] b,
	output [8:0] c
	);
    
    wire [7:0] tmp0;
    wire [7:0] tmp1;
    reg  [8:0] c_r;
    
    mul mul_0 (a, 12, tmp0);
    mul mul_1 (b, 5 , tmp1);
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            c_r <= 'd0;
        end
        else begin
            c_r <= tmp0 + tmp1;
        end
    end
    assign c = c_r;
endmodule
