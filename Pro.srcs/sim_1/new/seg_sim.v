`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/16 17:03:28
// Design Name: 
// Module Name: seg_sim
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


module seg_sim();
    reg[7:0] hour1;
    reg[7:0] hour2;
    reg[7:0] min1;
    reg[7:0] min2;
    reg[7:0] sec1;
    reg[7:0] sec2;
    wire[7:0] scan;
    wire[7:0] seg_out; 
    reg clk, rst_n;
    seg s(.hour1(hour1), .hour2(hour2), .min1(min1), .min2(min2), .sec1(sec1), .sec2(sec2), .clk(clk), .rst_n(rst_n), .scan_cnt(scan), .seg_out(seg_out));
    
    initial begin
        clk = 0;
        rst_n = 0;
        #10 rst_n = 1;
        hour1 = 8'd0;
        hour2 = 8'd1;
        min1 = 8'd2;
        min2 = 8'd3;
        sec1 = 8'd4;
        sec2 = 8'd5;
        #50 
        hour1 = 8'd5;
        hour2 = 8'd4;
        min1 = 8'd3;
        min2 = 8'd2;
        sec1 = 8'd1;
        sec2 = 8'd0;
    end
    always 
        #5 clk = ~clk;
endmodule
