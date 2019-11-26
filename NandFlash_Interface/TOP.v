`timescale 10ns/10ns

module TOP (
    input clk_100Mhz,
    //input rst,
    output CLEo,
    output ALEo,
    output CE_N,
    output RE_N,
    output WE_N,
    input R_B,
    inout [7:0] DIO
);
    wire [7:0] DIO_INT;
    wire [15:0] cycle_cnt;
	wire data_strobe;
	wire cle_int;
	wire ale_int;
	wire ce_int;
	wire re_int;
	wire we_int;
	NAND_FLASH_INTERFACE U0(
	.clk (clk),
	.rst (rst),
	.CLEo (cle_int),
	.ALEo (ale_int),
	.CE_N (ce_int),
	.RE_N (re_int),
	.WE_N (we_int),
	.DIO (DIO_INT),
	.data_strobe (data_strobe),
	.cycle_cnt (cycle_cnt),
	.Readybusy (R_B)
	);
	clk_wiz_0 clk_wiz_0_inst (
        .clk_out1(clk),
        .clk_in1(clk_100Mhz)
    );
    clock_section_minus U1(
        .cpld_50m_clk (clk),
        .clk_output (COUT)
    );
    RST_MODULE U3(
        .rst (rst),
        .clk (COUT)
    );
    ila_0 ila_0_inst (
        .clk    (clk),
        .probe0 (DIO),
        .probe1 (CLEo),
        .probe2 (ALEo),
        .probe3 (CE_N),
        .probe4 (RE_N),
        .probe5 (WE_N),
        .probe6 (R_B),
        .probe7 (cycle_cnt)
    );
	assign DIO = (data_strobe) ? DIO_INT: 8'hz;
	assign CLEo = cle_int;
	assign ALEo = ale_int;
	assign CE_N = ce_int;
	assign RE_N = re_int;
	assign WE_N = we_int;
	endmodule