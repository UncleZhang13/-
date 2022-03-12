`timescale 1ns/1ns
module odd_sel(
input [31:0] bus,
input sel,
output check
);
//*************code***********//
wire singal, odd;
    assign singal = ~^bus;
    assign odd = ^bus;
    assign check = (sel)? odd : singal;
//*************code***********//
endmodule