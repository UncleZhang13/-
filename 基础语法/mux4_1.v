`timescale 1ns/1ns
module mux4_1(
input [1:0]d1,d2,d3,d0,
input [1:0]sel,
output[1:0]mux_out
);
//*************code***********//
    wire [1:0] line1, line2;
    assign line1 = (sel[0] == 1)? d2 : d3;
    assign line2 = (sel[0] == 1)? d0 : d1;
    assign mux_out = (sel[1] == 1)? line2 : line1;
//*************code***********//
endmodule