`timescale 1ns/1ps

module NAND_FLASH_INTERFACE(
input clk, //system clock
input rst, // system reset
output CLEo, //command latch Enable, goes to nand flash
output ALEo, //address latch Enable, goes to nand flash
output CE_N, //chip_select goes to nand flash, pull low first
output RE_N, //read_Enable goes to nand flash, tREA timing after falling edge of RE_N data would be valid
output WE_N,
output[7:0] DIO,
output reg data_strobe,
output reg [15:0] cycle_cnt,
input Readybusy
);

// Internal register for signal output to NAND FLASH
wire r_b;

reg ce_int;
reg cle_int;
reg ale_int;
reg re_int;
reg we_int;

reg clear;
reg [4:0] state;
reg [11:0] total_cnt;
reg [7:0] data_latch;
reg timer_enable; // timer enable signal countdown to start new cycle
wire timeout_start;

localparam IDLE_DELAY_BETWEEN_CMD = 0;
localparam PRELOAD = 1;
localparam CLE_CYCLE = 2;
localparam ALE_CYCLE = 3;
localparam WRITE_CYCLE = 4;
localparam READ_CYCLE = 5;
localparam DELAY_CYCLE = 6; // For TWB and TWHR and cmd and addr

assign CLEo = cle_int;
assign ALEo = ale_int;
assign CE_N = ce_int;
assign RE_N = re_int;
assign WE_N = we_int;
assign r_b = (Readybusy == 1'b1) ? 1'b1: 1'b0;
assign DIO = data_latch;


reg [2:0] ctrl_cmd; // erase, programming, Reading
localparam ERASE = 0;
localparam PROGRAMMING = 1;
localparam READING = 2;

reg [4:0] stage; // stage for each operation
localparam CMD = 0;
localparam CMD2 = 1;
localparam CMD3 = 2;
localparam COL1ADDR = 3;
localparam COL2ADDR = 4;
localparam ROW1ADDR = 5;
localparam ROW2ADDR = 6;
localparam WRITEDATA = 7;
localparam READDATA = 8;

reg [2:0] transition;
localparam ZERO = 0;
localparam ONE = 1;
localparam TWO = 2;
localparam THREE = 3;
localparam FOUR = 4;
localparam FIVE = 5;

reg [1:0] delay_type;
reg [4:0] delay_cnt;
always@(posedge clk or negedge rst) begin
	if (~rst) begin
		cle_int <= 1'b0;
		ale_int <= 1'b0;
		ce_int <= 1'b1;
		re_int <= 1'b1;
		we_int <= 1'b1;
		timer_enable <= 1'b0;
		data_strobe <= 1'b0;
		total_cnt <= 12'b0;
		data_latch <= 8'b0;
		delay_type <= 2'b0;
		delay_cnt <= 5'b0;
		ctrl_cmd <= ERASE;
		stage <= CMD;
		state <= IDLE_DELAY_BETWEEN_CMD;
		transition <= ZERO;
		cycle_cnt <= 16'b0;
	end	
	else begin
		case(state)
			IDLE_DELAY_BETWEEN_CMD: begin
				if (r_b == 1'b1) begin
					timer_enable <= 1'b1;
					if (timeout_start) begin
					   timer_enable <= 1'b0;
					   state <= PRELOAD;
					end
				end		
			end	
			PRELOAD: begin
		        case(ctrl_cmd)
                     ERASE: begin
                        case(stage)
                            CMD: begin
                                data_latch <= 8'h60;
                                stage <= ROW1ADDR;          
                                ctrl_cmd <= ERASE;              
                                state <= CLE_CYCLE;
                            end 
                            ROW1ADDR: begin
                                data_latch <= 8'h00;
                                stage <= ROW2ADDR;
                                ctrl_cmd <= ERASE;
                                state <= ALE_CYCLE;
                            end 
                            ROW2ADDR: begin
                                data_latch <= 8'h00;
                                stage <= CMD2;
                                ctrl_cmd <= ERASE;
                                state <= ALE_CYCLE;
                            end 
                            CMD2: begin
                                data_latch <= 8'hd0;
                                stage <= CMD3;
                                ctrl_cmd <= ERASE;
                                state <= CLE_CYCLE;
                            end 
                            CMD3: begin
                                data_latch <= 8'h70;
                                stage <= READDATA;
                                ctrl_cmd <= ERASE;
                                state <= CLE_CYCLE;
                            end 
                            READDATA: begin
                                total_cnt <= 12'd1;
                                stage <= CMD;
                                ctrl_cmd <= PROGRAMMING;
                                //ctrl_cmd <= READING;
                                state <= READ_CYCLE;
                            end      
                        endcase
                     end 
                     PROGRAMMING: begin
                        case(stage)
                            CMD: begin
                                data_latch <= 8'h80;
                                stage <= COL1ADDR;
                                ctrl_cmd <= PROGRAMMING;
                                state <= CLE_CYCLE;
                            end
                            COL1ADDR: begin
                                data_latch <= 8'h00;
                                stage <= COL2ADDR;
                                ctrl_cmd <= PROGRAMMING;
                                state <= ALE_CYCLE;
                            end
                            COL2ADDR: begin
                                data_latch <= 8'h00;
                                stage <= ROW1ADDR;
                                ctrl_cmd <= PROGRAMMING;
                                state <= ALE_CYCLE;
                            end
                            ROW1ADDR: begin
                                data_latch <= 8'h04;
                                stage <= ROW2ADDR;
                                ctrl_cmd <= PROGRAMMING;
                                state <= ALE_CYCLE;
                            end
                            ROW2ADDR: begin
                                data_latch <= 8'h00;
                                stage <= WRITEDATA;
                                ctrl_cmd <= PROGRAMMING;
                                state <= ALE_CYCLE;
                            end
                            WRITEDATA: begin
                                data_latch <= 8'h55;
                                total_cnt <= 12'd128;
                                stage <= CMD2;
                                ctrl_cmd <= PROGRAMMING;
                                state <= WRITE_CYCLE;
                            end
                            CMD2: begin
                                data_latch <= 8'h10;
                                stage <= CMD3;
                                ctrl_cmd <= PROGRAMMING;
                                state <= CLE_CYCLE;
                            end
                            CMD3: begin
                                data_latch <= 8'h70;
                                stage <= READDATA;
                                ctrl_cmd <= PROGRAMMING;
                                state <= CLE_CYCLE;
                            end
                            READDATA: begin
                                total_cnt <= 12'd1;
                                stage <= CMD;
                                ctrl_cmd <= READING;
                                state <= READ_CYCLE;
                            end
                         endcase   
                     end 
                     READING: begin
                        case(stage)
                            CMD: begin
                                data_latch <= 8'h00;
                                stage <= COL1ADDR;
                                ctrl_cmd <= READING;
                                state <= CLE_CYCLE;
                            end
                            COL1ADDR: begin
                                data_latch <= 8'h00;
                                stage <= COL2ADDR;
                                ctrl_cmd <= READING;
                                state <= ALE_CYCLE;
                            end
                            COL2ADDR: begin
                                data_latch <= 8'h00;
                                stage <= ROW1ADDR;
                                ctrl_cmd <= READING;
                                state <= ALE_CYCLE;
                            end
                            ROW1ADDR: begin
                                data_latch <= 8'h05;
                                stage <= ROW2ADDR;
                                ctrl_cmd <= READING;
                                state <= ALE_CYCLE;
                            end
                            ROW2ADDR: begin
                                data_latch <= 8'h00;
                                stage <= CMD2;
                                ctrl_cmd <= READING;
                                state <= ALE_CYCLE;
                            end
                            CMD2: begin
                                data_latch <= 8'h30;
                                stage <= READDATA;
                                ctrl_cmd <= READING;
                                state <= CLE_CYCLE;
                            end
                            READDATA: begin
                                cycle_cnt <= cycle_cnt+16'b1;
                                total_cnt <= 12'd128;
                                stage <= CMD;
                                ctrl_cmd <= PROGRAMMING;
                                state <= READ_CYCLE;
                            end
                        endcase
                     end              
                endcase
            end 
            CLE_CYCLE: begin
                case(transition)
                    ZERO: begin
                        ce_int <= 1'b0;
                        transition <= ONE;
                    end
                    ONE: begin
                        cle_int <= 1'b1;
                        we_int <= 1'b0;
                        transition <= TWO;
                    end
                    TWO: begin
                        data_strobe <= 1'b1;
                        transition <= THREE;
                    end
                    THREE: begin
                        transition <= FOUR;
                    end
                    FOUR: begin
                        we_int <= 1'b1;
                        transition <= FIVE;
                    end
                    FIVE: begin
                        ce_int <= 1'b1;
                        cle_int <= 1'b0;
                        data_strobe <= 1'b0;
                        transition <= ZERO;
                        if (data_latch == 8'hd0 || data_latch == 8'h10 || data_latch == 8'h30) begin
                            delay_type <= 2'b10;
                            delay_cnt <= 5'd10;
                        end
                        else if (data_latch == 8'h70) begin
                            delay_type <= 2'b01;
                            delay_cnt <= 5'd6;
                        end
                        else begin
                            delay_type <= 2'b00;
                            delay_cnt <= 5'd2;
                        end
                        state <= DELAY_CYCLE;
                    end
                endcase
            end 
            ALE_CYCLE: begin
                case(transition)
                    ZERO: begin
                        ce_int <= 1'b0;
                        transition <= ONE;
                    end
                    ONE: begin
                        ale_int <= 1'b1;
                        we_int <= 1'b0;
                        transition <= TWO;
                    end
                    TWO: begin
                        data_strobe <= 1'b1;
                        transition <= THREE;
                    end
                    THREE: begin
                        transition <= FOUR;
                    end
                    FOUR: begin
                        we_int <= 1'b1;
                        transition <= FIVE;
                    end
                    FIVE: begin
                        ce_int <= 1'b1;
                        ale_int <= 1'b0;
                        data_strobe <= 1'b0;
                        transition <= ZERO;
                        delay_cnt <= 5'd2;
                        delay_type <= 2'b00;
                        state <= DELAY_CYCLE;
                    end
                endcase
            end 
            DELAY_CYCLE: begin
                if (delay_cnt != 5'd0) begin
                    delay_cnt <= delay_cnt-5'b1;
                end
                else begin
                    if (delay_type == 2'b10) begin
                        if (r_b == 1'b1) begin
                            state <= PRELOAD;
                        end
                    end
                    else if (delay_type == 2'b01) begin
                        if (r_b == 1'b1) begin
                            state <= PRELOAD;
                        end
                    end
                    else begin
                        state <= PRELOAD;
                    end
                end
            end
            READ_CYCLE: begin
                    case(transition)
                        ZERO: begin
                            ce_int <= 1'b0;
                            transition <= ONE;
                        end
                        ONE: begin
                            re_int <= 1'b0;
                            transition <= TWO;
                        end
                        TWO: begin
                            transition <= THREE;
                        end
                        THREE: begin
                            transition <= FOUR;
                        end
                        FOUR: begin
                            re_int <= 1'b1;
                            transition <= FIVE;
                        end
                        FIVE: begin
                            total_cnt <= total_cnt-12'd1;
                            transition <= ZERO;
                            if (total_cnt <= 12'd1) begin
                                ce_int <= 1'b1;
                                state <= IDLE_DELAY_BETWEEN_CMD;
                            end
                        end
                    endcase              
            end
            WRITE_CYCLE: begin
                case(transition)
                    ZERO: begin
                        ce_int <= 1'b0;
                        transition <= ONE;
                    end
                    ONE: begin
                        we_int <= 1'b0;
                        transition <= TWO;
                    end
                    TWO: begin
                        data_strobe <= 1'b1;
                        transition <= THREE;
                    end
                    THREE: begin
                        transition <= FOUR;
                    end
                    FOUR: begin
                        we_int <= 1'b1;
                        transition <= FIVE;
                    end
                    FIVE: begin
                        total_cnt <= total_cnt-12'd1;
                        transition <= ZERO;
                        if (total_cnt <= 12'd1) begin
                            data_strobe <= 1'b0;
                            ce_int <= 1'b1;
                            delay_cnt <= 5'd2;
                            delay_type <= 2'b00;
                            state <= DELAY_CYCLE;
                        end
                    end
                endcase
            end                
		endcase
	end
end

timer U4(
    .cpld_rst_n_50m (rst),
	.cpld_50m_clk (clk),
	.clk_en (1'b1),
	.timer_en (timer_enable),
	.time_dly (200),
	.timeout (timeout_start)
);

endmodule 