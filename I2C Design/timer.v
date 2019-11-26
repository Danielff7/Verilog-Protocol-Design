`timescale 1 ns / 1 ns
/*** TIMER MODULE FOR BPN-SAS3-815TQ-N2-100					     ***/
/*** AUTHOR: Daniel Tsai                                         ***/
/*** DATE:   11-02-2016							                 ***/
/*** Description: This module provide the general timer function ***/
/***										                     ***/
/*** 2016 Super Micro Computer, Inc., ALL RIGHTS RESERVED        ***/
module timer(
	cpld_rst_n_50m,
	cpld_50m_clk,
	clk_en,
	timer_en,
	time_dly,
	timeout	
);
parameter	size		= 5;
input			cpld_rst_n_50m;
input			cpld_50m_clk;
input			clk_en;
input			timer_en;
input[size-1:0]	time_dly;
output			timeout;
reg			    timeout;
reg	[size-1:0]	count;

always @(posedge cpld_50m_clk or negedge cpld_rst_n_50m or negedge timer_en)
  begin
    if (~cpld_rst_n_50m | ~timer_en)
      begin
        count		<= 0;
        timeout		<= 0;
      end
    else if (clk_en)
      begin
        if (count < time_dly)
          begin
            count	<= count + 4'd1;
            timeout	<= 0;
          end
        else
          begin	
            count	<= count;
            timeout	<= 1;
          end
      end
    else
      begin
        count <= count;
        timeout <= timeout;
      end
  end
endmodule
