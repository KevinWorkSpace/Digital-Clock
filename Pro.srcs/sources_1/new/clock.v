`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/19 09:28:33
// Design Name: 
// Module Name: clock
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


module clock(sech,secl,minh,minl,toSecond,toMinute,toHour,hz500clk,hz1Kclk,clkout);

input [3:0] sech;
input [3:0] secl;
input [3:0] minh;
input [3:0] minl;
input hz500clk,hz1Kclk,toSecond,toMinute,toHour;
output clkout;
reg clkout;
always@(minh,minl,sech,secl,hz500clk,hz1Kclk)
    if(toSecond||toMinute||toHour == 1)
        clkout <= 1'b0;
    else begin 
        if (minh==4'd5 && minl==4'd9 && sech==4'd5)
            case(secl)
                4'd0,8'd52,4'd4,4'd6,4'd8 : clkout <= hz500clk;
                default : clkout <= 1'b0;
            endcase
        else if({minh,minl}==8'd00 && {sech,secl}==8'd00)
            clkout <= hz1Kclk;
        else 
            clkout <=1'b0;
    end
endmodule

