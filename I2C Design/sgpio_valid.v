`timescale 1 ns / 1 ns
/*** SGPIO MODULE FOR BPN-SAS3-F418-B6N4-R100 ***/
/*** AUTHOR: Daniel Tsai                       ***/
/*** DATE:   07-05-2017														***/
/*** Description: This module is for SGPIO interface of BPN-SAS3-F418-B6N4-R100(Using Lattice FPGA LCMXO2-1200HC-4TG100C)CPLD. ***/
/***              It contains the IO ports of CPLD. And also make the interconnection of the                       ***/
/***              lower level modules										                                       ***/
module sgpio
#(parameter Drive_num = 4)
(
input rst,
input clk,
input sload,
input sclk,
input sdout,
output reg [Drive_num-1:0] drive_fault,
output reg [Drive_num-1:0] drive_active,
output reg [Drive_num-1:0] drive_rebuild,
output reg [Drive_num-1:0] drive_locate
/*output reg [2:0] data_latch,
output reg [1:0] data_counter,
output data_valid,
output reg [1:0] drive_num_counter*/
);

localparam SGPIO_IDLE = 0;
//localparam SGPIO_START = 1;
localparam SGPIO_DATA_PROCESS = 1/*2*/;
localparam SCLK_HIGH_TIME = 25000;
/********** register declaration **********/
//reg [2:0] sclk_counter;
reg [1:0] sclk_int;
reg [1:0] data_counter;
reg [2:0] data_latch;
reg [1:0] drive_num_counter;
reg [14:0] sclk_keep_high_counter; 
reg state;
reg start_skip;
reg extend;
/********** negedge of sclk **********/
assign sclk_negedge_pulse = ~sclk_int[0] & sclk_int[1];
assign sclk_posedge_pulse = sclk_int[0] & ~sclk_int[1];
always@(posedge clk or negedge rst) begin
if (~rst) begin
sclk_int <= 2'b11;
end
else begin
sclk_int <= {sclk_int[0],sclk};
end
end
/********** Wait at least five clock cycle **********/
/*assign transmission_start = (sclk_counter == 3'h5) ? 1'b1: 1'b0;
always@(posedge clk or negedge rst) begin
if (~rst) begin
sclk_counter <= 3'b0;
end
else begin
if (sload) begin
sclk_counter <= 3'b0;
end
else if (transmission_start) begin
sclk_counter <= sclk_counter;
end
else if (sclk_negedge_pulse) begin
sclk_counter <= sclk_counter + 3'b1;
end
end
end*/
/********** SGPIO STATE MACHINE **********/
assign data_valid = (data_counter == 2'b11) ? 1'b1: 1'b0;
assign back_to_idle = (data_counter == 2'b10 && drive_num_counter == 2'b11) ? 1'b1: 1'b0;
always@(posedge clk or negedge rst) begin
if(~rst) begin
drive_num_counter <= 2'b11;
data_counter <= 2'b10;//2'b00;
data_latch <= 3'b000;
state <= SGPIO_IDLE;
drive_fault <= 4'b1111;
drive_active <= 4'b1111;
drive_rebuild <= 4'b1111;
drive_locate <= 4'b1111;
start_skip <= 1'b1; //20180619
extend <= 1'b0;
end
else if (sclk_high_too_long) begin
drive_num_counter <= 2'b11;
data_counter <= 2'b10;//2'b00;
data_latch <= 3'b000;
state <= SGPIO_IDLE;
drive_fault <= 4'b1111;
drive_active <= 4'b1111;
drive_rebuild <= 4'b1111;
drive_locate <= 4'b1111;
start_skip <= 1'b1; //20180619
extend <= 1'b0;
end	
else begin
case(state)
SGPIO_IDLE: begin
if (sclk_negedge_pulse) begin
if (sload) begin
if (~extend) begin
data_latch[data_counter] <= sdout;
data_counter <= data_counter + 2'b1;
state <= SGPIO_DATA_PROCESS;
end
else begin
state <= SGPIO_DATA_PROCESS;extend <= 1'b0;
end
end 
else begin
if (drive_num_counter == 2'b11) begin
data_latch[data_counter] <= sdout;
data_counter <= data_counter + 2'b1;
state <= SGPIO_DATA_PROCESS;
extend <= 1'b1;
end 
end 	
end 
end
SGPIO_DATA_PROCESS: begin
if (start_skip == 1'b1) begin 
drive_num_counter <= 2'b11;
data_counter <= 2'b10;//2'b00;
data_latch <= 3'b000;
state <= SGPIO_IDLE;
drive_fault <= 4'b1111;
drive_active <= 4'b1111;
drive_rebuild <= 4'b1111;
drive_locate <= 4'b1111;
start_skip <= 1'b0;end
else begin 
if (sclk_negedge_pulse) begin
data_latch[data_counter] <= sdout;
data_counter <= data_counter + 2'b1;
end
else begin
if (data_valid | back_to_idle) begin
/*data_latch <= 3'b000;
data_counter <= 2'b00;*/
if(~back_to_idle) begin
if (data_latch[0] == 1'b1) begin
drive_fault[drive_num_counter] <= 1'b0;
drive_active[drive_num_counter] <= 1'b1;
drive_rebuild[drive_num_counter] <= 1'b0;
drive_locate[drive_num_counter] <= 1'b0;
end 
if(data_latch[2:1] == 2'b10) begin
drive_fault[drive_num_counter] <= 1'b1;//1'b1;
drive_active[drive_num_counter] <= 1'b0;
drive_rebuild[drive_num_counter] <= 1'b0;
drive_locate[drive_num_counter] <= 1'b0;
end
else if(data_latch[2:1] == 2'b01) begin
drive_fault[drive_num_counter] <= 1'b0;
drive_active[drive_num_counter] <= 1'b0;
drive_rebuild[drive_num_counter] <= 1'b0;
drive_locate[drive_num_counter] <= 1'b1;//1'b1;
end
else if(data_latch[2:1] == 2'b11) begin
drive_fault[drive_num_counter] <= 1'b0;
drive_active[drive_num_counter] <= 1'b0;
drive_rebuild[drive_num_counter] <= 1'b1;
drive_locate[drive_num_counter] <= 1'b0;
end
else begin
drive_fault[drive_num_counter] <= 1'b0;
drive_active[drive_num_counter] <= 1'b0;
drive_rebuild[drive_num_counter] <= 1'b0;
drive_locate[drive_num_counter] <= 1'b0;	
end	
if (sclk_posedge_pulse) begin
	/*if (drive_num_counter < 2'b11) begin*/
drive_num_counter <= drive_num_counter + 2'd1;
    /*end
	else begin
	drive_num_counter <= 2'd0;	
	end*/	
data_counter <= 2'b00;
data_latch <= 3'b000;
if (extend) begin
state <= SGPIO_IDLE;
end 	

/*if (drive_num_counter == 2'b11) begin
state <= SGPIO_IDLE;
end*/
end
end 
else begin
state <= SGPIO_IDLE;	
end 
/*if (~sload) begin
drive_num_counter <= drive_num_counter + 3'h1;
state <= SGPIO_DATA_PROCESS;
end
else begin
drive_num_counter <= 3'h0;
state <= SGPIO_DATA_PROCESS;
end*/
end //if (data_valid)
end
end 
end //SGPIO_DATA_PROCESS: begin
endcase
end //else
end //always@(posedge clk or negedge rst) begin
/***** SCLK KEEP HIGH SITUATION *****/
assign sclk_high_too_long = (sclk_keep_high_counter == SCLK_HIGH_TIME) ? 1'b1: 1'b0;
always@(posedge clk or negedge rst) begin
  if (~rst) begin  sclk_keep_high_counter <= 0;
  end
  else begin
  if (sclk_negedge_pulse | sclk_posedge_pulse) begin  sclk_keep_high_counter <= 0; 
  end
  else if (sclk_keep_high_counter == SCLK_HIGH_TIME) begin
  sclk_keep_high_counter <= 0;
  end 
  else begin
  sclk_keep_high_counter <= sclk_keep_high_counter + 1;
  end  
  end	
end 	
endmodule