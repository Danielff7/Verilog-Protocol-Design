//   ==================================================================
//   >>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
//   ------------------------------------------------------------------
//   Copyright (c) 2013 by Lattice Semiconductor Corporation
//   ALL RIGHTS RESERVED 
//   ------------------------------------------------------------------
//
//   Permission:
//
//      Lattice SG Pte. Ltd. grants permission to use this code
//      pursuant to the terms of the Lattice Reference Design License Agreement. 
//
//
//   Disclaimer:
//
//      This VHDL or Verilog source code is intended as a design reference
//      which illustrates how these types of functions can be implemented.
//      It is the user's responsibility to verify their design for
//      consistency and functionality through the use of formal
//      verification methods.  Lattice provides no warranty
//      regarding the use or functionality of this code.
//
//   --------------------------------------------------------------------
//
//                  Lattice SG Pte. Ltd.
//                  101 Thomson Road, United Square #07-02 
//                  Singapore 307591
//
//
//                  TEL: 1-800-Lattice (USA and Canada)
//                       +65-6631-2000 (Singapore)
//                       +1-503-268-8001 (other locations)
//
//                  web: http://www.latticesemi.com/
//                  email: techsupport@latticesemi.com
//
//   --------------------------------------------------------------------
//


//
// 
//  Name:  i2c_slave.v   
// 
//  Description: Generic i2c slave module with 1 bidirectional data port
// 		 1.supports random write, random read, sequential read
// 		 and burst write / read
//     
//-------------------------------------------------------------------------
// Code Revision History :
//-------------------------------------------------------------------------
// Ver: | Author	|Mod. Date	|Changes Made:
// V1.0 | cm		|8/2005     |Init ver 
// V1.1 | ks		|1/2007		|change slave address to be input
// V1.2 | cm		|6/2009		|change slave address back to parameter
//                              |emulate slave is not ready (clk stretch)
// V1.3 | cm,cwd    |7/4/10     |added delay element to scl to prevent false 
//                              |start due to trace delays
//-------------------------------------------------------------------------
`timescale 1ns/1ps

module i2c_slave(
	input rst,
	input clk,
	input i2c_scl,
	inout i2c_sda,
	//inout sda_slave1,
	//inout sda_slave2,
	//output scl_slave1,
	//output scl_slave2,
	input [7:0] i2c_dataout,
	output reg [7:0] i2c_datain_latch,
	output reg [2:0] i2c_pre_state,
	output reg [2:0] i2c_state,
	output reg [7:0] i2c_slave_addr,
	output reg sda_control,
	input [6:0] I2C_SLAVE_ADDRESS1,
	input [6:0] I2C_SLAVE_ADDRESS2,
	input [6:0] I2C_SLAVE_ADDRESS3,
	input [6:0] I2C_SLAVE_ADDRESS4,
	input [6:0] I2C_SLAVE_ADDRESS5,
	input [6:0] I2C_SLAVE_ADDRESS6,
	output i2c_scl_falling_edge,
	output reg switch_direction
	//input SMCLK1,
	//input switch1_enable_control,
	//input switch2_enable_control
	//output reg [4:0] i2c_clk_debounce
	);
	/***** internal parameter *****/
	//localparam I2C_SLAVE_ADDRESS1 = 7'b0110011;
	//localparam I2C_SLAVE_ADDRESS2 = 7'b0110000;
	localparam I2C_ST_IDLE = 3'h0; 
    localparam I2C_ST_TIP = 3'h1;
    localparam I2C_ST_ADDR = 3'h2; 
    localparam I2C_ST_DATA = 3'h3;
	localparam I2C_ST_CMD = 3'h4;
    localparam I2C_ST_ACK = 3'h5;
	/***** register declaration *****/
	reg start;
	reg stop;
	reg [1:0] i2c_scl_int;
	reg [1:0] i2c_sda_int;
	reg [3:0] data_count;
	reg [4:0] i2c_data_debounce;
	reg ack;
	//reg switch_direction;
	/***** assign declaration *****/
    assign start_rst = (~rst | (i2c_state == I2C_ST_TIP & i2c_pre_state == I2C_ST_IDLE));
    assign stop_rst = (~rst | start);
    assign i2c_scl_rising_edge = i2c_scl_int[0] & ~i2c_scl_int[1];
    assign i2c_scl_falling_edge = ~i2c_scl_int[0] & i2c_scl_int[1];
    assign i2c_sda_rising_edge = i2c_sda_int[0] & ~i2c_sda_int[1];
    assign i2c_sda_falling_edge = ~i2c_sda_int[0] & i2c_sda_int[1];
	//assign sda_slave1 = (switch1_enable_control && ~switch_direction) ? (~i2c_data_debounce[4] ? 1'b0: 1'bz): 1'bz;
	//assign sda_slave2 = (switch2_enable_control && ~switch_direction) ? (~i2c_data_debounce[4] ? 1'b0: 1'bz): 1'bz;
	//assign i2c_sda = ((switch1_enable_control | switch2_enable_control) && (switch_direction)) ? ((~sda_slave1 | ~sda_slave2) ? 1'b0: 1'bz): 1'bz;
    /***** rising falling i2c clock edge *****/
    always@(posedge clk or negedge rst) begin
	if (~rst) begin
	i2c_scl_int <= 2'b11;
    i2c_sda_int <= 2'b11;
    i2c_data_debounce <= 5'b11111;
    end
	else begin
	i2c_scl_int <= {i2c_scl_int[0],i2c_scl};
    i2c_sda_int <= {i2c_sda_int[0],i2c_data_debounce[4]};
    i2c_data_debounce[3:0] <= {i2c_data_debounce[2:0],i2c_sda};
	
    if (i2c_data_debounce[3:0] == 4'b1111)
    i2c_data_debounce[4] <= 1'b1;
    else if(i2c_data_debounce[3:0] == 4'b0000)
    i2c_data_debounce[4] <= 1'b0;	
	end	
    end
	/***** start assignment *****/
	always@(posedge clk or posedge start_rst) begin
	  if (start_rst) begin
      start <= 1'b0;
      end 
	  else begin
	  if (i2c_sda_falling_edge)
      start <= i2c_scl;		  
	  end	  
	end	
	/***** stop assignment *****/
	always@(posedge clk or posedge stop_rst) begin
	  if (stop_rst)	begin
	  stop <= 1'b0;	  
	  end
      else begin
      if (i2c_sda_rising_edge)
	  stop <= i2c_scl;
      end
	end
	/***** i2c state change *****/
	always@(posedge clk or negedge rst) begin
	  if (~rst) begin	
	  i2c_pre_state <= I2C_ST_IDLE;
	  i2c_state <= I2C_ST_IDLE;
	  i2c_datain_latch <= 8'h0;
	  i2c_slave_addr <= 8'h0;
	  sda_control <= 1'b1;
	  data_count <= 4'h7;
	  ack <= 1'b0;
	  switch_direction <= 1'b0;
      end
      else begin
      case(i2c_state)
	  I2C_ST_IDLE: begin
	  sda_control <= 1'b1; 	  
	  if (start) begin
	  i2c_datain_latch <= 8'h0;
      i2c_slave_addr <= 8'h0;
	  switch_direction <= 1'b0;
      data_count <= 4'h7;
	  i2c_pre_state <= I2C_ST_IDLE;
	  i2c_state <= I2C_ST_TIP;
      end
      end //I2C_ST_IDLE: begin
	  I2C_ST_TIP: begin
	  if (start) begin
	  data_count <= 4'h7;
	  i2c_pre_state <= I2C_ST_IDLE;
	  i2c_state <= I2C_ST_TIP;
      end
	  else if (stop) begin
	  i2c_state <= I2C_ST_IDLE;	  
	  end 
      else begin
      if (i2c_pre_state == I2C_ST_IDLE | ~i2c_slave_addr[0]) begin	  
	  if (data_count[3]) begin
      if (i2c_scl_falling_edge) begin
	  data_count <= 4'h7;
	  switch_direction <= 1'b1;
	  if (i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS1 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS2 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS3 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS4 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS5 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS6) begin
      sda_control <= 1'b0;
      end
      if (i2c_pre_state == I2C_ST_IDLE)	begin
      i2c_pre_state <= I2C_ST_ADDR;
	  i2c_state <= I2C_ST_ACK;
      end
	  else if (i2c_pre_state == I2C_ST_ADDR) begin
	  i2c_pre_state <= I2C_ST_CMD;
      i2c_state <= I2C_ST_ACK;	  
      end
      else begin
      i2c_pre_state <= I2C_ST_DATA;
	  i2c_state <= I2C_ST_ACK;
      end
	  end //if (i2c_scl_falling_edge) begin	  
      end //if (data_count[3]) begin
	  else begin
	  if (i2c_scl_rising_edge) begin
      if (i2c_pre_state == I2C_ST_IDLE) begin
	  i2c_slave_addr[data_count] <= i2c_data_debounce[4];
      data_count <= data_count - 4'b1;	  
      end 
      else begin
      i2c_datain_latch[data_count] <= i2c_data_debounce[4];
	  data_count <= data_count - 4'b1;
      end
      end
	  end 	  
	  end //if (i2c_pre_state == I2C_ST_IDLE | ~i2c_slave_addr[0]) begin
      else begin //ABC
	  if (data_count[3]) begin
	  if (i2c_scl_falling_edge)	begin
      sda_control <= 1'b1;
	  data_count <= 4'h7;
	  switch_direction <= 1'b0;
	  i2c_pre_state <= I2C_ST_DATA;
      i2c_state <= I2C_ST_ACK;
      end
	  end //if (data_count[3]) begin
      else begin 
	  if (i2c_scl_falling_edge) begin
	  if (i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS1 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS2 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS3 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS4 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS5 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS6) begin
      sda_control <= i2c_dataout[data_count]; 
      end
	  else begin
	  sda_control <= 1'b1;	  
	  end 
      data_count <= data_count - 4'b1;	  
	  end //if (i2c_scl_falling_edge) begin
      end	  
      end //ABC
      end 
	  end //I2C_ST_TIP: begin
      I2C_ST_ACK: begin
      if (~i2c_slave_addr[0]) begin 	  
	  if (i2c_scl_rising_edge) begin
	  if (~i2c_data_debounce[4]) begin
      ack <= 1'b1;
      end
	  end //if (i2c_scl_rising_edge) begin
      else if (i2c_scl_falling_edge) begin
	  sda_control <= 1'b1;
      switch_direction <= 1'b0;  	  
      if (ack) begin
	  ack <= 1'b0;
      i2c_state <= I2C_ST_TIP;
	  end
      else begin	  
      i2c_state <= I2C_ST_IDLE;
      end
      end //else if (i2c_scl_falling_edge) begin
	  end //if (~i2c_slave_addr[0]) begin
      else begin
      if (i2c_scl_rising_edge) begin
	  if (~i2c_data_debounce[4]) begin
      ack <= 1'b1;
      end 
	  end //if (i2c_scl_rising_edge) begin
      else if (i2c_scl_falling_edge) begin
      if (ack) begin
	  if (i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS1 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS2 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS3 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS4 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS5 | i2c_slave_addr[7:1] == I2C_SLAVE_ADDRESS6) begin
      sda_control <= i2c_dataout[data_count];
      end 
	  else begin 
	  sda_control <= 1'b1;	  
	  end
	  switch_direction <= 1'b1;
      ack <= 1'b0;	  
      data_count <= data_count - 4'b1;
      i2c_state <= I2C_ST_TIP; 	  
	  end //if (ack) begin
      else begin
      i2c_state <= I2C_ST_IDLE;
      end
      end //else if (i2c_scl_falling_edge) begin 
      end 
      end //I2C_ST_ACK: begin
	  endcase	  
      end
	end	
	/*i2c_quick_read_write i2c_quick_read_write_inst(
	.I2C_SLAVE_ADDR (i2c_slave_addr[7:1]),
	.rst_sync_clk (rst),
	.cpld_internal_clk (clk),
	.sm_state (i2c_state),
	.pre_state (i2c_pre_state),
	.data_in (i2c_datain_latch),
	.stop (stop),
	.switch1_enable_control (switch1_enable_control),
	.switch2_enable_control (switch2_enable_control)
	);*/
	endmodule