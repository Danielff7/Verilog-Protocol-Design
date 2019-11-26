module reset_delitch(
input rst,
input pe_rst,
input clk,
output rst_delitch,
output pe_rst_deglitch
);

reg rst_delay1;
reg rst_delay2;
reg pe_rst_delay1;
reg pe_rst_delay2;
always@(posedge clk) begin
	rst_delay1 <= rst;
	rst_delay2 <= rst_delay1;
	pe_rst_delay1 <= pe_rst;
	pe_rst_delay2 <= pe_rst_delay1;
	end
assign rst_delitch = rst | rst_delay1 | rst_delay2;	
assign pe_rst_deglitch = pe_rst | pe_rst_delay1 | pe_rst_delay2;	
endmodule 
