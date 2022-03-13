`timescale 1ns/1ns

module multi_pipe#(
	parameter size = 4
)(
	input 						clk 		,   
	input 						rst_n		,
	input	[size-1:0]			mul_a		,
	input	[size-1:0]			mul_b		,
 
 	output	reg	[size*2-1:0]	mul_out		
);
    reg [size*2-1:0]    mul_out1, mul_out2;
    wire [size-1:0]     mul_0, mul_1, mul_2, mul_3;

    assign mul_0 = (mul_b[0])? mul_a : 0;
    assign mul_1 = (mul_b[1])? mul_a : 0;
    assign mul_2 = (mul_b[2])? mul_a : 0;
    assign mul_3 = (mul_b[3])? mul_a : 0;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            mul_out1 <= 0;
            mul_out2 <= 0;
            mul_out <= 0;
        end
        else begin
            mul_out1 <= {4'b0, mul_0} + {3'b0, mul_1, 1'b0};
            mul_out2 <= {2'b0, mul_2, 2'b0} + {1'b0};
            mul_out <= mul_out1 + mul_out2;
        end
    end

endmodule