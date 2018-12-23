`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 20:27:19
// Design Name: 
// Module Name: secCount_sim
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


module secCount_sim(

    );
    
    reg clk_1hz, rst,rstall;
    wire clkout;
    wire[3:0] secL;
    wire[3:0] secH;
    
    secondconter sc(clk_1hz, rst, rstall, clkout, secL, secH);
    
    always #50 clk_1hz = ~clk_1hz;
    
    initial begin
        rstall = 0;
        clk_1hz = 0;
        rst = 0;
        #100 rstall = 1;
        #100 rst = 1;
    end
endmodule
