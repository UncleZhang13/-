`timescale 100ps/100ps

module pulse_detect(
	input 				clka	, 
	input 				clkb	,   
	input 				rst_n		,
	input				sig_a		,

	output  		 	sig_b
);
reg Q_sig_a;
always @(posedge clka or negedge rst_n) begin
    if(!rst_n) Q_sig_a <= 0;
    else if(sig_a) Q_sig_a <= ~Q_sig_a;
    else if(!sig_a) Q_sig_a <= Q_sig_a; 
end

reg Q_sig_b1;
always @(posedge clkb or negedge rst_n) begin
    if(!rst_n) Q_sig_b1 <= 0;
    else Q_sig_b1 <= Q_sig_a;
end

reg Q_sig_b2;
always @(posedge clkb or negedge rst_n) begin
    if(!rst_n) Q_sig_b2 <= 0;
    else Q_sig_b2 <= Q_sig_b1;
end


reg Q_sig_b3;
always @(posedge clkb or negedge rst_n) begin
    if(!rst_n) Q_sig_b3 <= 0;
    else Q_sig_b3 <= Q_sig_b2;
end
    
assign sig_b = Q_sig_b2 ^ Q_sig_b3;

endmodule