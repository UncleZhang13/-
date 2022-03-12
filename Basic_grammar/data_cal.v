`timescale 1ns/1ns

module data_cal(
input clk,
input rst,
input [15:0]d,
input [1:0]sel,

output reg [4:0]out,
output reg validout
);
//*************code***********//
reg [15:0] d_reg;
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        out <= 0;
        validout <= 0;
        d_reg <= 0;
    end
    else begin
        case(sel)
            0:  begin
                out <= 5'b0;
                d_reg <= d;
                validout <= 0;
            end
            1:  begin
                out <= d_reg[3:0] + d_reg[7:4];
                validout <= 1;
            end
            2:  begin
                out <= d_reg[3:0] + d_reg[11:8];
                validout <= 1;
            end
            3:  begin
                out <= d_reg[3:0] + d_reg[15:12];
                validout <= 1;
            end
            default: begin
                out <= 5'b0;
                validout <= 0;
            end
        endcase
    end
end


//*************code***********//
endmodule