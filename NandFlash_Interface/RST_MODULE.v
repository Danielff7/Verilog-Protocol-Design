`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2019 09:21:39 PM
// Design Name: 
// Module Name: RST_MODULE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RST_MODULE(
        output rst,
        input clk
    );
    reg rst_int = 0;
    assign rst = rst_int;
    reg [15:0] cnt = 15'b0;
    always@(posedge clk) begin
        if (cnt > 2500) begin
            cnt <= cnt;
            rst_int <= 1'b1;
        end
        else begin
            rst_int <= 1'b0;
            cnt <= cnt + 1;
        end
    end
endmodule
