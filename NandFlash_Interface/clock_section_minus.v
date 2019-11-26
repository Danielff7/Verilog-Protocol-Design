`timescale 1ns/1ns
/*** CLOCK SECTION MODULE FOR BPN-SAS3-826A-N4-112		***/
/*** AUTHOR: Daniel			***/
/*** DATE:   08-11-2016						      							***/
/*** Description: This module is to generate all the necessary clocks and	***/
/***              clock enables and synced reset signals					***/
/***																		***/
/*** 2016 Super Micro Computer, Inc., ALL RIGHTS RESERVED								***/
// Module Rev:
// v0.1 - Leverage from DRB, 32k generated internally
// v0.2 - removed external 25M and 32k, generate 4k clk_en
module clock_section_minus(
	input cpld_50m_clk,
	output clk_output
	//input cpld_rst_n_50m,
	);
reg	[19:0]	count = 20'b0;


assign clk_output = count[19]; // 0.01s

always@(posedge cpld_50m_clk) begin
    count <= count+1'b1;
end
endmodule 	