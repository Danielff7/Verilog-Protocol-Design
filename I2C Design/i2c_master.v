module i2c_master (
input clk,
input rst,
input [7:0] i2cclkrate, //133 for 100k
input [6:0] deviceaddress,
input [7:0] Registeraddress,
output sda_oen,
output scl_oen,
input i2c_clk,
input i2c_sda
);

localparam IDLE = 4'h0;
localparam ADDR = 4'h1;
localparam CMD = 4'h2;
localparam STARTRESTART = 4'h3;
localparam DATARECEIVE = 4'h4;
localparam STOP = 4'h5;
localparam ACK = 4'h6;
localparam LOW = 1'b0;
localparam HIGH = 1'b1;
reg timer_enable;
reg [1:0] bytenumber;
reg [3:0] bpcnt;
reg [3:0] state;
reg [3:0] prestate;
reg clkstate;
reg r_w;
reg [7:0] clk_counter;
reg [1:0] i2c_scl_int;
reg [1:0] i2c_scl_oen_int;
reg scl_oen_int;
reg sda_oen_int;
reg NACK;
reg [7:0] FIRST;
reg [7:0] SECOND;
assign i2c_scl_oen_rising_edge = i2c_scl_oen_int[0] & ~i2c_scl_oen_int[1];
assign i2c_scl_rising_edge = i2c_scl_int[0] & ~i2c_scl_int[1];
assign i2c_scl_falling_edge = ~i2c_scl_int[0] & i2c_scl_int[1];
assign scl_oen = (state != IDLE) ? scl_oen_int: 1'b1;
assign sda_oen = sda_oen_int;
always@(posedge clk or negedge rst) begin
	if (~rst) begin
		i2c_scl_int <= 2'b11;
		i2c_scl_oen_int <= 2'b11;
	end	
	else begin
		i2c_scl_int <= {i2c_scl_int[0],i2c_clk};
		i2c_scl_oen_int <= {i2c_scl_oen_int[0],scl_oen_int};
    end 	
end
always@(posedge clk or negedge rst) begin
	if (~rst) begin
		scl_oen_int <= 1'b1;
		clk_counter <= 7'b0;
	end	
	else begin
		if (scl_oen_int) begin
		if (i2c_clk) begin
			clk_counter <= clk_counter+7'b1;
		end
		end
        else begin
			clk_counter <= clk_counter+7'b1;
        end
		if (clk_counter == i2cclkrate) begin
			clk_counter <= 7'b0;
			scl_oen_int <= ~scl_oen_int;		
		end 	
	end 	
