`timescale 1ns/1ns

module width_24to128(
	input 				clk 		,   
	input 				rst_n		,
	input				valid_in	,
	input	[23:0]		data_in		,
 
 	output	reg			valid_out	,
	output  reg [127:0]	data_out
);

    reg [3:0] cnt;
    reg [127:0] data;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        valid_out <= 0;
        data_out <= 0;
        cnt <= 0;
    end
    else if (valid_in) begin
        if (cnt==5) begin 			//第一组24+24+24+24+24+8
            cnt <= 6;
            data_out <= {data[119:0], data_in[23:16]};
            data <= data_in[15:0];  //保存第六组的后16位，在下一次移位使用
            valid_out <= 1;
        end
        else if (cnt==10) begin		//第二组16+24+24+24+24+16
            cnt <= 11;
            data_out <= {data[111:0], data_in[23:8]};
            data <= data_in[7:0];   //保存第十一组的后8位，在下一次移位使用
            valid_out <= 1;
        end
        else if (cnt==15) begin		//第二组8+24+24+24+24+24
            cnt <= 0;
            data_out <= {data[103:0], data_in[23:0]};
            valid_out <= 1;
        end
        else begin					//正常移位操作
            cnt <= cnt+1;
            data <= {data[95:0], data_in[23:0]};
            valid_out <= 0;
        end
    end
    else
        valid_out <= 0;
end

endmodule