`timescale 1ns/1ns
module signal_generator(
	input clk,
	input rst_n,
	input [1:0] wave_choise,
	output reg [4:0]wave
	);

    reg [4:0]cnt;
    reg up;

always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            wave <= 0;
            cnt <= 0;
        end
        else begin
            case (wave_choise)
                2'b00:begin
                    if(cnt == 19) begin
                        cnt <= 0;
                        wave <= 0;
                    end
                    else if(cnt == 9) begin
                        cnt <= cnt + 1;
                        wave <= 20;
                    end
                    else begin
                        cnt <= cnt +1;
                        wave <= 0;
                    end
                end
                2'b01:begin
                    if(wave == 20)  begin
                        wave <= 0;
                    end
                    else begin
                        wave <= wave + 1;
                    end
                end
                2'b10: begin
                    if(wave == 20) begin
                        wave <= wave - 2;
                        up <= 0;
                    end
                    else if (wave == 0) begin
                        wave <= wave - 1;
                        up <= 1;
                    end
                    else if (up) begin
                        wave <= wave + 1;
                    end
                    else begin
                        wave <= wave - 1;
                    end
                end
                default: begin
                    wave <= 0;
                    cnt <= 0;
                end 
            endcase        
        end
    end
  
endmodule