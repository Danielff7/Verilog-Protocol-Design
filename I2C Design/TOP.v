module BPN_SAS3_119A_N2(
inout BMC_SMDAT /*synthesis loc="C4" io_type="LVCMOS33" pullmode="NONE"* opendrain="ON"*/, //correct
inout BMC_SMCLK /*synthesis loc="B6" io_type="LVCMOS33"	pullmode="NONE"* opendrain="ON"*/, //correct
input RST_CPLD /*synthesis loc="B5"	io_type="LVCMOS33" pullmode="NONE"*/, //correct
input PE1_RSTA_N /*synthesis loc="C5" io_type="LVCMOS33" pullmode="NONE"*/, //correct
input VPP_SCL1 /*synthesis loc="B12" io_type="LVCMOS33" pullmode="NONE"*/, //correct 
inout VPP_SDA1 /*synthesis loc="A13" io_type="LVCMOS33"	pullmode="NONE" opendrain="ON"*/, //correct
output NVMe1_RSTA_N /*synthesis loc="C15" io_type="LVCMOS33" pullmode="NONE"*/, //correct
input IfDet1_N /*synthesis loc="F13" io_type="LVCMOS33" pullmode="UP"*/, //correct
input PRSNT1_N /*synthesis loc="G12" io_type="LVCMOS33" pullmode="UP"*/, //correct
output NVMe_LEDR1 /*synthesis loc="D15" io_type="LVCMOS33" pullmode="NONE"*/, //correct
output NVMe_LEDG1 /*synthesis loc="D16" io_type="LVCMOS33" pullmode="NONE"*/, //correct
inout SMDAT1 /*synthesis loc="C16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //c
inout SMCLK1 /*synthesis loc="B16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //c
output REDRIVER_EN1_N /*synthesis loc="B11" io_type="LVCMOS33" pullmode="NONE"*/, //C
input SGPIO_DOUT1 /*synthesis loc="A4" io_type="LVCMOS33" pullmode="NONE"*/, //C
input SGPIO_CLK1 /*synthesis loc="A5" io_type="LVCMOS33" pullmode="NONE"*/,  //C
input SGPIO_LOAD1 /*synthesis loc="B4" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe2_RSTA_N /*synthesis loc="D3" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout I2C_CLK_PROG /*synthesis loc="A9"	io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/,
inout I2C_SDA_PROG /*synthesis loc="C9" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/,
output NVMe_LEDR2 /*synthesis loc="D1" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG2 /*synthesis loc="D2" io_type="LVCMOS33" pullmode="NONE"*/, //C 
inout SMDAT2 /*synthesis loc="B1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK2 /*synthesis loc="C1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN2_N /*synthesis loc="C12" io_type="LVCMOS33" pullmode="NONE"*/, //C
input VPP_SCL3 /*synthesis loc="B7" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout VPP_SDA3 /*synthesis loc="C7" io_type="LVCMOS33"	pullmode="NONE" opendrain="ON"*/, //C
output NVMe3_RSTA_N /*synthesis loc="F14" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet3_N /*synthesis loc="G15" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT3_N /*synthesis loc="G14" io_type="LVCMOS33" pullmode="UP"*/, //C
output NVMe_LEDR3 /*synthesis loc="E14" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG3 /*synthesis loc="F15" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout SMDAT3 /*synthesis loc="F16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK3 /*synthesis loc="E16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN3_N /*synthesis loc="E6" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe4_RSTA_N /*synthesis loc="G3" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet4_N /*synthesis loc="G4" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT4_N /*synthesis loc="G5" io_type="LVCMOS33" pullmode="UP"*/, //C 
output NVMe_LEDR4 /*synthesis loc="E2" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG4 /*synthesis loc="E3" io_type="LVCMOS33" pullmode="NONE"*/, //C
output REDRIVER_EN4_N /*synthesis loc="D7" io_type="LVCMOS33" pullmode="NONE"*/, //C
input VPP_SCL5 /*synthesis loc="D8" io_type="LVCMOS33" pullmode="NONE"*/, //C 
inout VPP_SDA5 /*synthesis loc="C8" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output NVMe5_RSTA_N /*synthesis loc="J13" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet5_N /*synthesis loc="G16" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT5_N /*synthesis loc="K16" io_type="LVCMOS33" pullmode="UP"*/, //C
output NVMe_LEDR5 /*synthesis loc="J15" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG5 /*synthesis loc="H15" io_type="LVCMOS33" pullmode="NONE"*/, //C 
inout SMDAT5 /*synthesis loc="J16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK5 /*synthesis loc="H16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN5_N /*synthesis loc="E9" io_type="LVCMOS33" pullmode="NONE"*/, //C
input SGPIO_DOUT2 /*synthesis loc="A12" io_type="LVCMOS33" pullmode="NONE"*/, //C
input SGPIO_CLK2 /*synthesis loc="A11" io_type="LVCMOS33" pullmode="NONE"*/, //C
input SGPIO_LOAD2 /*synthesis loc="B14" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe6_RSTA_N /*synthesis loc="K2" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet6_N /*synthesis loc="G1" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT6_N /*synthesis loc="K1" io_type="LVCMOS33" pullmode="UP"*/, //C
output NVMe_LEDR6 /*synthesis loc="H2" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG6 /*synthesis loc="J2" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout SMDAT6 /*synthesis loc="H1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK6 /*synthesis loc="J1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN6_N /*synthesis loc="F8" io_type="LVCMOS33" pullmode="NONE"*/, //C
input VPP_SCL7 /*synthesis loc="K13" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout VPP_SDA7 /*synthesis loc="K12" io_type="LVCMOS33"	pullmode="NONE" opendrain="ON"*/, //C
output NVMe7_RSTA_N /*synthesis loc="L13" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet7_N /*synthesis loc="H14" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT7_N /*synthesis loc="K14" io_type="LVCMOS33" pullmode="UP"*/, //C 
output NVMe_LEDR7 /*synthesis loc="K15" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG7 /*synthesis loc="L14" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout SMDAT7 /*synthesis loc="M16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK7 /*synthesis loc="L16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN7_N /*synthesis loc="L12" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe8_RSTA_N /*synthesis loc="L5" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet8_N /*synthesis loc="K5" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT8_N /*synthesis loc="L4" io_type="LVCMOS33" pullmode="UP"*/, //C
output NVMe_LEDR8 /*synthesis loc="L2" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG8 /*synthesis loc="L3" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout SMDAT8 /*synthesis loc="L1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK8 /*synthesis loc="M1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN8_N /*synthesis loc="J11" io_type="LVCMOS33" pullmode="NONE"*/, //C
input VPP_SCL9 /*synthesis loc="P13" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout VPP_SDA9 /*synthesis loc="R12" io_type="LVCMOS33"	pullmode="NONE" opendrain="ON"*/, //C
output NVMe9_RSTA_N /*synthesis loc="N16" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet9_N /*synthesis loc="M14" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT9_N /*synthesis loc="N14" io_type="LVCMOS33" pullmode="UP"*/, //C
output NVMe_LEDR9 /*synthesis loc="P15" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG9 /*synthesis loc="N15" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout SMDAT9 /*synthesis loc="R16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK9 /*synthesis loc="P16" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN9_N /*synthesis loc="P12" io_type="LVCMOS33" pullmode="NONE"*/, //C
input SGPIO_DOUT3 /*synthesis loc="A10" io_type="LVCMOS33" pullmode="NONE"*/, //C
input SGPIO_CLK3 /*synthesis loc="A8" io_type="LVCMOS33" pullmode="NONE"*/, //C
input SGPIO_LOAD3 /*synthesis loc="B9" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe10_RSTA_N /*synthesis loc="N1" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet10_N /*synthesis loc="M3" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT10_N /*synthesis loc="N3" io_type="LVCMOS33" pullmode="UP"*/, //C
output NVMe_LEDR10 /*synthesis loc="N2" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG10 /*synthesis loc="P2" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout SMDAT10 /*synthesis loc="P1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK10 /*synthesis loc="R1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN10_N /*synthesis loc="N11" io_type="LVCMOS33" pullmode="NONE"*/, //C
input VPP_SCL11 /*synthesis loc="T7" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout VPP_SDA11 /*synthesis loc="T8" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output NVMe11_RSTA_N /*synthesis loc="T15" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet11_N /*synthesis loc="T13" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT11_N /*synthesis loc="T12" io_type="LVCMOS33" pullmode="UP"*/, //C
output NVMe_LEDR11 /*synthesis loc="R13" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG11 /*synthesis loc="T14" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout SMDAT11 /*synthesis loc="T10" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK11 /*synthesis loc="T11" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN11_N /*synthesis loc="R11" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe12_RSTA_N /*synthesis loc="T3" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet12_N /*synthesis loc="T5" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT12_N /*synthesis loc="T4" io_type="LVCMOS33" pullmode="UP"*/, //C
output NVMe_LEDR12 /*synthesis loc="R6" io_type="LVCMOS33" pullmode="NONE"*/, //C
output NVMe_LEDG12 /*synthesis loc="R7" io_type="LVCMOS33" pullmode="NONE"*/, //C
inout SMDAT12 /*synthesis loc="T2" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK12 /*synthesis loc="R3" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output REDRIVER_EN12_N /*synthesis loc="T9" io_type="LVCMOS33" pullmode="NONE"*/, //C
input IfDet2_N /*synthesis loc="F4" io_type="LVCMOS33" pullmode="UP"*/, //C
input PRSNT2_N /*synthesis loc="F2" io_type="LVCMOS33" pullmode="UP"*/, //C 
input CPU_SEL0 /*synthesis loc="H5" io_type="LVCMOS33" pullmode="UP"*/, //C
input CPU_SEL1 /*synthesis loc="J4" io_type="LVCMOS33" pullmode="UP"*/, //C
input CPU_SEL2 /*synthesis loc="J5" io_type="LVCMOS33" pullmode="UP"*/, //C
inout TEMPSEN_DAT /*synthesis loc="R5" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout TEMPSEN_CLK /*synthesis loc="P5" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout FP_TEMPSEN_DAT /*synthesis loc="F5" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout FP_TEMPSEN_CLK /*synthesis loc="H6" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMDAT4 /*synthesis loc="F1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
inout SMCLK4 /*synthesis loc="E1" io_type="LVCMOS33" pullmode="NONE" opendrain="ON"*/, //C
output D1_PWRDIS /*synthesis loc="F12" io_type="LVCMOS33" pullmode="NONE"*/, //C
output D2_PWRDIS /*synthesis loc="C2" io_type="LVCMOS33" pullmode="NONE"*/, //C
output D3_PWRDIS /*synthesis loc="E15" io_type="LVCMOS33" pullmode="NONE"*/,
output D4_PWRDIS /*synthesis loc="G2" io_type="LVCMOS33" pullmode="NONE"*/,
output D5_PWRDIS /*synthesis loc="H11" io_type="LVCMOS33" pullmode="NONE"*/,
output D6_PWRDIS /*synthesis loc="K3" io_type="LVCMOS33" pullmode="NONE"*/,output D7_PWRDIS /*synthesis loc="K11" io_type="LVCMOS33" pullmode="NONE"*/,output D8_PWRDIS /*synthesis loc="K4" io_type="LVCMOS33" pullmode="NONE"*/,
output D9_PWRDIS /*synthesis loc="M15" io_type="LVCMOS33" pullmode="NONE"*/,output D10_PWRDIS /*synthesis loc="M2" io_type="LVCMOS33" pullmode="NONE"*/,
output D11_PWRDIS /*synthesis loc="R14" io_type="LVCMOS33" pullmode="NONE"*/,
output D12_PWRDIS /*synthesis loc="R4" io_type="LVCMOS33" pullmode="NONE"*/
);
/***** wire *****/
/***** clock module *****/ 
wire clk_250ms;
wire clk_500ms;
wire clk_1s;
wire clk_en_1k;
wire clk_3hz;
wire clk_500;
/***** I2C BMC module *****/
wire sda_control_bmc;
wire state;
wire switch_direction;
wire neg;
wire switch1_enable_control;
wire switch2_enable_control;
wire switch3_enable_control;
wire switch4_enable_control;
wire switch5_enable_control;
wire switch6_enable_control;
wire switch7_enable_control;
wire switch8_enable_control;
wire switch9_enable_control;
wire switch10_enable_control;
wire switch11_enable_control;
wire switch12_enable_control;
assign BMC_SMDAT = (~sda_control_bmc) ? 1'b0: 1'bz;
assign BMC_SMCLK = (~state) ? 1'b0: 1'bz;
wire [7:0] data_in_bmc;
wire [7:0] i2c_datain_latch_bmc;
wire [2:0] i2c_pre_state_bmc;
wire [2:0] i2c_state_bmc;
wire [7:0] i2c_slave_addr_bmc;
wire [7:0] Enable_disable_VMD1;
wire [15:0] pwd;
assign D1_PWRDIS = pwd[0];
assign D2_PWRDIS = pwd[1];
assign D3_PWRDIS = pwd[2];
assign D4_PWRDIS = pwd[3];
assign D5_PWRDIS = pwd[4];
assign D6_PWRDIS = pwd[5];
assign D7_PWRDIS = pwd[6];
assign D8_PWRDIS = pwd[7];
assign D9_PWRDIS = pwd[8];
assign D10_PWRDIS = pwd[9];
assign D11_PWRDIS = pwd[10];
assign D12_PWRDIS = pwd[11];
/***** I2C VPP module *****/
wire sda_control_vpp1;
wire [7:0] data_in_vpp1;
wire [7:0] i2c_datain_latch_vpp1;
wire [2:0] i2c_pre_state_vpp1;
wire [2:0] i2c_state_vpp1;
wire [7:0] i2c_slave_addr_vpp1;
wire [11:0] BTN;
wire [11:0] STR;
wire [7:0] data_in_vpp2;
wire [7:0] i2c_datain_latch_vpp2;
wire [2:0] i2c_pre_state_vpp2;
wire [2:0] i2c_state_vpp2;
wire [7:0] i2c_slave_addr_vpp2;
/***** Drive 3 & 4 *****/
wire [7:0] data_in_vpp_drv34;
wire [7:0] i2c_datain_latch_vpp_drv34;
wire [2:0] i2c_pre_state_vpp_drv34;
wire [2:0] i2c_state_vpp_drv34;
wire [7:0] i2c_slave_addr_vpp_drv34;
assign data_in_vpp_drv34 = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? data_in_vpp2: data_in_vpp1;
assign i2c_datain_latch_vpp_drv34 = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? i2c_datain_latch_vpp2: i2c_datain_latch_vpp1;
assign i2c_pre_state_vpp_drv34 = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? i2c_pre_state_vpp2: i2c_pre_state_vpp1;
assign i2c_state_vpp_drv34 = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? i2c_state_vpp2: i2c_state_vpp1;
assign i2c_slave_addr_vpp_drv34 = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? i2c_slave_addr_vpp2: i2c_slave_addr_vpp1;
/***** Drive 5 & 6 *****/
wire [7:0] data_in_vpp_drv56;
wire [7:0] i2c_datain_latch_vpp_drv56;
wire [2:0] i2c_pre_state_vpp_drv56;
wire [2:0] i2c_state_vpp_drv56;
wire [7:0] i2c_slave_addr_vpp_drv56;
assign data_in_vpp_drv56 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2)) ? data_in_vpp2: data_in_vpp1;
assign i2c_datain_latch_vpp_drv56 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2)) ? i2c_datain_latch_vpp2: i2c_datain_latch_vpp1;
assign i2c_pre_state_vpp_drv56 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2)) ? i2c_pre_state_vpp2: i2c_pre_state_vpp1;
assign i2c_state_vpp_drv56 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2)) ? i2c_state_vpp2: i2c_state_vpp1;
assign i2c_slave_addr_vpp_drv56 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2)) ? i2c_slave_addr_vpp2: i2c_slave_addr_vpp1;
/***** Drive 7 & 8 *****/
wire [7:0] data_in_vpp_drv78;
wire [7:0] i2c_datain_latch_vpp_drv78;
wire [2:0] i2c_pre_state_vpp_drv78;
wire [2:0] i2c_state_vpp_drv78;
wire [7:0] i2c_slave_addr_vpp_drv78;
assign data_in_vpp_drv78 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2)) ? data_in_vpp2: data_in_vpp1;
assign i2c_datain_latch_vpp_drv78 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2)) ? i2c_datain_latch_vpp2: i2c_datain_latch_vpp1;
assign i2c_pre_state_vpp_drv78 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2)) ? i2c_pre_state_vpp2: i2c_pre_state_vpp1;
assign i2c_state_vpp_drv78 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2)) ? i2c_state_vpp2: i2c_state_vpp1;
assign i2c_slave_addr_vpp_drv78 = ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) || (~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2)) ? i2c_slave_addr_vpp2: i2c_slave_addr_vpp1;
/***** Drive 9 & 10 *****/
wire [7:0] data_in_vpp_drv910;
wire [7:0] i2c_datain_latch_vpp_drv910;
wire [2:0] i2c_pre_state_vpp_drv910;
wire [2:0] i2c_state_vpp_drv910;
wire [7:0] i2c_slave_addr_vpp_drv910;
assign data_in_vpp_drv910 = ((CPU_SEL2 & CPU_SEL1 & ~CPU_SEL0) || (CPU_SEL2 & CPU_SEL1 & CPU_SEL0)) ? data_in_vpp1: data_in_vpp2;
assign i2c_datain_latch_vpp_drv910 = ((CPU_SEL2 & CPU_SEL1 & ~CPU_SEL0) || (CPU_SEL2 & CPU_SEL1 & CPU_SEL0)) ? i2c_datain_latch_vpp1: i2c_datain_latch_vpp2;
assign i2c_pre_state_vpp_drv910 = ((CPU_SEL2 & CPU_SEL1 & ~CPU_SEL0) || (CPU_SEL2 & CPU_SEL1 & CPU_SEL0)) ? i2c_pre_state_vpp1: i2c_pre_state_vpp2;
assign i2c_state_vpp_drv910 = ((CPU_SEL2 & CPU_SEL1 & ~CPU_SEL0) || (CPU_SEL2 & CPU_SEL1 & CPU_SEL0)) ? i2c_state_vpp1: i2c_state_vpp2;
assign i2c_slave_addr_vpp_drv910 = ((CPU_SEL2 & CPU_SEL1 & ~CPU_SEL0) || (CPU_SEL2 & CPU_SEL1 & CPU_SEL0)) ? i2c_slave_addr_vpp1: i2c_slave_addr_vpp2;
/***** Drive 11 & 12 *****/
wire [7:0] data_in_vpp_drv1112;
wire [7:0] i2c_datain_latch_vpp_drv1112;
wire [2:0] i2c_pre_state_vpp_drv1112;
wire [2:0] i2c_state_vpp_drv1112;
wire [7:0] i2c_slave_addr_vpp_drv1112;
assign data_in_vpp_drv1112 = (CPU_SEL2 & CPU_SEL1 & CPU_SEL0) ? data_in_vpp1: data_in_vpp2;
assign i2c_datain_latch_vpp_drv1112 = (CPU_SEL2 & CPU_SEL1 & CPU_SEL0) ? i2c_datain_latch_vpp1: i2c_datain_latch_vpp2;
assign i2c_pre_state_vpp_drv1112 = (CPU_SEL2 & CPU_SEL1 & CPU_SEL0) ? i2c_pre_state_vpp1: i2c_pre_state_vpp2;
assign i2c_state_vpp_drv1112 = (CPU_SEL2 & CPU_SEL1 & CPU_SEL0) ? i2c_state_vpp1: i2c_state_vpp2;
assign i2c_slave_addr_vpp_drv1112 = (CPU_SEL2 & CPU_SEL1 & CPU_SEL0) ? i2c_slave_addr_vpp1: i2c_slave_addr_vpp2;
/***** SGPIO module *****/
wire [3:0] drive03_fault;
wire [3:0] drive03_active;
wire [3:0] drive03_rebuild;
wire [3:0] drive03_locate;
wire [3:0] drive47_fault;
wire [3:0] drive47_active;
wire [3:0] drive47_rebuild;
wire [3:0] drive47_locate;
wire [3:0] drive811_fault;
wire [3:0] drive811_active;
wire [3:0] drive811_rebuild;
wire [3:0] drive811_locate;
/***** assignment *****/
assign REDRIVER_EN1_N = 1'b0;
assign REDRIVER_EN2_N = 1'b0;
assign REDRIVER_EN3_N = 1'b0;
assign REDRIVER_EN4_N = 1'b0;
assign REDRIVER_EN5_N = 1'b0;
assign REDRIVER_EN6_N = 1'b0;
assign REDRIVER_EN7_N = 1'b0;
assign REDRIVER_EN8_N = 1'b0;
assign REDRIVER_EN9_N = 1'b0;
assign REDRIVER_EN10_N = 1'b0;
assign REDRIVER_EN11_N = 1'b0;
assign REDRIVER_EN12_N = 1'b0;
/***** Dr Present *****/
assign DRIVE1_PRSNT = (IfDet1_N | PRSNT1_N); //SAS DRIVE
assign DRIVE2_PRSNT = (IfDet2_N | PRSNT2_N); //SAS DRIVE
assign DRIVE3_PRSNT = (IfDet3_N | PRSNT3_N);assign DRIVE4_PRSNT = (IfDet4_N | PRSNT4_N);
assign DRIVE5_PRSNT = (IfDet5_N | PRSNT5_N);
assign DRIVE6_PRSNT = (IfDet6_N | PRSNT6_N);
assign DRIVE7_PRSNT = (IfDet7_N | PRSNT7_N);
assign DRIVE8_PRSNT = (IfDet8_N | PRSNT8_N);
assign DRIVE9_PRSNT = (IfDet9_N | PRSNT9_N);
assign DRIVE10_PRSNT = (IfDet10_N | PRSNT10_N);
assign DRIVE11_PRSNT = (IfDet11_N | PRSNT11_N);
assign DRIVE12_PRSNT = (IfDet12_N | PRSNT12_N);
assign NVMe_1_PRESENT = (~PRSNT1_N | IfDet1_N);
assign NVMe_2_PRESENT = (~PRSNT2_N | IfDet2_N);
assign NVMe_3_PRESENT = (~PRSNT3_N | IfDet3_N);
assign NVMe_4_PRESENT = (~PRSNT4_N | IfDet4_N);assign NVMe_5_PRESENT = (~PRSNT5_N | IfDet5_N);
assign NVMe_6_PRESENT = (~PRSNT6_N | IfDet6_N);
assign NVMe_7_PRESENT = (~PRSNT7_N | IfDet7_N);
assign NVMe_8_PRESENT = (~PRSNT8_N | IfDet8_N);assign NVMe_9_PRESENT = (~PRSNT9_N | IfDet9_N);
assign NVMe_10_PRESENT = (~PRSNT10_N | IfDet10_N);
assign NVMe_11_PRESENT = (~PRSNT11_N | IfDet11_N);
assign NVMe_12_PRESENT = (~PRSNT12_N | IfDet12_N);
/***** LED CONTROL *****/
assign NVMe_LEDR1 = NVMe1_LED_R | SAS_DRV1_FAIL_LED;
assign NVMe_LEDG1 = NVMe1_LED_G | SAS_DRV1_ACT_LED;
assign NVMe_LEDR2 = NVMe2_LED_R | SAS_DRV2_FAIL_LED;
assign NVMe_LEDG2 = NVMe2_LED_G | SAS_DRV2_ACT_LED;
assign NVMe_LEDR3 = NVMe3_LED_R | SAS_DRV3_FAIL_LED;
assign NVMe_LEDG3 = NVMe3_LED_G | SAS_DRV3_ACT_LED;
assign NVMe_LEDR4 = NVMe4_LED_R | SAS_DRV4_FAIL_LED;
assign NVMe_LEDG4 = NVMe4_LED_G | SAS_DRV4_ACT_LED;
assign NVMe_LEDR5 = NVMe5_LED_R | SAS_DRV5_FAIL_LED;
assign NVMe_LEDG5 = NVMe5_LED_G | SAS_DRV5_ACT_LED;
assign NVMe_LEDR6 = NVMe6_LED_R | SAS_DRV6_FAIL_LED;
assign NVMe_LEDG6 = NVMe6_LED_G | SAS_DRV6_ACT_LED;
assign NVMe_LEDR7 = NVMe7_LED_R | SAS_DRV7_FAIL_LED;
assign NVMe_LEDG7 = NVMe7_LED_G | SAS_DRV7_ACT_LED;
assign NVMe_LEDR8 = NVMe8_LED_R | SAS_DRV8_FAIL_LED;
assign NVMe_LEDG8 = NVMe8_LED_G | SAS_DRV8_ACT_LED;
assign NVMe_LEDR9 = NVMe9_LED_R | SAS_DRV9_FAIL_LED;
assign NVMe_LEDG9 = NVMe9_LED_G | SAS_DRV9_ACT_LED;
assign NVMe_LEDR10 = NVMe10_LED_R | SAS_DRV10_FAIL_LED;
assign NVMe_LEDG10 = NVMe10_LED_G | SAS_DRV10_ACT_LED;
assign NVMe_LEDR11 = NVMe11_LED_R | SAS_DRV11_FAIL_LED;
assign NVMe_LEDG11 = NVMe11_LED_G | SAS_DRV11_ACT_LED;
assign NVMe_LEDR12 = NVMe12_LED_R | SAS_DRV12_FAIL_LED;
assign NVMe_LEDG12 = NVMe12_LED_G | SAS_DRV12_ACT_LED;
/***** VPP SLAVE ADDRESS *****/
wire [6:0] correct_vpp1;
wire [6:0] correct_vpp2;
wire [6:0] correct_vpp3;
wire [6:0] correct_vpp4;
wire [6:0] correct_vpp5;
wire [6:0] correct_vpp6;
assign correct_vpp1 = 7'b0100000;assign correct_vpp2 = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100000: 7'b0100001;
assign correct_vpp3 = (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100000: ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100001: 7'b0100010);
assign correct_vpp4 = (~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? 7'b0100000: ((CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100001: ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100010: 7'b0100011));
assign correct_vpp5 = (CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? 7'b0100000: ((~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? 7'b0100001: ((CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100010: ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100011: 7'b0100100)));
assign correct_vpp6 = (~CPU_SEL0 & CPU_SEL1 & CPU_SEL2) ? 7'b0100000: ((CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? 7'b0100001: ((~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? 7'b0100010: ((CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100011: ((~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? 7'b0100100: 7'b0100101))));
assign VPP2_SCL_IN = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? VPP_SCL3: ((CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? VPP_SCL5: ((~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? VPP_SCL7: ((CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? VPP_SCL9: ((~CPU_SEL0 & CPU_SEL1 & CPU_SEL2) ? VPP_SCL11: 1'b1))));
assign VPP2_SDA_IN = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? VPP_SDA3: ((CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? VPP_SDA5: ((~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? VPP_SDA7: ((CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? VPP_SDA9: ((~CPU_SEL0 & CPU_SEL1 & CPU_SEL2) ? VPP_SDA11: 1'b1))));
assign VPP_SDA1 = (~sda_control_vpp1) ? 1'b0: 1'bz;
assign VPP_SDA3 = (~CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? (~sda_control_vpp2 ? 1'b0: 1'bz): (1'bz);
assign VPP_SDA5 = (CPU_SEL0 & CPU_SEL1 & ~CPU_SEL2) ? (~sda_control_vpp2 ? 1'b0: 1'bz): (1'bz);
assign VPP_SDA7 = (~CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? (~sda_control_vpp2 ? 1'b0: 1'bz): (1'bz);
assign VPP_SDA9 = (CPU_SEL0 & ~CPU_SEL1 & CPU_SEL2) ? (~sda_control_vpp2 ? 1'b0: 1'bz): (1'bz);
assign VPP_SDA11 = (~CPU_SEL0 & CPU_SEL1 & CPU_SEL2) ? (~sda_control_vpp2 ? 1'b0: 1'bz): (1'bz);
/***** NVMe RST *****/
assign NVMe1_RSTA_N = pe_rst_deglitch & ~STR[0];
assign NVMe2_RSTA_N = pe_rst_deglitch & ~STR[1];
assign NVMe3_RSTA_N = pe_rst_deglitch & ~STR[2];
assign NVMe4_RSTA_N = pe_rst_deglitch & ~STR[3];
assign NVMe5_RSTA_N = pe_rst_deglitch & ~STR[4];
assign NVMe6_RSTA_N = pe_rst_deglitch & ~STR[5];
assign NVMe7_RSTA_N = pe_rst_deglitch & ~STR[6];
assign NVMe8_RSTA_N = pe_rst_deglitch & ~STR[7];
assign NVMe9_RSTA_N = pe_rst_deglitch & ~STR[8];
assign NVMe10_RSTA_N = pe_rst_deglitch & ~STR[9];
assign NVMe11_RSTA_N = pe_rst_deglitch & ~STR[10];
assign NVMe12_RSTA_N = pe_rst_deglitch & ~STR[11];
/***** RST module *****/
reset_delitch reset_delitch_inst01(
.rst (RST_CPLD),
.pe_rst (PE1_RSTA_N),
.clk (cpld_53m_clk),
.rst_delitch (rst_delitch),
.pe_rst_deglitch (pe_rst_deglitch)
);
/***** OSC module *****/
defparam OSCH_inst.NOM_FREQ = "26.60";
OSCH OSCH_inst( 
.STDBY (1'b0),
.OSC   (cpld_26m_clk),
.SEDSTDBY ()
);
/***** CLKDV module *****/
clock_section_minus clock_section_minus_inst(
.cpld_50m_clk (cpld_26m_clk),
.cpld_rst_n_50m (rst_delitch),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
.clk_en_1k (clk_en_1k),
.clk_3hz (clk_3hz),
.clk_500 (clk_500)
);
/***** I2C BMC module *****/
i2c_slave i2c_slave_inst01(
.rst (rst_delitch),
.clk (cpld_26m_clk),
.i2c_scl (BMC_SMCLK),
.i2c_sda (BMC_SMDAT),
.sda_control (sda_control_bmc),
.i2c_dataout (data_in_bmc),
.i2c_datain_latch (i2c_datain_latch_bmc),
.i2c_pre_state (i2c_pre_state_bmc),
.i2c_state (i2c_state_bmc),
.i2c_slave_addr (i2c_slave_addr_bmc),
.I2C_SLAVE_ADDRESS1 (7'b0110011),
.I2C_SLAVE_ADDRESS2 (7'b0110000),
.I2C_SLAVE_ADDRESS3 (7'b0110011),
.I2C_SLAVE_ADDRESS4 (7'b0110000),
.I2C_SLAVE_ADDRESS5 (7'b0110011),
.I2C_SLAVE_ADDRESS6 (7'b0110000),
.i2c_scl_falling_edge (neg),
.switch_direction (switch_direction)
);
i2c_mem i2c_mem_inst01(
.rd_lock_data (data_in_bmc),
.data_out (i2c_datain_latch_bmc),
.r_w (i2c_slave_addr_bmc[0]),
.sm_state (i2c_state_bmc),
.pre_sm_state (i2c_pre_state_bmc),
.rst_sync_clk (rst_delitch),
.cpld_internal_clk (cpld_26m_clk),
.NVMe_1_PRESENT (nvme_1_present),
.NVMe_2_PRESENT (nvme_2_present),
.NVMe_3_PRESENT (nvme_3_present),
.NVMe_4_PRESENT (nvme_4_present),
.NVMe_5_PRESENT (nvme_5_present),
.NVMe_6_PRESENT (nvme_6_present),
.NVMe_7_PRESENT (nvme_7_present),
.NVMe_8_PRESENT (nvme_8_present),
.NVMe_9_PRESENT (nvme_9_present),
.NVMe_10_PRESENT (nvme_10_present),
.NVMe_11_PRESENT (nvme_11_present),
.NVMe_12_PRESENT (nvme_12_present),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
.clk_500 (clk_500),
.NVMe1_LED_R (NVMe1_LED_R),
.NVMe1_LED_G (NVMe1_LED_G),
.NVMe2_LED_R (NVMe2_LED_R),
.NVMe2_LED_G (NVMe2_LED_G),
.NVMe3_LED_R (NVMe3_LED_R),
.NVMe3_LED_G (NVMe3_LED_G),
.NVMe4_LED_R (NVMe4_LED_R),
.NVMe4_LED_G (NVMe4_LED_G),
.NVMe5_LED_R (NVMe5_LED_R),
.NVMe5_LED_G (NVMe5_LED_G),
.NVMe6_LED_R (NVMe6_LED_R),
.NVMe6_LED_G (NVMe6_LED_G),
.NVMe7_LED_R (NVMe7_LED_R),
.NVMe7_LED_G (NVMe7_LED_G),
.NVMe8_LED_R (NVMe8_LED_R),
.NVMe8_LED_G (NVMe8_LED_G),
.NVMe9_LED_R (NVMe9_LED_R),
.NVMe9_LED_G (NVMe9_LED_G),
.NVMe10_LED_R (NVMe10_LED_R),
.NVMe10_LED_G (NVMe10_LED_G),
.NVMe11_LED_R (NVMe11_LED_R),
.NVMe11_LED_G (NVMe11_LED_G),
.NVMe12_LED_R (NVMe12_LED_R),
.NVMe12_LED_G (NVMe12_LED_G),
.clk_en_1k (clk_en_1k),
.clk_3hz (clk_3hz),
.Enable_disable_VMD1 (Enable_disable_VMD1),
.Enable_disable_VMD2 (),
.PWRLED_port0 (PWRLED_port0_VPP1),
.PWRLED_port1 (PWRLED_port1_VPP1),
.PWRLED_port2 (PWRLED_port0_VPP2),
.PWRLED_port3 (PWRLED_port1_VPP2),
.PWRLED_port4 (PWRLED_port0_VPP3),
.PWRLED_port5 (PWRLED_port1_VPP3),
.PWRLED_port6 (PWRLED_port0_VPP4),
.PWRLED_port7 (PWRLED_port1_VPP4),
.PWRLED_port8 (PWRLED_port0_VPP5),
.PWRLED_port9 (PWRLED_port1_VPP5),
.PWRLED_port10 (PWRLED_port0_VPP6),
.PWRLED_port11 (PWRLED_port1_VPP6),
.PWREN_N_port0 (PWREN_N_port0_VPP1),
.PWREN_N_port1 (PWREN_N_port1_VPP1),
.PWREN_N_port2 (PWREN_N_port0_VPP2),
.PWREN_N_port3 (PWREN_N_port1_VPP2),
.PWREN_N_port4 (PWREN_N_port0_VPP3),
.PWREN_N_port5 (PWREN_N_port1_VPP3),
.PWREN_N_port6 (PWREN_N_port0_VPP4),
.PWREN_N_port7 (PWREN_N_port1_VPP4),
.PWREN_N_port8 (PWREN_N_port0_VPP5),
.PWREN_N_port9 (PWREN_N_port1_VPP5),
.PWREN_N_port10 (PWREN_N_port0_VPP6),
.PWREN_N_port11 (PWREN_N_port1_VPP6),
.button (BTN),
.STR (STR),
.switch1_enable_control (switch1_enable_control),
.switch2_enable_control (switch2_enable_control),
.switch3_enable_control (switch3_enable_control),
.switch4_enable_control (switch4_enable_control),
.switch5_enable_control (switch5_enable_control),
.switch6_enable_control (switch6_enable_control),
.switch7_enable_control (switch7_enable_control),
.switch8_enable_control (switch8_enable_control),
.switch9_enable_control (switch9_enable_control),
.switch10_enable_control (switch10_enable_control),
.switch11_enable_control (switch11_enable_control),
.switch12_enable_control (switch12_enable_control),
.pwd (pwd)
);
/***** I2C VPP module *****/
i2c_slave i2c_slave_inst02 (
.rst (rst_delitch),
.clk (cpld_26m_clk),
.i2c_scl (VPP_SCL1),
.i2c_sda (VPP_SDA1),
.sda_control (sda_control_vpp1),
.i2c_dataout (data_in_vpp1),
.i2c_datain_latch (i2c_datain_latch_vpp1),
.i2c_pre_state (i2c_pre_state_vpp1),
.i2c_state (i2c_state_vpp1),
.i2c_slave_addr (i2c_slave_addr_vpp1),
.I2C_SLAVE_ADDRESS1 (7'b0100000),
.I2C_SLAVE_ADDRESS2 (7'b0100001),
.I2C_SLAVE_ADDRESS3 (7'b0100010),
.I2C_SLAVE_ADDRESS4 (7'b0100011),
.I2C_SLAVE_ADDRESS5 (7'b0100100),
.I2C_SLAVE_ADDRESS6 (7'b0100101),
.i2c_scl_falling_edge (),
.switch_direction ()
);
/***** I2C VPP module *****/
i2c_slave i2c_slave_inst03 (
.rst (rst_delitch),
.clk (cpld_26m_clk),
.i2c_scl (VPP2_SCL_IN),
.i2c_sda (VPP2_SDA_IN),
.sda_control (sda_control_vpp2),
.i2c_dataout (data_in_vpp2),
.i2c_datain_latch (i2c_datain_latch_vpp2),
.i2c_pre_state (i2c_pre_state_vpp2),
.i2c_state (i2c_state_vpp2),
.i2c_slave_addr (i2c_slave_addr_vpp2),
.I2C_SLAVE_ADDRESS1 (7'b0100000),
.I2C_SLAVE_ADDRESS2 (7'b0100001),
.I2C_SLAVE_ADDRESS3 (7'b0100010),
.I2C_SLAVE_ADDRESS4 (7'b0100011),
.I2C_SLAVE_ADDRESS5 (7'b0100100),
.I2C_SLAVE_ADDRESS6 (7'b0100101),
.i2c_scl_falling_edge (),
.switch_direction ()
);
/***** I2C MEM MAP *****/
i2c_mem_vpp_new2 i2c_mem_vpp_new2_inst01 (
.rd_lock_data (data_in_vpp1),
.addr_in (i2c_slave_addr_vpp1[7:1]),
.data_out (i2c_datain_latch_vpp1),
.r_w (i2c_slave_addr_vpp1[0]),
.sm_state (i2c_state_vpp1),
.pre_sm_state (i2c_pre_state_vpp1),
.rst_sync_clk (rst_delitch),
.cpld_internal_clk (cpld_26m_clk),
.PWREN_N_port0 (PWREN_N_port0_VPP1),
.PWREN_N_port1 (PWREN_N_port1_VPP1),
.ATNLED_port0 (ATNLED_port0_VPP1),
.PWRLED_port0 (PWRLED_port0_VPP1),
.ATNLED_port1 (ATNLED_port1_VPP1),
.PWRLED_port1 (PWRLED_port1_VPP1),
.NVMe_1_PRESENT (nvme_1_present),
.NVMe_2_PRESENT (nvme_2_present),
.button ({BTN[1],BTN[0]}),
.correct_address (correct_vpp1)
);
i2c_mem_vpp_new2 i2c_mem_vpp_new2_inst23 (
.rd_lock_data (data_in_vpp_drv34),
.addr_in (i2c_slave_addr_vpp_drv34[7:1]),
.data_out (i2c_datain_latch_vpp_drv34),
.r_w (i2c_slave_addr_vpp_drv34[0]),
.sm_state (i2c_state_vpp_drv34),
.pre_sm_state (i2c_pre_state_vpp_drv34),
.rst_sync_clk (rst_delitch),
.cpld_internal_clk (cpld_26m_clk),
.PWREN_N_port0 (PWREN_N_port0_VPP2),
.PWREN_N_port1 (PWREN_N_port1_VPP2),
.ATNLED_port0 (ATNLED_port0_VPP2),
.PWRLED_port0 (PWRLED_port0_VPP2),
.ATNLED_port1 (ATNLED_port1_VPP2),
.PWRLED_port1 (PWRLED_port1_VPP2),
.NVMe_1_PRESENT (nvme_3_present),
.NVMe_2_PRESENT (nvme_4_present),
.button ({BTN[3],BTN[2]}),
.correct_address (correct_vpp2)
);
i2c_mem_vpp_new2 i2c_mem_vpp_new2_inst45 (
.rd_lock_data (data_in_vpp_drv56),
.addr_in (i2c_slave_addr_vpp_drv56[7:1]),
.data_out (i2c_datain_latch_vpp_drv56),
.r_w (i2c_slave_addr_vpp_drv56[0]),
.sm_state (i2c_state_vpp_drv56),
.pre_sm_state (i2c_pre_state_vpp_drv56),
.rst_sync_clk (rst_delitch),
.cpld_internal_clk (cpld_26m_clk),
.PWREN_N_port0 (PWREN_N_port0_VPP3),
.PWREN_N_port1 (PWREN_N_port1_VPP3),
.ATNLED_port0 (ATNLED_port0_VPP3),
.PWRLED_port0 (PWRLED_port0_VPP3),
.ATNLED_port1 (ATNLED_port1_VPP3),
.PWRLED_port1 (PWRLED_port1_VPP3),
.NVMe_1_PRESENT (nvme_5_present),
.NVMe_2_PRESENT (nvme_6_present),
.button ({BTN[5],BTN[4]}),
.correct_address (correct_vpp3)
);
i2c_mem_vpp_new2 i2c_mem_vpp_new2_inst67 (
.rd_lock_data (data_in_vpp_drv78),
.addr_in (i2c_slave_addr_vpp_drv78[7:1]),
.data_out (i2c_datain_latch_vpp_drv78),
.r_w (i2c_slave_addr_vpp_drv78[0]),
.sm_state (i2c_state_vpp_drv78),
.pre_sm_state (i2c_pre_state_vpp_drv78),
.rst_sync_clk (rst_delitch),
.cpld_internal_clk (cpld_26m_clk),
.PWREN_N_port0 (PWREN_N_port0_VPP4),
.PWREN_N_port1 (PWREN_N_port1_VPP4),
.ATNLED_port0 (ATNLED_port0_VPP4),
.PWRLED_port0 (PWRLED_port0_VPP4),
.ATNLED_port1 (ATNLED_port1_VPP4),
.PWRLED_port1 (PWRLED_port1_VPP4),
.NVMe_1_PRESENT (nvme_7_present),
.NVMe_2_PRESENT (nvme_8_present),
.button ({BTN[7],BTN[6]}),
.correct_address (correct_vpp4)
);
i2c_mem_vpp_new2 i2c_mem_vpp_new2_inst89 (
.rd_lock_data (data_in_vpp_drv910),
.addr_in (i2c_slave_addr_vpp_drv910[7:1]),
.data_out (i2c_datain_latch_vpp_drv910),
.r_w (i2c_slave_addr_vpp_drv910[0]),
.sm_state (i2c_state_vpp_drv910),
.pre_sm_state (i2c_pre_state_vpp_drv910),
.rst_sync_clk (rst_delitch),
.cpld_internal_clk (cpld_26m_clk),
.PWREN_N_port0 (PWREN_N_port0_VPP5),
.PWREN_N_port1 (PWREN_N_port1_VPP5),
.ATNLED_port0 (ATNLED_port0_VPP5),
.PWRLED_port0 (PWRLED_port0_VPP5),
.ATNLED_port1 (ATNLED_port1_VPP5),
.PWRLED_port1 (PWRLED_port1_VPP5),
.NVMe_1_PRESENT (nvme_9_present),
.NVMe_2_PRESENT (nvme_10_present),
.button ({BTN[9],BTN[8]}),
.correct_address (correct_vpp5)
);
i2c_mem_vpp_new2 i2c_mem_vpp_new2_inst1011 (
.rd_lock_data (data_in_vpp_drv1112),
.addr_in (i2c_slave_addr_vpp_drv1112[7:1]),
.data_out (i2c_datain_latch_vpp_drv1112),
.r_w (i2c_slave_addr_vpp_drv1112[0]),
.sm_state (i2c_state_vpp_drv1112),
.pre_sm_state (i2c_pre_state_vpp_drv1112),
.rst_sync_clk (rst_delitch),
.cpld_internal_clk (cpld_26m_clk),
.PWREN_N_port0 (PWREN_N_port0_VPP6),
.PWREN_N_port1 (PWREN_N_port1_VPP6),
.ATNLED_port0 (ATNLED_port0_VPP6),
.PWRLED_port0 (PWRLED_port0_VPP6),
.ATNLED_port1 (ATNLED_port1_VPP6),
.PWRLED_port1 (PWRLED_port1_VPP6),
.NVMe_1_PRESENT (nvme_11_present),
.NVMe_2_PRESENT (nvme_12_present),
.button ({BTN[11],BTN[10]}),
.correct_address (correct_vpp6)
);
/***** SGPIO interface *****/
sgpio sgpio_inst01(
.rst (rst_delitch),
.clk (cpld_26m_clk),
.sload (SGPIO_LOAD1),
.sclk (SGPIO_CLK1),
.sdout (SGPIO_DOUT1),
.drive_fault (drive03_fault),
.drive_active (drive03_active),
.drive_rebuild (drive03_rebuild),
.drive_locate (drive03_locate)
);
parameter NVMe = 0;
parameter SAS = 1;
sgpio_led #(NVMe) sgpio_led_inst01(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive03_fault[0]),
.active (drive03_active[0]),
.locate (drive03_locate[0]),
.rebuild (drive03_rebuild[0]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV1_ACT_LED),
.red_led (SAS_DRV1_FAIL_LED),
.drive_present (drive1_prsnt)
);
debounce debounce_inst01(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE1_PRSNT),
.OUT (drive1_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst02(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive03_fault[1]),
.active (drive03_active[1]),
.locate (drive03_locate[1]),
.rebuild (drive03_rebuild[1]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV2_ACT_LED),
.red_led (SAS_DRV2_FAIL_LED),
.drive_present (drive2_prsnt)
);
debounce debounce_inst02(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE2_PRSNT),
.OUT (drive2_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst03(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive03_fault[2]),
.active (drive03_active[2]),
.locate (drive03_locate[2]),
.rebuild (drive03_rebuild[2]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV3_ACT_LED),
.red_led (SAS_DRV3_FAIL_LED),
.drive_present (drive3_prsnt)
);
debounce debounce_inst03(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE3_PRSNT),
.OUT (drive3_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst04(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive03_fault[3]),
.active (drive03_active[3]),
.locate (drive03_locate[3]),
.rebuild (drive03_rebuild[3]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV4_ACT_LED),
.red_led (SAS_DRV4_FAIL_LED),
.drive_present (drive4_prsnt)
);
debounce debounce_inst04(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE4_PRSNT),
.OUT (drive4_prsnt)
);
sgpio sgpio_inst02(
.rst (rst_delitch),
.clk (cpld_26m_clk),
.sload (SGPIO_LOAD2),
.sclk (SGPIO_CLK2),
.sdout (SGPIO_DOUT2),
.drive_fault (drive47_fault),
.drive_active (drive47_active),
.drive_rebuild (drive47_rebuild),
.drive_locate (drive47_locate)
);
sgpio_led #(NVMe) sgpio_led_inst05(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive47_fault[0]),
.active (drive47_active[0]),
.locate (drive47_locate[0]),
.rebuild (drive47_rebuild[0]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV5_ACT_LED),
.red_led (SAS_DRV5_FAIL_LED),
.drive_present (drive5_prsnt)
);
debounce debounce_inst05(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE5_PRSNT),
.OUT (drive5_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst06(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive47_fault[1]),
.active (drive47_active[1]),
.locate (drive47_locate[1]),
.rebuild (drive47_rebuild[1]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV6_ACT_LED),
.red_led (SAS_DRV6_FAIL_LED),
.drive_present (drive6_prsnt)
);
debounce debounce_inst06(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE6_PRSNT),
.OUT (drive6_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst07(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive47_fault[2]),
.active (drive47_active[2]),
.locate (drive47_locate[2]),
.rebuild (drive47_rebuild[2]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV7_ACT_LED),
.red_led (SAS_DRV7_FAIL_LED),
.drive_present (drive7_prsnt)
);
debounce debounce_inst07(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE7_PRSNT),
.OUT (drive7_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst08(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive47_fault[3]),
.active (drive47_active[3]),
.locate (drive47_locate[3]),
.rebuild (drive47_rebuild[3]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV8_ACT_LED),
.red_led (SAS_DRV8_FAIL_LED),
.drive_present (drive8_prsnt)
);
debounce debounce_inst08(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE8_PRSNT),
.OUT (drive8_prsnt)
);
sgpio sgpio_inst03(
.rst (rst_delitch),
.clk (cpld_26m_clk),
.sload (SGPIO_LOAD3),
.sclk (SGPIO_CLK3),
.sdout (SGPIO_DOUT3),
.drive_fault (drive811_fault),
.drive_active (drive811_active),
.drive_rebuild (drive811_rebuild),
.drive_locate (drive811_locate)
);
sgpio_led #(NVMe) sgpio_led_inst09(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive811_fault[0]),
.active (drive811_active[0]),
.locate (drive811_locate[0]),
.rebuild (drive811_rebuild[0]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV9_ACT_LED),
.red_led (SAS_DRV9_FAIL_LED),
.drive_present (drive9_prsnt)
);
debounce debounce_inst09(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE9_PRSNT),
.OUT (drive9_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst10(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive811_fault[1]),
.active (drive811_active[1]),
.locate (drive811_locate[1]),
.rebuild (drive811_rebuild[1]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV10_ACT_LED),
.red_led (SAS_DRV10_FAIL_LED),
.drive_present (drive10_prsnt)
);
debounce debounce_inst10(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE10_PRSNT),
.OUT (drive10_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst11(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive811_fault[2]),
.active (drive811_active[2]),
.locate (drive811_locate[2]),
.rebuild (drive811_rebuild[2]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV11_ACT_LED),
.red_led (SAS_DRV11_FAIL_LED),
.drive_present (drive11_prsnt)
);
debounce debounce_inst11(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE11_PRSNT),
.OUT (drive11_prsnt)
);
sgpio_led #(NVMe) sgpio_led_inst12(
.rst (rst_delitch),
//.clk (cpld_53m_clk),
.fault (drive811_fault[3]),
.active (drive811_active[3]),
.locate (drive811_locate[3]),
.rebuild (drive811_rebuild[3]),
.clk_250ms (clk_250ms),
.clk_500ms (clk_500ms),
.clk_1s (clk_1s),
//.clk_en_1k (clk_en_1k),
.green_led (SAS_DRV12_ACT_LED),
.red_led (SAS_DRV12_FAIL_LED),
.drive_present (drive12_prsnt)
);
debounce debounce_inst12(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (DRIVE12_PRSNT),
.OUT (drive12_prsnt)
);
debounce debounce_inst13(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_1_PRESENT),
.OUT (nvme_1_present)
);
debounce debounce_inst14(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_2_PRESENT),
.OUT (nvme_2_present)
);
debounce debounce_inst15(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_3_PRESENT),
.OUT (nvme_3_present)
);
debounce debounce_inst16(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_4_PRESENT),
.OUT (nvme_4_present)
);
debounce debounce_inst17(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_5_PRESENT),
.OUT (nvme_5_present)
);
debounce debounce_inst18(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_6_PRESENT),
.OUT (nvme_6_present)
);
debounce debounce_inst19(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_7_PRESENT),
.OUT (nvme_7_present)
);
debounce debounce_inst20(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_8_PRESENT),
.OUT (nvme_8_present)
);
debounce debounce_inst21(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_9_PRESENT),
.OUT (nvme_9_present)
);
debounce debounce_inst22(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_10_PRESENT),
.OUT (nvme_10_present)
);
debounce debounce_inst23(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_11_PRESENT),
.OUT (nvme_11_present)
);
debounce debounce_inst24(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.ck_enable (clk_en_1k),
.IN (NVMe_12_PRESENT),
.OUT (nvme_12_present)
);
assign SMCLK1 = (~sclk1_oen) ? 1'b0: 1'bz;
assign SMCLK2 = (~sclk2_oen) ? 1'b0: 1'bz;
assign SMCLK3 = (~sclk3_oen) ? 1'b0: 1'bz;
assign SMCLK4 = (~sclk4_oen) ? 1'b0: 1'bz;
assign SMCLK5 = (~sclk5_oen) ? 1'b0: 1'bz;
assign SMCLK6 = (~sclk6_oen) ? 1'b0: 1'bz;
assign SMCLK7 = (~sclk7_oen) ? 1'b0: 1'bz;
assign SMCLK8 = (~sclk8_oen) ? 1'b0: 1'bz;
assign SMCLK9 = (~sclk9_oen) ? 1'b0: 1'bz;
assign SMCLK10 = (~sclk10_oen) ? 1'b0: 1'bz;
assign SMCLK11 = (~sclk11_oen) ? 1'b0: 1'bz;
assign SMCLK12 = (~sclk12_oen) ? 1'b0: 1'bz;
i2c_switch_ctrl i2c_switch_ctrl_inst(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.i2c_sda (BMC_SMDAT),
.i2c_scl (BMC_SMCLK),
.sda_slave1 (SMDAT1),
.sda_slave2 (SMDAT2),
.sda_slave3 (SMDAT3),
.sda_slave4 (SMDAT4),
.sda_slave5 (SMDAT5),
.sda_slave6 (SMDAT6),
.sda_slave7 (SMDAT7),
.sda_slave8 (SMDAT8),
.sda_slave9 (SMDAT9),
.sda_slave10 (SMDAT10),
.sda_slave11 (SMDAT11),
.sda_slave12 (SMDAT12),
.SMCLK1 (SMCLK1),
.SMCLK2 (SMCLK2),
.SMCLK3 (SMCLK3),
.SMCLK4 (SMCLK4),
.SMCLK5 (SMCLK5),
.SMCLK6 (SMCLK6),
.SMCLK7 (SMCLK7),
.SMCLK8 (SMCLK8),
.SMCLK9 (SMCLK9),
.SMCLK10 (SMCLK10),
.SMCLK11 (SMCLK11),
.SMCLK12 (SMCLK12),
.sclk1_oen (sclk1_oen),
.sclk2_oen (sclk2_oen),
.sclk3_oen (sclk3_oen),
.sclk4_oen (sclk4_oen),
.sclk5_oen (sclk5_oen),
.sclk6_oen (sclk6_oen),
.sclk7_oen (sclk7_oen),
.sclk8_oen (sclk8_oen),
.sclk9_oen (sclk9_oen),
.sclk10_oen (sclk10_oen),
.sclk11_oen (sclk11_oen),
.sclk12_oen (sclk12_oen),
.switch1_enable_control (switch1_enable_control),
.switch2_enable_control (switch2_enable_control),
.switch3_enable_control (switch3_enable_control),
.switch4_enable_control (switch4_enable_control),
.switch5_enable_control (switch5_enable_control),
.switch6_enable_control (switch6_enable_control),
.switch7_enable_control (switch7_enable_control),
.switch8_enable_control (switch8_enable_control),
.switch9_enable_control (switch9_enable_control),
.switch10_enable_control (switch10_enable_control),
.switch11_enable_control (switch11_enable_control),
.switch12_enable_control (switch12_enable_control),
.neg (neg),
.switch_direction (switch_direction),
.state (state)
);
assign TEMPSEN_DAT = (~sda_oen) ? 1'b0: 1'bz;
assign TEMPSEN_CLK = (~scl_oen) ? 1'b0: 1'bz;
i2c_master i2c_master_inst01(
.clk (cpld_26m_clk),
.rst (rst_delitch),
.i2cclkrate (8'd144),
.deviceaddress (7'b1001100),
.Registeraddress (8'b0),
.sda_oen (sda_oen),
.scl_oen (scl_oen),
.i2c_clk (TEMPSEN_CLK),
.i2c_sda (TEMPSEN_DAT)
);
endmodule 