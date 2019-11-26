`timescale 1 ns / 1 ns
/*** SYNC MODULE FOR BPN-SAS3-815TQ-N2-100				        ***/
/*** AUTHOR: Daniel Tsai							            ***/
/*** DATE:   11-02-2016								            ***/
/*** Description: This module used to sync signals between      ***/
/***              2 clock domains. GSR enabled		            ***/
/***										                    ***/
/*** 2016 Super Micro Computer, Inc., ALL RIGHTS RESERVED		***/
module sync (	
	data_in,
	data_out,
	sync_clk,
	sync_clk_en,
	sync_rst_n
); 
input		data_in;
output		data_out;
input		sync_clk;
input		sync_clk_en;
input		sync_rst_n;	
reg[1:0]	data_sync; 

always @ (posedge sync_clk or negedge sync_rst_n)
  begin
    if (~sync_rst_n)
      data_sync <= 2'b0;	
    else if (sync_clk_en)
      begin
        data_sync[1]	<= data_sync[0];
        data_sync[0]	<= data_in;
      end
  end
  
assign data_out = data_sync[1];
endmodule
