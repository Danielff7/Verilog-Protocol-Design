`timescale 1 ns / 1 ns
/*** SGPIO LED FOR BPN-SAS3-F418-B6N4-R100 ***/
/*** AUTHOR: Daniel Tsai                       ***/
/*** DATE:   07-05-2017														***/
/*** Description: This module is for SGPIO interface of BPN-SAS3-F418-B6N4-R100(Using Lattice FPGA LCMXO2-1200HC-4TG100C)CPLD. ***/
/***              It contains the IO ports of CPLD. And also make the interconnection of the                       ***/
/***              lower level modules ***/
//`define max_host_dly_size 14										                                       
module sgpio_led #(parameter HDD_TYPE = 0)
	(
input rst,
//input clk,
input fault,
input active,
input locate,
input rebuild,
input clk_250ms,
input clk_500ms,
input clk_1s,
//input clk_en_1k,
output reg green_led,
output reg red_led,
input drive_present);
localparam dly_timer_5s = 30;
reg [4:0] counter;
wire [3:0] state;
reg timer_en_5s;
reg timeout_5s;
assign state = {fault,active,locate,rebuild};
always@(*) begin
case(state)
4'b0000: begin
green_led <= 1'b0;
red_led <= 1'b0;end
4'b1000: begin
if (~drive_present) begin	
green_led <= 1'b0;
red_led <= 1'b1;
end
else begin
green_led <= 1'b0;
red_led <= 1'b0;	
end
end
/*4'b0100: begin
green_led <= clk_500ms;
red_led <= clk_500ms;
end*/
4'b0010: begin
if (~drive_present) begin
green_led <= 1'b0;
red_led <= clk_250ms;
end
else begin
green_led <= 1'b0;
red_led <= 1'b0;	
end	
end
4'b0001: begin
if (~drive_present)	begin
green_led <= 1'b0;
red_led <= clk_1s;
end
else begin
green_led <= 1'b0;
red_led <= 1'b0;	
end	
end
default: begin
if (HDD_TYPE == 1) begin
if (~rst) begin
timer_en_5s <= 1'b1;
green_led <= 1'b0;
red_led <= 1'b1;
end
else begin
if (timeout_5s) begin
//timer_en_5s <= 1'b0;
green_led <= 1'b0;
red_led <= 1'b0;
end
/*else begin
if (~timer_en_5s) begin
//green_led <= 1'b0;
red_led <= 1'b0;
end
end*/	
end
end //if (HDD_TYPE == 1) begin 
else begin
if (~rst) begin
timer_en_5s <= 1'b1;
end	
else begin
if (timeout_5s) begin
green_led <= 1'b0;
red_led <= 1'b0;	
end	//if (timeout_5s) begin
else begin
green_led <= clk_1s;
red_led <= ~clk_1s;
end	
end
end	
end
endcase
end
always@(posedge clk_250ms or negedge rst) begin
if (~rst | ~timer_en_5s) begin
timeout_5s <= 1'b0;
counter <= 5'b0;
end	
else begin  
if (timer_en_5s) begin	
//if (clk_en_1k) begin
if (counter < dly_timer_5s) begin
counter <= counter + 5'b1;
timeout_5s <= 1'b0;end
else begin
timeout_5s <= 1'b1;	
end	
//end	//if (clk_en_1k) begin
end //if (timer_en_5s) begin
end
end
/*timer #(`max_host_dly_size) f_timer_inst_5s (
	.cpld_rst_n_50m	(rst),
	.cpld_50m_clk	(clk),
	.clk_en			(clk_en_1k),
	.timer_en		(timer_en_5s),
	.time_dly		(`dly_timer_5s),
	.timeout		(timeout_5s)
	);*/


endmodule