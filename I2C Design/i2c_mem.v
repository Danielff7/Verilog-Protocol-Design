`timescale 1 ns / 1 ns
/*** I2C Memory Map MODULE FOR BPN-SAS3-815TQ-N2-100	***/
/*** AUTHOR: Daniel Tsai											    ***/
/*** DATE:   10-24-2016														***/
/*** Description: This module provides the CPLD BMC memory map              ***/
/***										                                ***/
/*** 2016 Super Micro Computer, Inc., ALL RIGHTS RESERVED					            ***/
/****** state machine define          *******/
`define I2C_ST_DATA 3'h3
`define I2C_ST_ACK 3'h5
`define I2C_ST_CMD 3'h4
module i2c_mem(
//input scl_in,
output reg [7:0] rd_lock_data,
input [7:0] data_out,
input r_w,
input [2:0] sm_state,
input [2:0] pre_sm_state,
input rst_sync_clk,
input cpld_internal_clk,
input NVMe_1_PRESENT,
input NVMe_2_PRESENT,
input NVMe_3_PRESENT,
input NVMe_4_PRESENT,
input NVMe_5_PRESENT,
input NVMe_6_PRESENT,
input NVMe_7_PRESENT,
input NVMe_8_PRESENT,
input NVMe_9_PRESENT,
input NVMe_10_PRESENT,
input NVMe_11_PRESENT,
input NVMe_12_PRESENT,
input clk_250ms,
input clk_500ms,
input clk_1s,
input clk_500,
output reg NVMe1_LED_R,
output reg NVMe1_LED_G,
output reg NVMe2_LED_R,
output reg NVMe2_LED_G,
output reg NVMe3_LED_R,
output reg NVMe3_LED_G,
output reg NVMe4_LED_R,
output reg NVMe4_LED_G,
output reg NVMe5_LED_R,
output reg NVMe5_LED_G,
output reg NVMe6_LED_R,
output reg NVMe6_LED_G,
output reg NVMe7_LED_R,
output reg NVMe7_LED_G,
output reg NVMe8_LED_R,
output reg NVMe8_LED_G,
output reg NVMe9_LED_R,
output reg NVMe9_LED_G,
output reg NVMe10_LED_R,
output reg NVMe10_LED_G,
output reg NVMe11_LED_R,
output reg NVMe11_LED_G,
output reg NVMe12_LED_R,
output reg NVMe12_LED_G,
//input [6:0] I2C_SLAVE_ADDR,
input clk_en_1k,
//input [6:0] I2C_SLAVE_ADDRESS1,
input clk_3hz,
output reg [7:0] Enable_disable_VMD1,
output reg [7:0] Enable_disable_VMD2,
//input ATNLED_port0,
input PWRLED_port0,
//input ATNLED_port1,
input PWRLED_port1,
//input ATNLED_port2,
input PWRLED_port2,
//input ATNLED_port3,
input PWRLED_port3,
input PWRLED_port4,
input PWRLED_port5,
input PWRLED_port6,
input PWRLED_port7,
input PWRLED_port8,
input PWRLED_port9,
input PWRLED_port10,
input PWRLED_port11,
input PWREN_N_port0,
input PWREN_N_port1,
input PWREN_N_port2,
input PWREN_N_port3,
input PWREN_N_port4,
input PWREN_N_port5,
input PWREN_N_port6,
input PWREN_N_port7,
input PWREN_N_port8,
input PWREN_N_port9,
input PWREN_N_port10,
input PWREN_N_port11,
output reg [11:0] button,
output reg [11:0] STR,
output reg switch1_enable_control,
output reg switch2_enable_control,
output reg switch3_enable_control,
output reg switch4_enable_control,
output reg switch5_enable_control,
output reg switch6_enable_control,
output reg switch7_enable_control,
output reg switch8_enable_control,
output reg switch9_enable_control,
output reg switch10_enable_control,
output reg switch11_enable_control,
output reg switch12_enable_control,
output reg [15:0] pwd
);
/********** read_write address register **********/
reg [7:0] mem_address_hold_write_read;
//reg [1:0] scl_in_int;
//reg scl_neg_pulse;
//reg scl_pos_pulse;
/********** scl delay timing register **********/
//reg [7:0] rd_lock_data;
//reg [7:0] Enable_disable_VMD;
//reg [3:0] STR;
/********** NVMe Register **********/
reg [1:0] NVMe_1_PRESENT_REG;
reg [1:0] NVMe_2_PRESENT_REG;
reg [1:0] NVMe_3_PRESENT_REG;
reg [1:0] NVMe_4_PRESENT_REG;
reg [1:0] NVMe_5_PRESENT_REG;
reg [1:0] NVMe_6_PRESENT_REG;
reg [1:0] NVMe_7_PRESENT_REG;
reg [1:0] NVMe_8_PRESENT_REG;
reg [1:0] NVMe_9_PRESENT_REG;
reg [1:0] NVMe_10_PRESENT_REG;
reg [1:0] NVMe_11_PRESENT_REG;
reg [1:0] NVMe_12_PRESENT_REG;
reg NVMe1_auto_clear;
reg NVMe2_auto_clear;
reg NVMe3_auto_clear;
reg NVMe4_auto_clear;
reg NVMe5_auto_clear;
reg NVMe6_auto_clear;
reg NVMe7_auto_clear;
reg NVMe8_auto_clear;
reg NVMe9_auto_clear;
reg NVMe10_auto_clear;
reg NVMe11_auto_clear;
reg NVMe12_auto_clear;
reg [3:0] NVMe1_Function_ID;
reg [3:0] NVMe2_Function_ID;
reg [3:0] NVMe3_Function_ID;
reg [3:0] NVMe4_Function_ID;
reg [3:0] NVMe5_Function_ID;
reg [3:0] NVMe6_Function_ID;
reg [3:0] NVMe7_Function_ID;
reg [3:0] NVMe8_Function_ID;
reg [3:0] NVMe9_Function_ID;
reg [3:0] NVMe10_Function_ID;
reg [3:0] NVMe11_Function_ID;
reg [3:0] NVMe12_Function_ID;
/*reg [3:0] button_assert;
reg [3:0] button_deassert;*/
reg [11:0] five_zero_happen;
//reg [1:0] timer_enable_nvme; //20180709
//wire [1:0] time_out_nvme;
/********** NVMe LED Control Wire **********/
wire [2:0] NVMe1_LED_BEHAVIOR;
wire [2:0] NVMe2_LED_BEHAVIOR;
wire [2:0] NVMe3_LED_BEHAVIOR;
wire [2:0] NVMe4_LED_BEHAVIOR;
wire [2:0] NVMe5_LED_BEHAVIOR;
wire [2:0] NVMe6_LED_BEHAVIOR;
wire [2:0] NVMe7_LED_BEHAVIOR;
wire [2:0] NVMe8_LED_BEHAVIOR;
wire [2:0] NVMe9_LED_BEHAVIOR;
wire [2:0] NVMe10_LED_BEHAVIOR;
wire [2:0] NVMe11_LED_BEHAVIOR;
wire [2:0] NVMe12_LED_BEHAVIOR;
//assign data_in = (scl_neg_pulse && sm_state == `I2C_ST_ACK && r_w) ? rd_lock_data: data_in;
/********** NVMe LED Behavior assignment **********/
assign NVMe1_LED_BEHAVIOR = (~rst_sync_clk | NVMe_1_PRESENT) ? 3'b000: ((NVMe1_Function_ID[0]) ? NVMe1_Function_ID[3:1]: NVMe1_LED_BEHAVIOR); 
assign NVMe2_LED_BEHAVIOR = (~rst_sync_clk | NVMe_2_PRESENT) ? 3'b000: ((NVMe2_Function_ID[0]) ? NVMe2_Function_ID[3:1]: NVMe2_LED_BEHAVIOR); 
assign NVMe3_LED_BEHAVIOR = (~rst_sync_clk | NVMe_3_PRESENT) ? 3'b000: ((NVMe3_Function_ID[0]) ? NVMe3_Function_ID[3:1]: NVMe3_LED_BEHAVIOR); 
assign NVMe4_LED_BEHAVIOR = (~rst_sync_clk | NVMe_4_PRESENT) ? 3'b000: ((NVMe4_Function_ID[0]) ? NVMe4_Function_ID[3:1]: NVMe4_LED_BEHAVIOR);
assign NVMe5_LED_BEHAVIOR = (~rst_sync_clk | NVMe_5_PRESENT) ? 3'b000: ((NVMe5_Function_ID[0]) ? NVMe5_Function_ID[3:1]: NVMe5_LED_BEHAVIOR); 
assign NVMe6_LED_BEHAVIOR = (~rst_sync_clk | NVMe_6_PRESENT) ? 3'b000: ((NVMe6_Function_ID[0]) ? NVMe6_Function_ID[3:1]: NVMe6_LED_BEHAVIOR); 
assign NVMe7_LED_BEHAVIOR = (~rst_sync_clk | NVMe_7_PRESENT) ? 3'b000: ((NVMe7_Function_ID[0]) ? NVMe7_Function_ID[3:1]: NVMe7_LED_BEHAVIOR); 
assign NVMe8_LED_BEHAVIOR = (~rst_sync_clk | NVMe_8_PRESENT) ? 3'b000: ((NVMe8_Function_ID[0]) ? NVMe8_Function_ID[3:1]: NVMe8_LED_BEHAVIOR);
assign NVMe9_LED_BEHAVIOR = (~rst_sync_clk | NVMe_9_PRESENT) ? 3'b000: ((NVMe9_Function_ID[0]) ? NVMe9_Function_ID[3:1]: NVMe9_LED_BEHAVIOR);
assign NVMe10_LED_BEHAVIOR = (~rst_sync_clk | NVMe_10_PRESENT) ? 3'b000: ((NVMe10_Function_ID[0]) ? NVMe10_Function_ID[3:1]: NVMe10_LED_BEHAVIOR);
assign NVMe11_LED_BEHAVIOR = (~rst_sync_clk | NVMe_11_PRESENT) ? 3'b000: ((NVMe11_Function_ID[0]) ? NVMe11_Function_ID[3:1]: NVMe11_LED_BEHAVIOR);
assign NVMe12_LED_BEHAVIOR = (~rst_sync_clk | NVMe_12_PRESENT) ? 3'b000: ((NVMe12_Function_ID[0]) ? NVMe12_Function_ID[3:1]: NVMe12_LED_BEHAVIOR);
/**********register mem_address_hold write**********/
always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk)
begin 
mem_address_hold_write_read <= 8'b0;
NVMe1_Function_ID <= 4'b0;
NVMe2_Function_ID <= 4'b0;
NVMe3_Function_ID <= 4'b0;
NVMe4_Function_ID <= 4'b0;
NVMe5_Function_ID <= 4'b0;
NVMe6_Function_ID <= 4'b0;
NVMe7_Function_ID <= 4'b0;
NVMe8_Function_ID <= 4'b0;
NVMe9_Function_ID <= 4'b0;
NVMe10_Function_ID <= 4'b0;
NVMe11_Function_ID <= 4'b0;
NVMe12_Function_ID <= 4'b0;
NVMe1_auto_clear <= 1'b1;
NVMe2_auto_clear <= 1'b1;
NVMe3_auto_clear <= 1'b1;
NVMe4_auto_clear <= 1'b1;
NVMe5_auto_clear <= 1'b1;
NVMe6_auto_clear <= 1'b1;
NVMe7_auto_clear <= 1'b1;
NVMe8_auto_clear <= 1'b1;
NVMe9_auto_clear <= 1'b1;
NVMe10_auto_clear <= 1'b1;
NVMe11_auto_clear <= 1'b1;
NVMe12_auto_clear <= 1'b1;
Enable_disable_VMD1 <= 8'h00;
Enable_disable_VMD2 <= 8'h00;
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;
pwd <= 16'b0;
end 
else begin
//if (I2C_SLAVE_ADDR == I2C_SLAVE_ADDRESS1) begin 
if (sm_state == `I2C_ST_ACK && !r_w && pre_sm_state == `I2C_ST_CMD) begin
mem_address_hold_write_read <= data_out;
if (mem_address_hold_write_read == 8'h40) begin
switch1_enable_control <= 1'b1;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;
end	
else if (mem_address_hold_write_read == 8'h41) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b1;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;
end	
else if (mem_address_hold_write_read == 8'h42) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b1;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;	
end	
else if (mem_address_hold_write_read == 8'h43) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b1;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;	
end	
else if (mem_address_hold_write_read == 8'h44) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b1;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;	
end
else if (mem_address_hold_write_read == 8'h45) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b1;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;	
end 
else if (mem_address_hold_write_read == 8'h46) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b1;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;	
end
else if (mem_address_hold_write_read == 8'h47) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b1;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;	
end
else if (mem_address_hold_write_read == 8'h48) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b1;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;	
end
else if (mem_address_hold_write_read == 8'h49) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b1;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b0;	
end
else if (mem_address_hold_write_read == 8'h4A) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b1;
switch12_enable_control <= 1'b0;	
end
else if (mem_address_hold_write_read == 8'h4B) begin
switch1_enable_control <= 1'b0;
switch2_enable_control <= 1'b0;
switch3_enable_control <= 1'b0;
switch4_enable_control <= 1'b0;
switch5_enable_control <= 1'b0;
switch6_enable_control <= 1'b0;
switch7_enable_control <= 1'b0;
switch8_enable_control <= 1'b0;
switch9_enable_control <= 1'b0;
switch10_enable_control <= 1'b0;
switch11_enable_control <= 1'b0;
switch12_enable_control <= 1'b1;	
endend 
else if (sm_state == `I2C_ST_ACK && !r_w && pre_sm_state == `I2C_ST_DATA) begin 
      case(mem_address_hold_write_read)
	  8'h08: begin
             Enable_disable_VMD1[7] <= data_out[7];
			 Enable_disable_VMD1[6] <= data_out[6];
			 Enable_disable_VMD1[5] <= data_out[5];
			 Enable_disable_VMD1[4] <= data_out[4];
			 Enable_disable_VMD1[3] <= data_out[3];
			 Enable_disable_VMD1[2] <= data_out[2];
			 Enable_disable_VMD1[1] <= data_out[1];
			 Enable_disable_VMD1[0] <= data_out[0];
             end
	  8'h09: begin
		     Enable_disable_VMD2[7] <= data_out[7];
             Enable_disable_VMD2[6] <= data_out[6];
			 Enable_disable_VMD2[5] <= data_out[5];
			 Enable_disable_VMD2[4] <= data_out[4];
			 Enable_disable_VMD2[3] <= data_out[3];
			 Enable_disable_VMD2[2] <= data_out[2];
			 Enable_disable_VMD2[1] <= data_out[1];
			 Enable_disable_VMD2[0] <= data_out[0];
             end
      8'h50: begin		  
		     NVMe1_auto_clear <= data_out[6];
             NVMe1_Function_ID[3] <= data_out[2];
             NVMe1_Function_ID[2] <= data_out[1];
             NVMe1_Function_ID[1] <= data_out[0];
             NVMe1_Function_ID[0] <= (NVMe1_auto_clear) ? NVMe1_Function_ID[0]: 1'b1;	 
             end
      8'h51: begin
		     NVMe2_auto_clear <= data_out[6];
             NVMe2_Function_ID[3] <= data_out[2];
             NVMe2_Function_ID[2] <= data_out[1];
             NVMe2_Function_ID[1] <= data_out[0];
             NVMe2_Function_ID[0] <= (NVMe2_auto_clear) ? NVMe2_Function_ID[0]: 1'b1;                  
			 end 
      8'h52: begin 
		     NVMe3_auto_clear <= data_out[6];
             NVMe3_Function_ID[3] <= data_out[2];
             NVMe3_Function_ID[2] <= data_out[1];
             NVMe3_Function_ID[1] <= data_out[0];
             NVMe3_Function_ID[0] <= (NVMe3_auto_clear) ? NVMe3_Function_ID[0]: 1'b1;
             end 
      8'h53: begin
		     NVMe4_auto_clear <= data_out[6];
             NVMe4_Function_ID[3] <= data_out[2];
             NVMe4_Function_ID[2] <= data_out[1];
             NVMe4_Function_ID[1] <= data_out[0];
             NVMe4_Function_ID[0] <= (NVMe4_auto_clear) ? NVMe4_Function_ID[0]: 1'b1;
             end
	  8'h54: begin
		     NVMe5_auto_clear <= data_out[6];
		     NVMe5_Function_ID[3] <= data_out[2];
			 NVMe5_Function_ID[2] <= data_out[1];
			 NVMe5_Function_ID[1] <= data_out[0];
			 NVMe5_Function_ID[0] <= (NVMe5_auto_clear) ? NVMe5_Function_ID[0]: 1'b1;
		     end 
	  8'h55: begin
		     NVMe6_auto_clear <= data_out[6];
		     NVMe6_Function_ID[3] <= data_out[2];
			 NVMe6_Function_ID[2] <= data_out[1];
			 NVMe6_Function_ID[1] <= data_out[0];
			 NVMe6_Function_ID[0] <= (NVMe6_auto_clear) ? NVMe6_Function_ID[0]: 1'b1;		 
			 end
      8'h56: begin
             NVMe7_auto_clear <= data_out[6];
		     NVMe7_Function_ID[3] <= data_out[2];
			 NVMe7_Function_ID[2] <= data_out[1];
			 NVMe7_Function_ID[1] <= data_out[0];
			 NVMe7_Function_ID[0] <= (NVMe7_auto_clear) ? NVMe7_Function_ID[0]: 1'b1;
             end 
	  8'h57: begin
             NVMe8_auto_clear <= data_out[6];
		     NVMe8_Function_ID[3] <= data_out[2];
			 NVMe8_Function_ID[2] <= data_out[1];
			 NVMe8_Function_ID[1] <= data_out[0];
			 NVMe8_Function_ID[0] <= (NVMe8_auto_clear) ? NVMe8_Function_ID[0]: 1'b1;
             end 
	  8'h58: begin
             NVMe9_auto_clear <= data_out[6];
		     NVMe9_Function_ID[3] <= data_out[2];
			 NVMe9_Function_ID[2] <= data_out[1];
			 NVMe9_Function_ID[1] <= data_out[0];
			 NVMe9_Function_ID[0] <= (NVMe9_auto_clear) ? NVMe9_Function_ID[0]: 1'b1;
             end 
	  8'h59: begin
		     NVMe10_auto_clear <= data_out[6];
		     NVMe10_Function_ID[3] <= data_out[2];
			 NVMe10_Function_ID[2] <= data_out[1];
			 NVMe10_Function_ID[1] <= data_out[0];
			 NVMe10_Function_ID[0] <= (NVMe10_auto_clear) ? NVMe10_Function_ID[0]: 1'b1;
             end 
	  8'h5A: begin
		     NVMe11_auto_clear <= data_out[6];
		     NVMe11_Function_ID[3] <= data_out[2];
			 NVMe11_Function_ID[2] <= data_out[1];
			 NVMe11_Function_ID[1] <= data_out[0];
			 NVMe11_Function_ID[0] <= (NVMe11_auto_clear) ? NVMe11_Function_ID[0]: 1'b1;
		     end 
	  8'h5B: begin
             NVMe12_auto_clear <= data_out[6];
		     NVMe12_Function_ID[3] <= data_out[2];
			 NVMe12_Function_ID[2] <= data_out[1];
			 NVMe12_Function_ID[1] <= data_out[0];
			 NVMe12_Function_ID[0] <= (NVMe12_auto_clear) ? NVMe12_Function_ID[0]: 1'b1;
             end 
      8'h80: begin
		     pwd[7] <= data_out[7];
			 pwd[6] <= data_out[6];
			 pwd[5] <= data_out[5];
			 pwd[4] <= data_out[4];
			 pwd[3] <= data_out[3];
			 pwd[2] <= data_out[2];
			 pwd[1] <= data_out[1];
			 pwd[0] <= data_out[0];
		   	 end
      8'h81: begin
             pwd[15] <= data_out[7];
			 pwd[14] <= data_out[6];
			 pwd[13] <= data_out[5];
			 pwd[12] <= data_out[4];
			 pwd[11] <= data_out[3];
			 pwd[10] <= data_out[2];
			 pwd[9] <= data_out[1];
			 pwd[8] <= data_out[0];
             end
      default: begin 	
		       NVMe1_Function_ID <= NVMe1_Function_ID;
			   NVMe2_Function_ID <= NVMe2_Function_ID;
			   NVMe3_Function_ID <= NVMe3_Function_ID;
			   NVMe4_Function_ID <= NVMe4_Function_ID;
			   NVMe5_Function_ID <= NVMe5_Function_ID;
			   NVMe6_Function_ID <= NVMe6_Function_ID;
			   NVMe7_Function_ID <= NVMe7_Function_ID;
			   NVMe8_Function_ID <= NVMe8_Function_ID;
			   NVMe9_Function_ID <= NVMe9_Function_ID;
			   NVMe10_Function_ID <= NVMe10_Function_ID;
			   NVMe11_Function_ID <= NVMe11_Function_ID;
			   NVMe12_Function_ID <= NVMe12_Function_ID;
			   NVMe1_auto_clear <= NVMe1_auto_clear;
               NVMe2_auto_clear <= NVMe2_auto_clear;
               NVMe3_auto_clear <= NVMe3_auto_clear;
               NVMe4_auto_clear <= NVMe4_auto_clear;
			   NVMe5_auto_clear <= NVMe5_auto_clear;
			   NVMe6_auto_clear <= NVMe6_auto_clear;
			   NVMe7_auto_clear <= NVMe7_auto_clear;
			   NVMe8_auto_clear <= NVMe8_auto_clear;
			   NVMe9_auto_clear <= NVMe9_auto_clear;
			   NVMe10_auto_clear <= NVMe10_auto_clear;
			   NVMe11_auto_clear <= NVMe11_auto_clear;
			   NVMe12_auto_clear <= NVMe12_auto_clear;
			   end
      endcase 
end
else begin 
	           NVMe1_auto_clear <= 1'b1;
               NVMe2_auto_clear <= 1'b1;
               NVMe3_auto_clear <= 1'b1;
               NVMe4_auto_clear <= 1'b1;
			   NVMe5_auto_clear <= 1'b1;
               NVMe6_auto_clear <= 1'b1;
               NVMe7_auto_clear <= 1'b1;
               NVMe8_auto_clear <= 1'b1;
			   NVMe9_auto_clear <= 1'b1;
               NVMe10_auto_clear <= 1'b1;
               NVMe11_auto_clear <= 1'b1;
               NVMe12_auto_clear <= 1'b1;
               NVMe1_Function_ID[0] <= 	NVMe1_auto_clear ? 1'b0: NVMe1_Function_ID[0];
               NVMe2_Function_ID[0] <= 	NVMe2_auto_clear ? 1'b0: NVMe2_Function_ID[0];
               NVMe3_Function_ID[0] <= 	NVMe3_auto_clear ? 1'b0: NVMe3_Function_ID[0];
               NVMe4_Function_ID[0] <= 	NVMe4_auto_clear ? 1'b0: NVMe4_Function_ID[0];
               NVMe5_Function_ID[0] <= 	NVMe5_auto_clear ? 1'b0: NVMe5_Function_ID[0];
               NVMe6_Function_ID[0] <= 	NVMe6_auto_clear ? 1'b0: NVMe6_Function_ID[0];
               NVMe7_Function_ID[0] <= 	NVMe7_auto_clear ? 1'b0: NVMe7_Function_ID[0];
               NVMe8_Function_ID[0] <= 	NVMe8_auto_clear ? 1'b0: NVMe8_Function_ID[0];
               NVMe9_Function_ID[0] <= 	NVMe9_auto_clear ? 1'b0: NVMe9_Function_ID[0];
               NVMe10_Function_ID[0] <= NVMe10_auto_clear ? 1'b0: NVMe10_Function_ID[0];
               NVMe11_Function_ID[0] <= NVMe11_auto_clear ? 1'b0: NVMe11_Function_ID[0];
               NVMe12_Function_ID[0] <= NVMe12_auto_clear ? 1'b0: NVMe12_Function_ID[0];			   
end 	
//end
end 
end 
/**********register mem_address_hold read**********/
always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin
rd_lock_data <= 8'h00;
end 
else begin
//else if (I2C_SLAVE_ADDR == I2C_SLAVE_ADDRESS1) begin	
if (sm_state == `I2C_ST_ACK && r_w) begin
case (mem_address_hold_write_read)
     8'h00: begin 
            rd_lock_data[7] <= ~NVMe_8_PRESENT;
			rd_lock_data[6] <= ~NVMe_7_PRESENT;
			rd_lock_data[5] <= ~NVMe_6_PRESENT;
			rd_lock_data[4] <= ~NVMe_5_PRESENT;
            rd_lock_data[3] <= ~NVMe_4_PRESENT;
			rd_lock_data[2] <= ~NVMe_3_PRESENT;
			rd_lock_data[1] <= ~NVMe_2_PRESENT; 
			rd_lock_data[0] <= ~NVMe_1_PRESENT;
			end
     8'h01: begin 
            rd_lock_data[7] <= 1'b0;
			rd_lock_data[6] <= 1'b0;
			rd_lock_data[5] <= 1'b0;
			rd_lock_data[4] <= 1'b0;
            rd_lock_data[3] <= ~NVMe_12_PRESENT;
			rd_lock_data[2] <= ~NVMe_11_PRESENT;
			rd_lock_data[1] <= ~NVMe_10_PRESENT;
			rd_lock_data[0] <= ~NVMe_9_PRESENT;
            end 
     8'h02: begin
            rd_lock_data[7] <= STR[7];
			rd_lock_data[6] <= STR[6];
			rd_lock_data[5] <= STR[5];
			rd_lock_data[4] <= STR[4];
            rd_lock_data[3] <= STR[3];
			rd_lock_data[2] <= STR[2];
			rd_lock_data[1] <= STR[1];
			rd_lock_data[0] <= STR[0];
            end      
     8'h03: begin 
            rd_lock_data[7] <= 1'b1;
			rd_lock_data[6] <= 1'b1;
			rd_lock_data[5] <= 1'b1;
			rd_lock_data[4] <= 1'b1;
            rd_lock_data[3] <= STR[11];
			rd_lock_data[2] <= STR[10];
			rd_lock_data[1] <= STR[9]; 
			rd_lock_data[0] <= STR[8];  
            end
     8'h04: begin 
            rd_lock_data <= {8'h03};
            end 
     8'h05: begin 
            rd_lock_data <= {8'h29};
            end 
     8'h06: begin 
            rd_lock_data <= {8'h56};
            end 
     8'h07: begin 
            rd_lock_data <= {8'h01/*data_code_high_nibble*/};
            end 
     8'h08: begin 
            rd_lock_data[7] <= Enable_disable_VMD1[7];
			rd_lock_data[6] <= Enable_disable_VMD1[6];
			rd_lock_data[5] <= Enable_disable_VMD1[5];
			rd_lock_data[4] <= Enable_disable_VMD1[4];
			rd_lock_data[3] <= Enable_disable_VMD1[3];
			rd_lock_data[2] <= Enable_disable_VMD1[2];
			rd_lock_data[1] <= Enable_disable_VMD1[1];
			rd_lock_data[0] <= Enable_disable_VMD1[0];
            end 
     8'h09: begin 
            rd_lock_data[7] <= Enable_disable_VMD2[7];
			rd_lock_data[6] <= Enable_disable_VMD2[6];
			rd_lock_data[5] <= Enable_disable_VMD2[5];
			rd_lock_data[4] <= Enable_disable_VMD2[4];
			rd_lock_data[3] <= Enable_disable_VMD2[3];
			rd_lock_data[2] <= Enable_disable_VMD2[2];
			rd_lock_data[1] <= Enable_disable_VMD2[1];
			rd_lock_data[0] <= Enable_disable_VMD2[0];
            end      
     8'h92: begin 
            rd_lock_data <= {8'h19};
            end 
     8'h91: begin 
            rd_lock_data <= {8'h01};
            end 
     8'h90: begin 
            rd_lock_data <= {8'h17};
            end
     default: rd_lock_data <= rd_lock_data;
endcase
end
end 
end
//wire time_out_200ms_nvme1;
reg timer_enable_200ms_nvme1;
reg str0_prestate; //20180709
reg btn0_neg_pulse; //20180709
reg [1:0] btn0_int;
assign NVMe_1_PRESENT_NEG_PULSE = ~NVMe_1_PRESENT_REG[0] & NVMe_1_PRESENT_REG[1];
assign NVMe_1_PRESENT_POS_PULSE = ~NVMe_1_PRESENT_REG[1] & NVMe_1_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn0_neg_pulse <= 1'b0;
  btn0_int <= 2'b11;  
  end 
  else begin
  btn0_int <= {btn0_int[0],button[0]};
  btn0_neg_pulse <= btn0_int[1] & ~btn0_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_1_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_1_PRESENT_REG <= {NVMe_1_PRESENT_REG[0],NVMe_1_PRESENT};	  
  end	  
end
/**********NVMe1 LED BLINKING PATTERN DEFINE **********/
always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe1_LED_R <= 1'b0;
NVMe1_LED_G <= 1'b0;
five_zero_happen[0] <= 1'b0;
//button_assert[0] <= 1'b0;
//button_deassert[0] <= 1'b1;
//timer_enable_nvme[0] <= 1'b0; //20180709
STR[0] <= 1'b0;
str0_prestate <= 1'b1;
button[0] <= 1'b1;
timer_enable_200ms_nvme1 <= 1'b0;
//NVMe0_FAKE_PRESENT <= 1'b0;
end  
else begin 
case (NVMe1_LED_BEHAVIOR)
     3'b000: begin  		 
             if (~five_zero_happen[0]) begin 
             NVMe1_LED_R <= 1'b0;
             NVMe1_LED_G <= 1'b0;
			 if (NVMe_1_PRESENT_NEG_PULSE) begin
             button[0] <= 1'b0;
			 //timer_enable_nvme[0] <= 1'b0; //20180709
			 timer_enable_200ms_nvme1 <= 1'b1;
			 //button_assert[0] <= 1'b0;
			 end
             else begin 
             if (timer_enable_200ms_nvme1) begin
			 five_zero_happen[0] <= 1'b1;
             timer_enable_200ms_nvme1 <= 1'b0;
             str0_prestate <= 1'b1;
			 end 	 
             end 
			 end 
			 else begin	 
			 //timer_enable_nvme[0] <= 1'b1; //20180709	 
			 button[0] <= 1'b1;	
             case (str0_prestate)
             1'b0: begin				 
             if (/*~time_out_nvme[0]*/STR[0] == 1'b0) begin
			 STR[0] <= PWREN_N_port0;
             //button[0] <= PWREN_N_port0;			 
			 NVMe1_LED_R <= PWRLED_port0; //20180709
             NVMe1_LED_G <= PWRLED_port0; //20180709
			 end //if (~time_out_nvme[0]) begin	
             else begin
			 NVMe1_LED_R <= 1'b0;//PWRLED_port0;
             NVMe1_LED_G <= 1'b1;//~PWRLED_port0;
			 //button[0] <= 1'b1;
			 //NVMe0_FAKE_PRESENT <= 1'b1;
             if (NVMe_1_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[0] <= 1'b0;
			 //button[0] <= 1'b1;
			 //NVMe0_FAKE_PRESENT <= 1'b0;
             end 
			 end
			 end 
			 1'b1: begin
             if (~STR[0]) begin	 
             NVMe1_LED_R <= ~PWRLED_port0;
			 NVMe1_LED_G <= ~PWRLED_port0;
			 //button[0] <= 1'b1;
             end 
			 else begin
             //button[0] <= ~PWREN_N_port0;  				 
			 STR[0] <= PWREN_N_port0;			 
			 NVMe1_LED_R <= ~PWRLED_port0; //20180709
             NVMe1_LED_G <= ~PWRLED_port0; //20180709
			 end
			 if (NVMe_1_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[0] <= 1'b0;
             end
			 end 	 
			 endcase 
             /*else begin
             five_zero_happen[0] <= 1'b0;
             end*/ //20180709
             end
			 end
     3'b001: begin                     //locate
             NVMe1_LED_R <= clk_250ms;
             NVMe1_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe1_LED_R <= clk_1s;
             NVMe1_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe1_LED_R <= clk_500ms;
             NVMe1_LED_G <= clk_500ms;			 
             end
     3'b100: begin 
             NVMe1_LED_R <= 1'b1;
             NVMe1_LED_G <= 1'b0;
             end   
     3'b101: begin		 //not sure what pattern it
             button[0] <= 1'b0; 		 
			 five_zero_happen[0] <= 1'b1;
			 if (btn0_neg_pulse) begin
			 if (str0_prestate) begin
             str0_prestate <= 1'b0;
             end 
			 else begin
			 str0_prestate <= 1'b1;	 
			 end 	 
			 end 	 
			 //timer_enable_nvme[0] <= 1'b0;	 
             end
     3'b110: begin 
             NVMe1_LED_R <= clk_3hz;
             NVMe1_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe1_LED_R <= 1'b0;
             NVMe1_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe1_LED_R <= 1'b0;
              NVMe1_LED_G <= 1'b0;
              end                                              
endcase              
end
end 
//wire time_out_200ms_nvme2;
reg timer_enable_200ms_nvme2;
reg str1_prestate; //20180709
reg btn1_neg_pulse; //20180709
reg [1:0] btn1_int;
assign NVMe_2_PRESENT_NEG_PULSE = ~NVMe_2_PRESENT_REG[0] & NVMe_2_PRESENT_REG[1];
assign NVMe_2_PRESENT_POS_PULSE = ~NVMe_2_PRESENT_REG[1] & NVMe_2_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn1_neg_pulse <= 1'b0;
  btn1_int <= 2'b11;  
  end 
  else begin
  btn1_int <= {btn1_int[0],button[1]};
  btn1_neg_pulse <= btn1_int[1] & ~btn1_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_2_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_2_PRESENT_REG <= {NVMe_2_PRESENT_REG[0],NVMe_2_PRESENT};	  
  end	  
end
/**********NVMe1 LED BLINKING PATTERN DEFINE **********/
always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe2_LED_R <= 1'b0;
NVMe2_LED_G <= 1'b0;
five_zero_happen[1] <= 1'b0;
//button_assert[1] <= 1'b0;
//button_deassert[1] <= 1'b1;
//timer_enable_nvme[1] <= 1'b0;
str1_prestate <= 1'b1;
STR[1] <= 1'b0;
button[1] <= 1'b1;
timer_enable_200ms_nvme2 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe2_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[1]) begin 
             NVMe2_LED_R <= 1'b0;
             NVMe2_LED_G <= 1'b0;
			 if (NVMe_2_PRESENT_NEG_PULSE) begin
             button[1] <= 1'b0;
			 timer_enable_200ms_nvme2 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme2) begin	 
             five_zero_happen[1] <= 1'b1;
			 timer_enable_200ms_nvme2 <= 1'b0;
			 str1_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[1] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str1_prestate)
             1'b0: begin 				 
             if (~STR[1]) begin 	 
			 STR[1] <= PWREN_N_port1;
             //button[1] <= PWREN_N_port1;			 
			 NVMe2_LED_R <= PWRLED_port1;
             NVMe2_LED_G <= PWRLED_port1; 
			 end //if (~time_out_nvme[1]) begin	
             else begin
			 //button[1] <= 1'b1;	 
			 NVMe2_LED_R <= 1'b0;
             NVMe2_LED_G <= 1'b1;
			 //NVMe1_FAKE_PRESENT <= 1'b1;
             if (NVMe_2_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[1] <= 1'b0;
			 //button[1] <= 1'b1;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[1]) begin
             //button[1] <= 1'b1;			 
             NVMe2_LED_R <= ~PWRLED_port1;
             NVMe2_LED_G <= ~PWRLED_port1; 
             end 
			 else begin 
			 STR[1] <= PWREN_N_port1;
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe2_LED_R <= ~PWRLED_port1;
             NVMe2_LED_G <= ~PWRLED_port1;
			 end
             if (NVMe_2_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[1] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe2_LED_R <= clk_250ms;
             NVMe2_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe2_LED_R <= clk_1s;
             NVMe2_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe2_LED_R <= clk_500ms;
             NVMe2_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe2_LED_R <= 1'b1;
             NVMe2_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[1] <= 1'b0; 		 
			 five_zero_happen[1] <= 1'b1;
			 if (btn1_neg_pulse) begin
			 if (str1_prestate) begin
             str1_prestate <= 1'b0;
             end 
			 else begin
			 str1_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe2_LED_R <= clk_3hz;
             NVMe2_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe2_LED_R <= 1'b0;
             NVMe2_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe2_LED_R <= 1'b0;
              NVMe2_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end 

reg timer_enable_200ms_nvme3;
reg str2_prestate; //20180709
reg btn2_neg_pulse; //20180709
reg [1:0] btn2_int;
assign NVMe_3_PRESENT_NEG_PULSE = ~NVMe_3_PRESENT_REG[0] & NVMe_3_PRESENT_REG[1];
assign NVMe_3_PRESENT_POS_PULSE = ~NVMe_3_PRESENT_REG[1] & NVMe_3_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn2_neg_pulse <= 1'b0;
  btn2_int <= 2'b11;  
  end 
  else begin
  btn2_int <= {btn2_int[0],button[2]};
  btn2_neg_pulse <= btn2_int[1] & ~btn2_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_3_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_3_PRESENT_REG <= {NVMe_3_PRESENT_REG[0],NVMe_3_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe3_LED_R <= 1'b0;
NVMe3_LED_G <= 1'b0;
five_zero_happen[2] <= 1'b0;
//button_assert[1] <= 1'b0;
//button_deassert[1] <= 1'b1;
//timer_enable_nvme[1] <= 1'b0;
str2_prestate <= 1'b1;
STR[2] <= 1'b0;
button[2] <= 1'b1;
timer_enable_200ms_nvme3 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe3_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[2]) begin 
             NVMe3_LED_R <= 1'b0;
             NVMe3_LED_G <= 1'b0;
			 if (NVMe_3_PRESENT_NEG_PULSE) begin
             button[2] <= 1'b0;
			 timer_enable_200ms_nvme3 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme3) begin	 
             five_zero_happen[2] <= 1'b1;
			 timer_enable_200ms_nvme3 <= 1'b0;
			 str2_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[2] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str2_prestate)
             1'b0: begin 				 
             if (~STR[2]) begin 	 
			 STR[2] <= PWREN_N_port2; //update needed
             //button[1] <= PWREN_N_port1;			 
			 NVMe3_LED_R <= PWRLED_port2; //update needed
             NVMe3_LED_G <= PWRLED_port2; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin
			 //button[1] <= 1'b1;	 
			 NVMe3_LED_R <= 1'b0;
             NVMe3_LED_G <= 1'b1;
			 //NVMe1_FAKE_PRESENT <= 1'b1;
             if (NVMe_3_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[2] <= 1'b0;
			 //button[1] <= 1'b1;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[2]) begin
             //button[1] <= 1'b1;			 
             NVMe3_LED_R <= ~PWRLED_port2; //update needed
             NVMe3_LED_G <= ~PWRLED_port2; //update needed
             end 
			 else begin 
			 STR[2] <= PWREN_N_port2; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe3_LED_R <= ~PWRLED_port2; //update needed
             NVMe3_LED_G <= ~PWRLED_port2; //update needed
			 end
             if (NVMe_3_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[2] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe3_LED_R <= clk_250ms;
             NVMe3_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe3_LED_R <= clk_1s;
             NVMe3_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe3_LED_R <= clk_500ms;
             NVMe3_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe3_LED_R <= 1'b1;
             NVMe3_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[2] <= 1'b0; 		 
			 five_zero_happen[2] <= 1'b1;
			 if (btn2_neg_pulse) begin
			 if (str2_prestate) begin
             str2_prestate <= 1'b0;
             end 
			 else begin
			 str2_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe3_LED_R <= clk_3hz;
             NVMe3_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe3_LED_R <= 1'b0;
             NVMe3_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe3_LED_R <= 1'b0;
              NVMe3_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme4;
reg str3_prestate; //20180709
reg btn3_neg_pulse; //20180709
reg [1:0] btn3_int;
assign NVMe_4_PRESENT_NEG_PULSE = ~NVMe_4_PRESENT_REG[0] & NVMe_4_PRESENT_REG[1];
assign NVMe_4_PRESENT_POS_PULSE = ~NVMe_4_PRESENT_REG[1] & NVMe_4_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn3_neg_pulse <= 1'b0;
  btn3_int <= 2'b11;  
  end 
  else begin
  btn3_int <= {btn3_int[0],button[3]};
  btn3_neg_pulse <= btn3_int[1] & ~btn3_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_4_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_4_PRESENT_REG <= {NVMe_4_PRESENT_REG[0],NVMe_4_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe4_LED_R <= 1'b0;
NVMe4_LED_G <= 1'b0;
five_zero_happen[3] <= 1'b0;
//button_assert[1] <= 1'b0;
//button_deassert[1] <= 1'b1;
//timer_enable_nvme[1] <= 1'b0;
str3_prestate <= 1'b1;
STR[3] <= 1'b0;
button[3] <= 1'b1;
timer_enable_200ms_nvme4 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe4_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[3]) begin 
             NVMe4_LED_R <= 1'b0;
             NVMe4_LED_G <= 1'b0;
			 if (NVMe_4_PRESENT_NEG_PULSE) begin
             button[3] <= 1'b0;
			 timer_enable_200ms_nvme4 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme4) begin	 
             five_zero_happen[3] <= 1'b1;
			 timer_enable_200ms_nvme4 <= 1'b0;
			 str3_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[3] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str3_prestate)
             1'b0: begin 				 
             if (~STR[3]) begin 	 
			 STR[3] <= PWREN_N_port3; //update needed
             //button[1] <= PWREN_N_port1;			 
			 NVMe4_LED_R <= PWRLED_port3; //update needed
             NVMe4_LED_G <= PWRLED_port3; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin
			 //button[1] <= 1'b1;	 
			 NVMe4_LED_R <= 1'b0;
             NVMe4_LED_G <= 1'b1;
			 //NVMe1_FAKE_PRESENT <= 1'b1;
             if (NVMe_4_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[3] <= 1'b0;
			 //button[1] <= 1'b1;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[3]) begin
             //button[1] <= 1'b1;			 
             NVMe4_LED_R <= ~PWRLED_port3; //update needed
             NVMe4_LED_G <= ~PWRLED_port3; //update needed
             end 
			 else begin 
			 STR[3] <= PWREN_N_port3; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe4_LED_R <= ~PWRLED_port3; //update needed
             NVMe4_LED_G <= ~PWRLED_port3; //update needed
			 end
             if (NVMe_4_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[3] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe4_LED_R <= clk_250ms;
             NVMe4_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe4_LED_R <= clk_1s;
             NVMe4_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe4_LED_R <= clk_500ms;
             NVMe4_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe4_LED_R <= 1'b1;
             NVMe4_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[3] <= 1'b0; 		 
			 five_zero_happen[3] <= 1'b1;
			 if (btn3_neg_pulse) begin
			 if (str3_prestate) begin
             str3_prestate <= 1'b0;
             end 
			 else begin
			 str3_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe4_LED_R <= clk_3hz;
             NVMe4_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe4_LED_R <= 1'b0;
             NVMe4_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe4_LED_R <= 1'b0;
              NVMe4_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme5;
reg str4_prestate; //20180709
reg btn4_neg_pulse; //20180709
reg [1:0] btn4_int;
assign NVMe_5_PRESENT_NEG_PULSE = ~NVMe_5_PRESENT_REG[0] & NVMe_5_PRESENT_REG[1];
assign NVMe_5_PRESENT_POS_PULSE = ~NVMe_5_PRESENT_REG[1] & NVMe_5_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn4_neg_pulse <= 1'b0;
  btn4_int <= 2'b11;  
  end 
  else begin
  btn4_int <= {btn4_int[0],button[4]};
  btn4_neg_pulse <= btn4_int[1] & ~btn4_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_5_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_5_PRESENT_REG <= {NVMe_5_PRESENT_REG[0],NVMe_5_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe5_LED_R <= 1'b0;
NVMe5_LED_G <= 1'b0;
five_zero_happen[4] <= 1'b0;
str4_prestate <= 1'b1;
STR[4] <= 1'b0;
button[4] <= 1'b1;
timer_enable_200ms_nvme5 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe5_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[4]) begin 
             NVMe5_LED_R <= 1'b0;
             NVMe5_LED_G <= 1'b0;
			 if (NVMe_5_PRESENT_NEG_PULSE) begin
             button[4] <= 1'b0;
			 timer_enable_200ms_nvme5 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme5) begin	 
             five_zero_happen[4] <= 1'b1;
			 timer_enable_200ms_nvme5 <= 1'b0;
			 str4_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[4] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str4_prestate)
             1'b0: begin 				 
             if (~STR[4]) begin 	 
			 STR[4] <= PWREN_N_port4; //update needed		 
			 NVMe5_LED_R <= PWRLED_port4; //update needed
             NVMe5_LED_G <= PWRLED_port4; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin	 
			 NVMe5_LED_R <= 1'b0;
             NVMe5_LED_G <= 1'b1;
             if (NVMe_5_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[4] <= 1'b0;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[4]) begin
             //button[1] <= 1'b1;			 
             NVMe5_LED_R <= ~PWRLED_port4; //update needed
             NVMe5_LED_G <= ~PWRLED_port4; //update needed
             end 
			 else begin 
			 STR[4] <= PWREN_N_port4; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe5_LED_R <= ~PWRLED_port4; //update needed
             NVMe5_LED_G <= ~PWRLED_port4; //update needed
			 end
             if (NVMe_5_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[4] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe5_LED_R <= clk_250ms;
             NVMe5_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe5_LED_R <= clk_1s;
             NVMe5_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe5_LED_R <= clk_500ms;
             NVMe5_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe5_LED_R <= 1'b1;
             NVMe5_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[4] <= 1'b0; 		 
			 five_zero_happen[4] <= 1'b1;
			 if (btn4_neg_pulse) begin
			 if (str4_prestate) begin
             str4_prestate <= 1'b0;
             end 
			 else begin
			 str4_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe5_LED_R <= clk_3hz;
             NVMe5_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe5_LED_R <= 1'b0;
             NVMe5_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe5_LED_R <= 1'b0;
              NVMe5_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme6;
reg str5_prestate; //20180709
reg btn5_neg_pulse; //20180709
reg [1:0] btn5_int;
assign NVMe_6_PRESENT_NEG_PULSE = ~NVMe_6_PRESENT_REG[0] & NVMe_6_PRESENT_REG[1];
assign NVMe_6_PRESENT_POS_PULSE = ~NVMe_6_PRESENT_REG[1] & NVMe_6_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn5_neg_pulse <= 1'b0;
  btn5_int <= 2'b11;  
  end 
  else begin
  btn5_int <= {btn5_int[0],button[5]};
  btn5_neg_pulse <= btn5_int[1] & ~btn5_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_6_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_6_PRESENT_REG <= {NVMe_6_PRESENT_REG[0],NVMe_6_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe6_LED_R <= 1'b0;
NVMe6_LED_G <= 1'b0;
five_zero_happen[5] <= 1'b0;
str5_prestate <= 1'b1;
STR[5] <= 1'b0;
button[5] <= 1'b1;
timer_enable_200ms_nvme6 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe6_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[5]) begin 
             NVMe6_LED_R <= 1'b0;
             NVMe6_LED_G <= 1'b0;
			 if (NVMe_6_PRESENT_NEG_PULSE) begin
             button[5] <= 1'b0;
			 timer_enable_200ms_nvme6 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme6) begin	 
             five_zero_happen[5] <= 1'b1;
			 timer_enable_200ms_nvme6 <= 1'b0;
			 str5_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[5] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str5_prestate)
             1'b0: begin 				 
             if (~STR[5]) begin 	 
			 STR[5] <= PWREN_N_port5; //update needed		 
			 NVMe6_LED_R <= PWRLED_port5; //update needed
             NVMe6_LED_G <= PWRLED_port5; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin	 
			 NVMe6_LED_R <= 1'b0;
             NVMe6_LED_G <= 1'b1;
             if (NVMe_6_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[5] <= 1'b0;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[5]) begin
             //button[1] <= 1'b1;			 
             NVMe6_LED_R <= ~PWRLED_port5; //update needed
             NVMe6_LED_G <= ~PWRLED_port5; //update needed
             end 
			 else begin 
			 STR[5] <= PWREN_N_port5; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe6_LED_R <= ~PWRLED_port5; //update needed
             NVMe6_LED_G <= ~PWRLED_port5; //update needed
			 end
             if (NVMe_6_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[5] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe6_LED_R <= clk_250ms;
             NVMe6_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe6_LED_R <= clk_1s;
             NVMe6_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe6_LED_R <= clk_500ms;
             NVMe6_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe6_LED_R <= 1'b1;
             NVMe6_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[5] <= 1'b0; 		 
			 five_zero_happen[5] <= 1'b1;
			 if (btn5_neg_pulse) begin
			 if (str5_prestate) begin
             str5_prestate <= 1'b0;
             end 
			 else begin
			 str5_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe6_LED_R <= clk_3hz;
             NVMe6_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe6_LED_R <= 1'b0;
             NVMe6_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe6_LED_R <= 1'b0;
              NVMe6_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme7;
reg str6_prestate; //20180709
reg btn6_neg_pulse; //20180709
reg [1:0] btn6_int;
assign NVMe_7_PRESENT_NEG_PULSE = ~NVMe_7_PRESENT_REG[0] & NVMe_7_PRESENT_REG[1];
assign NVMe_7_PRESENT_POS_PULSE = ~NVMe_7_PRESENT_REG[1] & NVMe_7_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn6_neg_pulse <= 1'b0;
  btn6_int <= 2'b11;  
  end 
  else begin
  btn6_int <= {btn6_int[0],button[6]};
  btn6_neg_pulse <= btn6_int[1] & ~btn6_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_7_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_7_PRESENT_REG <= {NVMe_7_PRESENT_REG[0],NVMe_7_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe7_LED_R <= 1'b0;
NVMe7_LED_G <= 1'b0;
five_zero_happen[6] <= 1'b0;
str6_prestate <= 1'b1;
STR[6] <= 1'b0;
button[6] <= 1'b1;
timer_enable_200ms_nvme7 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe7_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[6]) begin 
             NVMe7_LED_R <= 1'b0;
             NVMe7_LED_G <= 1'b0;
			 if (NVMe_7_PRESENT_NEG_PULSE) begin
             button[6] <= 1'b0;
			 timer_enable_200ms_nvme7 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme7) begin	 
             five_zero_happen[6] <= 1'b1;
			 timer_enable_200ms_nvme7 <= 1'b0;
			 str6_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[6] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str6_prestate)
             1'b0: begin 				 
             if (~STR[6]) begin 	 
			 STR[6] <= PWREN_N_port6; //update needed		 
			 NVMe7_LED_R <= PWRLED_port6; //update needed
             NVMe7_LED_G <= PWRLED_port6; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin	 
			 NVMe7_LED_R <= 1'b0;
             NVMe7_LED_G <= 1'b1;
             if (NVMe_7_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[6] <= 1'b0;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[6]) begin
             //button[1] <= 1'b1;			 
             NVMe7_LED_R <= ~PWRLED_port6; //update needed
             NVMe7_LED_G <= ~PWRLED_port6; //update needed
             end 
			 else begin 
			 STR[6] <= PWREN_N_port6; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe7_LED_R <= ~PWRLED_port6; //update needed
             NVMe7_LED_G <= ~PWRLED_port6; //update needed
			 end
             if (NVMe_7_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[6] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe7_LED_R <= clk_250ms;
             NVMe7_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe7_LED_R <= clk_1s;
             NVMe7_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe7_LED_R <= clk_500ms;
             NVMe7_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe7_LED_R <= 1'b1;
             NVMe7_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[6] <= 1'b0; 		 
			 five_zero_happen[6] <= 1'b1;
			 if (btn6_neg_pulse) begin
			 if (str6_prestate) begin
             str6_prestate <= 1'b0;
             end 
			 else begin
			 str6_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe7_LED_R <= clk_3hz;
             NVMe7_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe7_LED_R <= 1'b0;
             NVMe7_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe7_LED_R <= 1'b0;
              NVMe7_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme8;
reg str7_prestate; //20180709
reg btn7_neg_pulse; //20180709
reg [1:0] btn7_int;
assign NVMe_8_PRESENT_NEG_PULSE = ~NVMe_8_PRESENT_REG[0] & NVMe_8_PRESENT_REG[1];
assign NVMe_8_PRESENT_POS_PULSE = ~NVMe_8_PRESENT_REG[1] & NVMe_8_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn7_neg_pulse <= 1'b0;
  btn7_int <= 2'b11;  
  end 
  else begin
  btn7_int <= {btn7_int[0],button[7]};
  btn7_neg_pulse <= btn7_int[1] & ~btn7_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_8_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_8_PRESENT_REG <= {NVMe_8_PRESENT_REG[0],NVMe_8_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe8_LED_R <= 1'b0;
NVMe8_LED_G <= 1'b0;
five_zero_happen[7] <= 1'b0;
str7_prestate <= 1'b1;
STR[7] <= 1'b0;
button[7] <= 1'b1;
timer_enable_200ms_nvme8 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe8_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[7]) begin 
             NVMe8_LED_R <= 1'b0;
             NVMe8_LED_G <= 1'b0;
			 if (NVMe_8_PRESENT_NEG_PULSE) begin
             button[7] <= 1'b0;
			 timer_enable_200ms_nvme8 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme8) begin	 
             five_zero_happen[7] <= 1'b1;
			 timer_enable_200ms_nvme8 <= 1'b0;
			 str7_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[7] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str7_prestate)
             1'b0: begin 				 
             if (~STR[7]) begin 	 
			 STR[7] <= PWREN_N_port7; //update needed		 
			 NVMe8_LED_R <= PWRLED_port7; //update needed
             NVMe8_LED_G <= PWRLED_port7; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin	 
			 NVMe8_LED_R <= 1'b0;
             NVMe8_LED_G <= 1'b1;
             if (NVMe_8_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[7] <= 1'b0;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[7]) begin
             //button[1] <= 1'b1;			 
             NVMe8_LED_R <= ~PWRLED_port7; //update needed
             NVMe8_LED_G <= ~PWRLED_port7; //update needed
             end 
			 else begin 
			 STR[7] <= PWREN_N_port7; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe8_LED_R <= ~PWRLED_port7; //update needed
             NVMe8_LED_G <= ~PWRLED_port7; //update needed
			 end
             if (NVMe_8_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[7] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe8_LED_R <= clk_250ms;
             NVMe8_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe8_LED_R <= clk_1s;
             NVMe8_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe8_LED_R <= clk_500ms;
             NVMe8_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe8_LED_R <= 1'b1;
             NVMe8_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[7] <= 1'b0; 		 
			 five_zero_happen[7] <= 1'b1;
			 if (btn7_neg_pulse) begin
			 if (str7_prestate) begin
             str7_prestate <= 1'b0;
             end 
			 else begin
			 str7_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe8_LED_R <= clk_3hz;
             NVMe8_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe8_LED_R <= 1'b0;
             NVMe8_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe8_LED_R <= 1'b0;
              NVMe8_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme9;
reg str8_prestate; //20180709
reg btn8_neg_pulse; //20180709
reg [1:0] btn8_int;
assign NVMe_9_PRESENT_NEG_PULSE = ~NVMe_9_PRESENT_REG[0] & NVMe_9_PRESENT_REG[1];
assign NVMe_9_PRESENT_POS_PULSE = ~NVMe_9_PRESENT_REG[1] & NVMe_9_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn8_neg_pulse <= 1'b0;
  btn8_int <= 2'b11;  
  end 
  else begin
  btn8_int <= {btn8_int[0],button[8]};
  btn8_neg_pulse <= btn8_int[1] & ~btn8_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_9_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_9_PRESENT_REG <= {NVMe_9_PRESENT_REG[0],NVMe_9_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe9_LED_R <= 1'b0;
NVMe9_LED_G <= 1'b0;
five_zero_happen[8] <= 1'b0;
str8_prestate <= 1'b1;
STR[8] <= 1'b0;
button[8] <= 1'b1;
timer_enable_200ms_nvme9 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe9_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[8]) begin 
             NVMe9_LED_R <= 1'b0;
             NVMe9_LED_G <= 1'b0;
			 if (NVMe_9_PRESENT_NEG_PULSE) begin
             button[8] <= 1'b0;
			 timer_enable_200ms_nvme9 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme9) begin	 
             five_zero_happen[8] <= 1'b1;
			 timer_enable_200ms_nvme9 <= 1'b0;
			 str8_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[8] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str8_prestate)
             1'b0: begin 				 
             if (~STR[8]) begin 	 
			 STR[8] <= PWREN_N_port8; //update needed		 
			 NVMe9_LED_R <= PWRLED_port8; //update needed
             NVMe9_LED_G <= PWRLED_port8; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin	 
			 NVMe9_LED_R <= 1'b0;
             NVMe9_LED_G <= 1'b1;
             if (NVMe_9_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[8] <= 1'b0;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[8]) begin
             //button[1] <= 1'b1;			 
             NVMe9_LED_R <= ~PWRLED_port8; //update needed
             NVMe9_LED_G <= ~PWRLED_port8; //update needed
             end 
			 else begin 
			 STR[8] <= PWREN_N_port8; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe9_LED_R <= ~PWRLED_port8; //update needed
             NVMe9_LED_G <= ~PWRLED_port8; //update needed
			 end
             if (NVMe_9_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[8] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe9_LED_R <= clk_250ms;
             NVMe9_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe9_LED_R <= clk_1s;
             NVMe9_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe9_LED_R <= clk_500ms;
             NVMe9_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe9_LED_R <= 1'b1;
             NVMe9_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[8] <= 1'b0; 		 
			 five_zero_happen[8] <= 1'b1;
			 if (btn8_neg_pulse) begin
			 if (str8_prestate) begin
             str8_prestate <= 1'b0;
             end 
			 else begin
			 str8_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe9_LED_R <= clk_3hz;
             NVMe9_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe9_LED_R <= 1'b0;
             NVMe9_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe9_LED_R <= 1'b0;
              NVMe9_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme10;
reg str9_prestate; //20180709
reg btn9_neg_pulse; //20180709
reg [1:0] btn9_int;
assign NVMe_10_PRESENT_NEG_PULSE = ~NVMe_10_PRESENT_REG[0] & NVMe_10_PRESENT_REG[1];
assign NVMe_10_PRESENT_POS_PULSE = ~NVMe_10_PRESENT_REG[1] & NVMe_10_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn9_neg_pulse <= 1'b0;
  btn9_int <= 2'b11;  
  end 
  else begin
  btn9_int <= {btn9_int[0],button[9]};
  btn9_neg_pulse <= btn9_int[1] & ~btn9_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_10_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_10_PRESENT_REG <= {NVMe_10_PRESENT_REG[0],NVMe_10_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe10_LED_R <= 1'b0;
NVMe10_LED_G <= 1'b0;
five_zero_happen[9] <= 1'b0;
str9_prestate <= 1'b1;
STR[9] <= 1'b0;
button[9] <= 1'b1;
timer_enable_200ms_nvme10 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe10_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[9]) begin 
             NVMe10_LED_R <= 1'b0;
             NVMe10_LED_G <= 1'b0;
			 if (NVMe_10_PRESENT_NEG_PULSE) begin
             button[9] <= 1'b0;
			 timer_enable_200ms_nvme10 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme10) begin	 
             five_zero_happen[9] <= 1'b1;
			 timer_enable_200ms_nvme10 <= 1'b0;
			 str9_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[9] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str9_prestate)
             1'b0: begin 				 
             if (~STR[9]) begin 	 
			 STR[9] <= PWREN_N_port9; //update needed		 
			 NVMe10_LED_R <= PWRLED_port9; //update needed
             NVMe10_LED_G <= PWRLED_port9; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin	 
			 NVMe10_LED_R <= 1'b0;
             NVMe10_LED_G <= 1'b1;
             if (NVMe_10_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[9] <= 1'b0;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[9]) begin
             //button[1] <= 1'b1;			 
             NVMe10_LED_R <= ~PWRLED_port9; //update needed
             NVMe10_LED_G <= ~PWRLED_port9; //update needed
             end 
			 else begin 
			 STR[9] <= PWREN_N_port9; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe10_LED_R <= ~PWRLED_port9; //update needed
             NVMe10_LED_G <= ~PWRLED_port9; //update needed
			 end
             if (NVMe_10_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[9] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe10_LED_R <= clk_250ms;
             NVMe10_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe10_LED_R <= clk_1s;
             NVMe10_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe10_LED_R <= clk_500ms;
             NVMe10_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe10_LED_R <= 1'b1;
             NVMe10_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[9] <= 1'b0; 		 
			 five_zero_happen[9] <= 1'b1;
			 if (btn9_neg_pulse) begin
			 if (str9_prestate) begin
             str9_prestate <= 1'b0;
             end 
			 else begin
			 str9_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe10_LED_R <= clk_3hz;
             NVMe10_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe10_LED_R <= 1'b0;
             NVMe10_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe10_LED_R <= 1'b0;
              NVMe10_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme11;
reg str10_prestate; //20180709
reg btn10_neg_pulse; //20180709
reg [1:0] btn10_int;
assign NVMe_11_PRESENT_NEG_PULSE = ~NVMe_11_PRESENT_REG[0] & NVMe_11_PRESENT_REG[1];
assign NVMe_11_PRESENT_POS_PULSE = ~NVMe_11_PRESENT_REG[1] & NVMe_11_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn10_neg_pulse <= 1'b0;
  btn10_int <= 2'b11;  
  end 
  else begin
  btn10_int <= {btn10_int[0],button[10]};
  btn10_neg_pulse <= btn10_int[1] & ~btn10_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_11_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_11_PRESENT_REG <= {NVMe_11_PRESENT_REG[0],NVMe_11_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe11_LED_R <= 1'b0;
NVMe11_LED_G <= 1'b0;
five_zero_happen[10] <= 1'b0;
str10_prestate <= 1'b1;
STR[10] <= 1'b0;
button[10] <= 1'b1;
timer_enable_200ms_nvme11 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe11_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[10]) begin 
             NVMe11_LED_R <= 1'b0;
             NVMe11_LED_G <= 1'b0;
			 if (NVMe_11_PRESENT_NEG_PULSE) begin
             button[10] <= 1'b0;
			 timer_enable_200ms_nvme11 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme11) begin	 
             five_zero_happen[10] <= 1'b1;
			 timer_enable_200ms_nvme11 <= 1'b0;
			 str10_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[10] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str10_prestate)
             1'b0: begin 				 
             if (~STR[10]) begin 	 
			 STR[10] <= PWREN_N_port10; //update needed		 
			 NVMe11_LED_R <= PWRLED_port10; //update needed
             NVMe11_LED_G <= PWRLED_port10; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin	 
			 NVMe11_LED_R <= 1'b0;
             NVMe11_LED_G <= 1'b1;
             if (NVMe_11_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[10] <= 1'b0;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[10]) begin
             //button[1] <= 1'b1;			 
             NVMe11_LED_R <= ~PWRLED_port10; //update needed
             NVMe11_LED_G <= ~PWRLED_port10; //update needed
             end 
			 else begin 
			 STR[10] <= PWREN_N_port10; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe11_LED_R <= ~PWRLED_port10; //update needed
             NVMe11_LED_G <= ~PWRLED_port10; //update needed
			 end
             if (NVMe_11_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[10] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe11_LED_R <= clk_250ms;
             NVMe11_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe11_LED_R <= clk_1s;
             NVMe11_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe11_LED_R <= clk_500ms;
             NVMe11_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe11_LED_R <= 1'b1;
             NVMe11_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[10] <= 1'b0; 		 
			 five_zero_happen[10] <= 1'b1;
			 if (btn10_neg_pulse) begin
			 if (str10_prestate) begin
             str10_prestate <= 1'b0;
             end 
			 else begin
			 str10_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe11_LED_R <= clk_3hz;
             NVMe11_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe11_LED_R <= 1'b0;
             NVMe11_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe11_LED_R <= 1'b0;
              NVMe11_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end

reg timer_enable_200ms_nvme12;
reg str11_prestate; //20180709
reg btn11_neg_pulse; //20180709
reg [1:0] btn11_int;
assign NVMe_12_PRESENT_NEG_PULSE = ~NVMe_12_PRESENT_REG[0] & NVMe_12_PRESENT_REG[1];
assign NVMe_12_PRESENT_POS_PULSE = ~NVMe_12_PRESENT_REG[1] & NVMe_12_PRESENT_REG[0];
always@(posedge cpld_internal_clk or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  btn11_neg_pulse <= 1'b0;
  btn11_int <= 2'b11;  
  end 
  else begin
  btn11_int <= {btn11_int[0],button[11]};
  btn11_neg_pulse <= btn11_int[1] & ~btn11_int[0];
  end 
end
always@(posedge clk_500 or negedge rst_sync_clk) begin
  if (~rst_sync_clk) begin
  NVMe_12_PRESENT_REG <= 2'b00; 
  end
  else begin
  NVMe_12_PRESENT_REG <= {NVMe_12_PRESENT_REG[0],NVMe_12_PRESENT};	  
  end	  
end

always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin 
if (~rst_sync_clk) begin 
NVMe12_LED_R <= 1'b0;
NVMe12_LED_G <= 1'b0;
five_zero_happen[11] <= 1'b0;
str11_prestate <= 1'b1;
STR[11] <= 1'b0;
button[11] <= 1'b1;
timer_enable_200ms_nvme12 <= 1'b0;
//NVMe1_FAKE_PRESENT <= 1'b0;
end 
else begin 
case (NVMe12_LED_BEHAVIOR)
     3'b000: begin 
		     if (~five_zero_happen[11]) begin 
             NVMe12_LED_R <= 1'b0;
             NVMe12_LED_G <= 1'b0;
			 if (NVMe_12_PRESENT_NEG_PULSE) begin
             button[11] <= 1'b0;
			 timer_enable_200ms_nvme12 <= 1'b1;
			 end
             else begin
			 if (timer_enable_200ms_nvme12) begin	 
             five_zero_happen[11] <= 1'b1;
			 timer_enable_200ms_nvme12 <= 1'b0;
			 str11_prestate <= 1'b1;
			 end
             end
			 end 
			 else begin	 
			 //timer_enable_nvme[1] <= 1'b1;	 
			 button[11] <= 1'b1;	 
			 //if (button_assert[1]) begin
             case(str11_prestate)
             1'b0: begin 				 
             if (~STR[11]) begin 	 
			 STR[11] <= PWREN_N_port11; //update needed		 
			 NVMe12_LED_R <= PWRLED_port11; //update needed
             NVMe12_LED_G <= PWRLED_port11; //update needed
			 end //if (~time_out_nvme[1]) begin	
             else begin	 
			 NVMe12_LED_R <= 1'b0;
             NVMe12_LED_G <= 1'b1;
             if (NVMe_12_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[11] <= 1'b0;
             end 
             end
			 end //1'b0: begin
			 1'b1: begin
			 if (~STR[11]) begin
             //button[1] <= 1'b1;			 
             NVMe12_LED_R <= ~PWRLED_port11; //update needed
             NVMe12_LED_G <= ~PWRLED_port11; //update needed
             end 
			 else begin 
			 STR[11] <= PWREN_N_port11; //update needed
             //button[1] <= ~PWREN_N_port1;			 
			 NVMe12_LED_R <= ~PWRLED_port11; //update needed
             NVMe12_LED_G <= ~PWRLED_port11; //update needed
			 end
             if (NVMe_12_PRESENT_POS_PULSE) begin //2017/09/20
			 five_zero_happen[11] <= 1'b0;
             end 			 
			 end //1'b1	 
			 endcase 
			 end	 
             end 
     3'b001: begin                     //locate
             NVMe12_LED_R <= clk_250ms;
             NVMe12_LED_G <= 1'b0;
             end    
     3'b010: begin 
             NVMe12_LED_R <= clk_1s;
             NVMe12_LED_G <= 1'b0;
             end
     3'b011: begin 
             NVMe12_LED_R <= clk_500ms;
             NVMe12_LED_G <= clk_500ms;   
             end
     3'b100: begin 
             NVMe12_LED_R <= 1'b1;
             NVMe12_LED_G <= 1'b0;
             end   
     3'b101: begin                    //not sure what pattern it  
             button[11] <= 1'b0; 		 
			 five_zero_happen[11] <= 1'b1;
			 if (btn11_neg_pulse) begin
			 if (str11_prestate) begin
             str11_prestate <= 1'b0;
             end 
			 else begin
			 str11_prestate <= 1'b1;	 
			 end 	 
			 end	 
             end
     3'b110: begin 
             NVMe12_LED_R <= clk_3hz;
             NVMe12_LED_G <= 1'b0;
             end  
     3'b111: begin 
             NVMe12_LED_R <= 1'b0;
             NVMe12_LED_G <= 1'b1;
             end 
     default: begin 
              NVMe12_LED_R <= 1'b0;
              NVMe12_LED_G <= 1'b0;
              end                                              
endcase              
//end 
end
end
/*timer #(7) timer_inst04(
.cpld_rst_n_50m (rst_sync_clk),
.cpld_50m_clk (cpld_internal_clk),
.clk_en (clk_en_1k),
.timer_en (timer_enable_200ms_nvme2),
.time_dly (7'd100),
.timeout (time_out_200ms_nvme2)
);*/
endmodule