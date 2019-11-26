`timescale 1 ns / 1 ns
/*** I2C Memory Map MODULE FOR BPN-SAS3-F418-B6N4	***/
/*** AUTHOR: Daniel Tsai											    ***/
/*** DATE:   07-03-2017														***/
/*** Description: This module provides the CPLD BMC memory map              ***/
/***										                                ***/
/*** 2016 Super Micro Computer, Inc., ALL RIGHTS RESERVED					            ***/
/****** state machine define          *******/

module i2c_mem_vpp_new2(
	output reg [7:0] rd_lock_data,
	input [6:0] addr_in,
	input [7:0] data_out,
	input r_w,
	input [2:0] sm_state,
	input [2:0] pre_sm_state,
	input rst_sync_clk,
	input cpld_internal_clk,
	output reg PWREN_N_port0,
	output reg PWREN_N_port1,
	output reg ATNLED_port0,
	output reg PWRLED_port0,
	output reg ATNLED_port1,
	output reg PWRLED_port1,
	input NVMe_1_PRESENT,
	input NVMe_2_PRESENT,
	input [1:0] button,
	input [6:0] correct_address
	/*input [1:0] STR,
	input NVMe0_FAKE_PRESENT,
	input NVMe1_FAKE_PRESENT*/
	//input [1:0] led_control
	);
	//parameter slave_addr = 7'b0100000;
	//parameter slave_addr2 = 7'b0100001;
	reg [7:0] mem_address_hold_write_read;
	reg EMIL_port0;
	reg EMIL_port1;
	reg [7:0] port0_bit_inout;
	reg [7:0] port1_bit_inout;
	/********** localparam ******************/
    localparam I2C_ST_DATA = 3'h3;
    localparam I2C_ST_ACK = 3'h5;
    localparam I2C_ST_CMD = 3'h4;
    localparam I2C_ST_TIP = 3'h1;
    localparam I2C_ST_ADDR = 3'h2;
	/********** wire assignment *************/
	wire [2:0] sm_state_reg;
	wire [2:0] pre_sm_state_reg;
	assign sm_state_reg = (addr_in == correct_address) ? sm_state: 3'b111;
	assign pre_sm_state_reg = (addr_in == correct_address) ? pre_sm_state: 3'b111;
	/**********register mem_address_hold write**********/
	always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin
	  if (~rst_sync_clk) begin	
	  mem_address_hold_write_read <= 8'h08;
      ATNLED_port0 <= 1'b0;
      PWRLED_port0 <= 1'b0;
      PWREN_N_port0 <= 1'b1;
      EMIL_port0 <= 1'b1;
      ATNLED_port1 <= 1'b0;
      PWRLED_port1 <= 1'b0;
      PWREN_N_port1 <= 1'b1;
      EMIL_port1 <= 1'b1;
      port0_bit_inout <= 8'hFF;
      port1_bit_inout <= 8'hFF;	
	  end 
      else begin
      case (sm_state_reg)
	  I2C_ST_ACK: begin
      case(pre_sm_state_reg)
	  I2C_ST_CMD: begin
	  mem_address_hold_write_read <= data_out;	  
	  /*if (~led_control[0] && led_control[1]) begin	  
	  if (addr_in == slave_addr2)	  
      mem_address_hold_write_read <= data_out;
	  else 
	  mem_address_hold_write_read <= 8'h08;
      end
      else begin
      if (addr_in == slave_addr)	  
      mem_address_hold_write_read <= data_out;
	  else 
	  mem_address_hold_write_read <= 8'h08;
      end*/
      end
	  I2C_ST_DATA: begin
	  case(mem_address_hold_write_read)
      8'h02: begin
      ATNLED_port0 <= (~port0_bit_inout[0]) ? data_out[0]: ATNLED_port0;
      PWRLED_port0 <= (~port0_bit_inout[1]) ? data_out[1]: PWRLED_port0;
      PWREN_N_port0 <=(~port0_bit_inout[2]) ? data_out[2]: PWREN_N_port0;
      EMIL_port0 <= (~port0_bit_inout[7]) ? data_out[7]: EMIL_port0;
      end
	  8'h03: begin
      ATNLED_port1 <= (~port1_bit_inout[0]) ? data_out[0]: ATNLED_port1;
      PWRLED_port1 <= (~port1_bit_inout[1]) ? data_out[1]: PWRLED_port1;
      PWREN_N_port1 <=(~port1_bit_inout[2]) ? data_out[2]: PWREN_N_port1;
      EMIL_port1 <= (~port1_bit_inout[7]) ? data_out[7]: EMIL_port1;
      end
	  8'h06: begin
      port0_bit_inout[0] <= data_out[0];
      port0_bit_inout[1] <= data_out[1];
      port0_bit_inout[2] <= data_out[2];
      port0_bit_inout[3] <= data_out[3];
      port0_bit_inout[4] <= data_out[4];
      port0_bit_inout[5] <= data_out[5];
      port0_bit_inout[6] <= data_out[6];
      port0_bit_inout[7] <= data_out[7];
      end
	  8'h07: begin
      port1_bit_inout[0] <= data_out[0];
      port1_bit_inout[1] <= data_out[1];
      port1_bit_inout[2] <= data_out[2];
      port1_bit_inout[3] <= data_out[3];
      port1_bit_inout[4] <= data_out[4];
      port1_bit_inout[5] <= data_out[5];
      port1_bit_inout[6] <= data_out[6];
      port1_bit_inout[7] <= data_out[7];
      end
	  default: begin
      ATNLED_port0 <= ATNLED_port0;
      PWRLED_port0 <= PWRLED_port0;
      PWREN_N_port0 <= PWREN_N_port0;
      EMIL_port0 <= EMIL_port0;
      ATNLED_port1 <= ATNLED_port1;
      PWRLED_port1 <= PWRLED_port1;
      PWREN_N_port1 <= PWREN_N_port1;
      EMIL_port1 <= EMIL_port1;
      port0_bit_inout <= port0_bit_inout;
      port1_bit_inout <= port1_bit_inout;
      end
      endcase 
	  end 	  
	  endcase 	  
      end 
	  I2C_ST_TIP: begin
	  case(pre_sm_state_reg)
	  I2C_ST_DATA: begin
      if (mem_address_hold_write_read == 8'h02) 
	  mem_address_hold_write_read <= 8'h03;
      else if(mem_address_hold_write_read == 8'h06)
      mem_address_hold_write_read <= 8'h07;		  
      end
	  I2C_ST_ADDR: begin
	  if (r_w) begin
      //if (led_control[0] && led_control[1])		  
      mem_address_hold_write_read <= 8'h01;
	  //else
	  //mem_address_hold_write_read <= 8'h01;	  
      end	  
	  end	  
      endcase 		  
	  end	  		  
	  endcase 	  
      end
	end	
	/**********register mem_address_hold read**********/
	always @(posedge cpld_internal_clk or negedge rst_sync_clk) begin
	if (~rst_sync_clk) begin
    rd_lock_data <= 8'b11111100;	
    end	
    else begin
	case(sm_state_reg)	
	I2C_ST_ACK: begin
	case(pre_sm_state_reg)
	I2C_ST_ADDR: begin
	if (r_w) begin	
	case(mem_address_hold_write_read)
	8'h00: begin
	rd_lock_data[4] <= (port0_bit_inout[4]) ? /*((~STR[1]) ? NVMe_1_PRESENT: (NVMe1_FAKE_PRESENT | NVMe_1_PRESENT))*/NVMe_1_PRESENT: rd_lock_data[4];
    rd_lock_data[3] <= (port0_bit_inout[3]) ? button[0]: rd_lock_data[3];
    rd_lock_data[2] <= PWREN_N_port0;
    rd_lock_data[1] <= PWRLED_port0;
    rd_lock_data[0] <= ATNLED_port0;	
    end
	endcase	
	end
    end
    I2C_ST_DATA: begin
	if (r_w) begin
	case(mem_address_hold_write_read)
	8'h01: begin
    rd_lock_data[4] <= (port1_bit_inout[4]) ? /*((~STR[0]) ? NVMe_2_PRESENT: (NVMe0_FAKE_PRESENT | NVMe_2_PRESENT))*/NVMe_2_PRESENT: rd_lock_data[4];
    rd_lock_data[3] <= (port1_bit_inout[3]) ? button[1]: rd_lock_data[3];
    rd_lock_data[2] <= PWREN_N_port1;
    rd_lock_data[1] <= PWRLED_port1;
    rd_lock_data[0] <= ATNLED_port1;
    end	
	/*default: begin
	rd_lock_data <= 8'b11111100;	
	end*/	
    endcase
    end
    end
    endcase  		
    end	
	endcase	
    end
	end
	endmodule 