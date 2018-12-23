`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/23 10:21:26
// Design Name: 
// Module Name: seg2_sim
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


module seg2_sim();
   reg hour1;
   reg hour2;
   reg min1;
   reg min2;
   reg sec1;
   reg sec2;
   reg clk, rst_n;
   wire [7:0] scan_cnt;   //8个数码管的使能信号
   wire [7:0] seg_out;     //8个数码管显示的数字
   
   seg2 s2(hour1, hour2, min1, min2, sec1, sec2, clk, rst_n, scan_cnt, seg_out);
   
   initial begin
       clk = 0;
       rst_n = 0;
       #10 rst_n = 1;
       #10 rst_n = 0;
       hour1 = 1'd0;
       hour2 = 1'd1;
       min1 = 1'd0;
       min2 = 1'd1;
       sec1 = 8'd1;
       sec2 = 8'd0;
       #50 
       hour1 = 1'd1;
       hour2 = 1'd0;
       min1 = 1'd0;
       min2 = 1'd0;
       sec1 = 1'd0;
       sec2 = 1'd1;
   end
   always #5 clk = ~clk;
endmodule
