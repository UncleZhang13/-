`timescale 1ns/1ns

// 最大公倍数 * 最小公约数 = A * B

module lcm#(
parameter DATA_W = 8)
(
input [DATA_W-1:0] A,
input [DATA_W-1:0] B,
input 			vld_in,
input			rst_n,
input 			clk,
output	wire	[DATA_W*2-1:0] 	lcm_out,
output	wire 	[DATA_W-1:0]	mcd_out,
output	reg					vld_out
);
reg	[DATA_W*2-1:0]	mcd,a_buf,b_buf;
reg [DATA_W*2-1:0]	mul_buf;
reg					mcd_vld;
reg	[1:0]			cur_st,nxt_st;
parameter IDLE= 2'b00,S0 = 2'b01, S1 = 2'b10, S2 = 2'b11;
//两段式状态机
always @(posedge clk or negedge rst_n)
	if (!rst_n)
		cur_st <= IDLE;
	else
		cur_st <= nxt_st;
always @(posedge clk or negedge rst_n)
	if (!rst_n) begin
		nxt_st <= IDLE;
		mcd	  <= 0;
		mcd_vld <= 0;
		a_buf <= 0;
		b_buf <= 0;
		mul_buf <= 0;
		vld_out <= 1'b0;
	end
	else begin	
		case (cur_st)
		IDLE:if(vld_in) begin	
				a_buf <= A;
				b_buf <= B;
				nxt_st <= S0;
				mul_buf <= A*B;
				mcd_vld <= 0;
				vld_out <= 1'b0;
				end
				else begin
				nxt_st <= IDLE;
				mcd_vld <= 0;
				vld_out <= 1'b0;
				end
		S0:if(a_buf!=b_buf)begin
				if(a_buf>b_buf)begin
					a_buf<=a_buf-b_buf;
					b_buf<=b_buf;
				end
				else begin 
					b_buf <= b_buf - a_buf;
					a_buf <= a_buf;
					vld_out <= 1'b0;
				end
				nxt_st <= S0;
				end
				else begin	
					nxt_st <=S1;
					vld_out <= 1'b0;
					end
		S1:begin	
			mcd <= b_buf;
			mcd_vld <= 1'b1;
			nxt_st	<= IDLE;
			vld_out <= 1'b1;
			end
		default:begin	
			nxt_st<=IDLE;
			vld_out <= 1'b0;
			end
		endcase
	end
	
assign mcd_out = mcd;
assign lcm_out = mul_buf/mcd;
endmodule