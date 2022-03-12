`timescale 1ns/1ns
module multi_sel(
input [7:0]d ,
input clk,
input rst,
output reg input_grant,
output reg [10:0]out
);
//*************code***********//
reg [7:0] out_reg;
reg [1:0] state;
    
always @(posedge clk  or negedge rst) begin
        if(!rst)  begin
            state <= 0;
            out_reg <= 0;
            out <= 0;
            input_grant <= 0;
        end

        else  begin
            state <= state + 1;
            case (state)
                0: begin 
                        out_reg <= d;
                        out <= d;
                        input_grant <= 1;
                end
                1: begin
                    out <= (out_reg << 2) - out_reg;
                    input_grant <= 0;
                end
                2:  begin
                    out <= (out_reg << 3) - out_reg;
                    input_grant <= 0;
                end
                3: begin 
                    out <= (out_reg << 3);   
                    input_grant <= 0;
                    state <= 0;
                end
            endcase
        end
end

//*************code***********//
endmodule