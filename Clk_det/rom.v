`timescale 1ns/1ns
module rom(
    input clk,
    input rst_n,
    input [7:0]addr,
     
    output reg [3:0]data
);
    always @ (*)
    begin
            case(addr)
                8'd0:data=4'd0;
                8'd1:data=4'd2;
                8'd2:data=4'd4;
                8'd3:data=4'd6;
                8'd4:data=4'd8;
                8'd5:data=4'd10;
                8'd6:data=4'd12;
                8'd7:data=4'd14;
                default:data=4'd0;
            endcase
    end
endmodule