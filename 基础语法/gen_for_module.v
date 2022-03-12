`timescale 1ns/1ns
module gen_for_module( 
    input [7:0] data_in,
    output [7:0] data_out
);    
genvar i;
generate

    for(i = 0; i <= 7; i = i + 1) begin : assign_action
        assign data_out[i] = data_in[7 - i];
    end
endgenerate
 
endmodule