end 
always@(posedge clk or negedge rst) begin
	if (~rst) begin
		bpcnt <= 4'b0111;
		bytenumber <= 2'b0;
		timer_enable <= 1'b0;
		sda_oen_int <= 1'b1;
		r_w <= 1'b0;
		NACK <= 1'b1;
        state <= IDLE;
		prestate <= IDLE;
        clkstate <= LOW; 		
	end 	
	else begin
		case(state)
			IDLE: begin
				timer_enable <= 1'b1;
				bpcnt <= 4'b0111;
		        bytenumber <= 2'b0;
				sda_oen_int <= 1'b1;
				r_w <= 1'b0;
				NACK <= 1'b1;
				prestate <= IDLE;
				if (timeout && i2c_scl_oen_rising_edge) begin
					clkstate <= HIGH;
					state <= STARTRESTART;
				end	
			end	
			STARTRESTART: begin
				timer_enable <= 1'b0;
				case(clkstate)
					LOW: begin
						if (clk_counter == i2cclkrate/2) begin
							sda_oen_int <= 1'b1;	
						end
						if (i2c_scl_rising_edge) begin
							clkstate <= HIGH;
						end
					end	
					HIGH: begin
						if (clk_counter == i2cclkrate/2) begin
							sda_oen_int <= 1'b0;
						end 	
						if (i2c_scl_falling_edge) begin
							clkstate <= LOW;
							prestate <= STARTRESTART;
							state <= ADDR;
						end	
					end
				endcase 
			end
			ADDR: begin
				case(clkstate)
					LOW: begin
						if (bpcnt != 4'b0000) begin
							if (clk_counter == i2cclkrate/2) begin
								sda_oen_int <= deviceaddress[bpcnt-1];
							end						
						end
						else begin
							if (clk_counter == i2cclkrate/2) begin
								sda_oen_int <= r_w;
							end	
						end	
						if (i2c_scl_rising_edge) begin
							bpcnt <= bpcnt-4'b1;
							clkstate <= HIGH;
						end	
					end
					HIGH: begin
						if (i2c_scl_falling_edge) begin
							if (~bpcnt[3]) begin
								clkstate <= LOW;
							end
							else begin
								bpcnt <= 4'b0111;
								r_w <= ~r_w;
								clkstate <= LOW;
								prestate <= ADDR;
								state <= ACK;
							end	
						end
					end	
				endcase
			end
			ACK: begin
				if (clk_counter == i2cclkrate/4) begin
					if (prestate == ADDR || prestate == CMD) begin
						sda_oen_int <= 1'b1; //release the data line
					end
					else begin
                        sda_oen_int <= (bytenumber == 2'b0) ? 1'b0: 1'b1;
					end
				end
				if (i2c_scl_rising_edge) begin
					if (~i2c_sda) begin
						NACK <= 1'b0;
					end
					else begin
						NACK <= 1'b1;
					end	
				end 	
                if (i2c_scl_falling_edge) begin
					if (prestate == ADDR) begin
						if (r_w) begin
							if (~NACK) begin
								prestate <= ACK;
								state <= CMD;
							end
							else begin
								state <= IDLE;
							end	
						end
						else begin
							if (~NACK) begin
								prestate <= ACK;
								state <= DATARECEIVE;
							end
							else begin
								state <= IDLE;
							end	
						end	
					end	
					else if (prestate == CMD) begin
						if (~NACK) begin
							prestate <= ACK;
							state <= STARTRESTART;
						end
						else begin
							state <= IDLE;
						end	
					end
                    else if (prestate == DATARECEIVE) begin
                        if (~NACK) begin
							bytenumber <= bytenumber+2'b1;
							prestate <= ACK;
							state <= DATARECEIVE;
						end	
						else begin
							bytenumber <= 2'b0;
							prestate <= ACK;
							state <= STOP;
						end	
                    end 
                end 
			end //ACK
			CMD: begin
				case(clkstate)
					LOW: begin
						if (clk_counter == i2cclkrate/2) begin //136
							sda_oen_int <= Registeraddress[bpcnt];
						end
						if (i2c_scl_rising_edge) begin
							bpcnt <= bpcnt-4'b1;
							clkstate <= HIGH;
						end 	
					end
                    HIGH: begin
						if (i2c_scl_falling_edge) begin
							if (~bpcnt[3]) begin
								clkstate <= LOW;
							end	
							else begin
								bpcnt <= 4'b0111;
								clkstate <= LOW;
								prestate <= CMD;
								state <= ACK;
							end	
						end	
                    end					
				endcase	
			end //CMD
            DATARECEIVE: begin
				sda_oen_int <= 1'b1;
				case(clkstate)
					LOW: begin
						if (i2c_scl_rising_edge) begin
							if (bytenumber == 2'b0) begin
								FIRST[bpcnt] <= i2c_sda;
							end
							else begin
								SECOND[bpcnt] <= i2c_sda;
							end	
							bpcnt <= bpcnt - 4'b1;
							clkstate <= HIGH;
						end	
					end
					HIGH: begin
						if (i2c_scl_falling_edge) begin
							if (~bpcnt[3]) begin
								clkstate <= LOW;
							end	
							else begin
								bpcnt <= 4'h7;
								clkstate <= LOW;
								prestate <= DATARECEIVE;
								state <= ACK;
							end	
						end
					end
				endcase 	
            end //DATARECEIVE
			STOP: begin
				case(clkstate)
					LOW: begin
						if (clk_counter == i2cclkrate/2) begin
							sda_oen_int <= 1'b0;
						end	
						if (i2c_scl_rising_edge) begin
							clkstate <= HIGH;
						end	
					end
					HIGH: begin
                        if (clk_counter == i2cclkrate/2) begin
							sda_oen_int <= 1'b1;
						end	
						if (i2c_scl_falling_edge) begin
							clkstate <= LOW;
							state <= IDLE;
						end	
					end				
				endcase	
			end	
		endcase 
	end
end 
 timer #(20) timer_inst01(
.cpld_rst_n_50m (rst),
.cpld_50m_clk (clk/*cpld_internal_clk*/),
.clk_en (1'b1/*clk_en_1k*/),
.timer_en (timer_enable),
.time_dly (20'd520000),
.timeout (timeout)
);
endmodule 