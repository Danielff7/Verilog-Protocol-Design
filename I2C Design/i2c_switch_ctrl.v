module i2c_switch_ctrl(
 input clk,
 input rst,
 inout i2c_sda,
 input i2c_scl,
 inout sda_slave1,
 inout sda_slave2,
 inout sda_slave3,
 inout sda_slave4,
 inout sda_slave5,
 inout sda_slave6,
 inout sda_slave7,
 inout sda_slave8,
 inout sda_slave9,
 inout sda_slave10,
 inout sda_slave11,
 inout sda_slave12,
 input SMCLK1,
 input SMCLK2,
 input SMCLK3,
 input SMCLK4,
 input SMCLK5,
 input SMCLK6,
 input SMCLK7,
 input SMCLK8,
 input SMCLK9,
 input SMCLK10,
 input SMCLK11,
 input SMCLK12,
 output sclk1_oen,
 output sclk2_oen,
 output sclk3_oen,
 output sclk4_oen,
 output sclk5_oen,
 output sclk6_oen,
 output sclk7_oen,
 output sclk8_oen,
 output sclk9_oen,
 output sclk10_oen,
 output sclk11_oen,
 output sclk12_oen,
 input switch1_enable_control,
 input switch2_enable_control,
 input switch3_enable_control,
 input switch4_enable_control,
 input switch5_enable_control,
 input switch6_enable_control,
 input switch7_enable_control,
 input switch8_enable_control,
 input switch9_enable_control,
 input switch10_enable_control,
 input switch11_enable_control,
 input switch12_enable_control,
 input neg,
 input switch_direction,
 output reg state
);

localparam HIGH_STATE = 1;
localparam LOW_STATE = 0;
//reg state;
reg sclk_ctrl;
wire timeout;
assign sda_slave1 = (switch1_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign i2c_sda = ((switch1_enable_control | switch2_enable_control | switch3_enable_control | switch4_enable_control | switch5_enable_control | switch6_enable_control | switch7_enable_control | switch8_enable_control | switch9_enable_control | switch10_enable_control | switch11_enable_control | switch12_enable_control) && (switch_direction)) ? ((~sda_slave1 | ~sda_slave2 | ~sda_slave3 | ~sda_slave4 | ~sda_slave5 | ~sda_slave6 | ~sda_slave7 | ~sda_slave8 | ~sda_slave9 | ~sda_slave10 | ~sda_slave11 | ~sda_slave12) ? 1'b0: 1'bz): 1'bz; 
assign sda_slave2 = (switch2_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave3 = (switch3_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave4 = (switch4_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave5 = (switch5_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave6 = (switch6_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave7 = (switch7_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave8 = (switch8_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave9 = (switch9_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave10 = (switch10_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave11 = (switch11_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sda_slave12 = (switch12_enable_control & ~switch_direction) ? (~i2c_sda ? 1'b0: 1'bz): 1'bz;
assign sclk1_oen = (switch1_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk2_oen = (switch2_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk3_oen = (switch3_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk4_oen = (switch4_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk5_oen = (switch5_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk6_oen = (switch6_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk7_oen = (switch7_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk8_oen = (switch8_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk9_oen = (switch9_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk10_oen = (switch10_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk11_oen = (switch11_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
assign sclk12_oen = (switch12_enable_control) ? /*(~switch_direction ? i2c_scl:*/sclk_ctrl: 1'b1;
always@(posedge clk or negedge rst) begin
  if (~rst) begin
	state <= HIGH_STATE;
	sclk_ctrl <= 1'b1;  
  end
  else begin
  case(state) 
  HIGH_STATE: begin
	if (neg) begin
		state <= LOW_STATE;
		sclk_ctrl <= 1'b0;  
	end	  
  end
  LOW_STATE: begin
  if (timeout) begin
	/*if (~switch_direction) begin
	state <= HIGH_STATE;
	sclk_ctrl <= 1'b1;
	end*/
	//else begin
	sclk_ctrl <= 1'b1;
  if (switch1_enable_control) begin
	if (SMCLK1) begin
		state <= HIGH_STATE;	  
	end 
  end
  else if (switch2_enable_control) begin
	if (SMCLK2) begin
		state <= HIGH_STATE;	  
	end	  
  end
  else if (switch3_enable_control) begin
	if (SMCLK3) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch4_enable_control) begin
	if (SMCLK4) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch5_enable_control) begin
	if (SMCLK5) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch6_enable_control) begin
	if (SMCLK6) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch7_enable_control) begin
	if (SMCLK7) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch8_enable_control) begin
	if (SMCLK8) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch9_enable_control) begin
	if (SMCLK9) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch10_enable_control) begin
	if (SMCLK10) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch11_enable_control) begin
	if (SMCLK11) begin
		state <= HIGH_STATE;
	end 
  end
  else if (switch12_enable_control) begin
	if (SMCLK12) begin
		state <= HIGH_STATE;
	end 
  end  
  else begin
	state <= HIGH_STATE;
  end
  //end  
  end //if (timeout) begin
  end //LOW_STATE: begin	  
  endcase 	  
  end 
  end 
 timer #(8) timer_inst01(
.cpld_rst_n_50m (rst),
.cpld_50m_clk (clk/*cpld_internal_clk*/),
.clk_en (1'b1/*clk_en_1k*/),
.timer_en (~state),
.time_dly (8'd141),
.timeout (timeout)
); 
  
endmodule 