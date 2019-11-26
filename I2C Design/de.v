/*** Debounce MODULE FOR BPN-SAS3-815TQ-N2-100								***/
/*** AUTHOR: Daniel Tsai												    ***/
/*** DATE:   11-02-2016														***/
/*** Description: Input is sampled continuously between CKE pulses			***/
/***																		***/
/*** 2016 Super Micro Computer, Inc., ALL RIGHTS RESERVED					***/
//	Module Rev:
//	v0.1 - reduced delay buffer, continuous sample and reset between CKE
//	v0.2 - hardened for "fast debounce" when CKE=1'b1

module debounce 
	(
	input clk,
	input rst, 
	input ck_enable,
	input IN,
	output reg OUT
	);
	
	reg [1:0] input_int;
	
	always@(posedge clk or negedge rst) begin
	if (~rst) begin
	input_int <= 2'b00;	
    end
	else begin
	if (ck_enable) begin
	input_int <= {input_int[0],IN};	
    end
	end	
	end
	always@(*)
	case(input_int)
	2'b00: begin
	OUT = 1'b0;	
    end
    2'b11: begin
	OUT = 1'b1;	
	end
    default: begin
	OUT = OUT;	
    end
	endcase
	endmodule 