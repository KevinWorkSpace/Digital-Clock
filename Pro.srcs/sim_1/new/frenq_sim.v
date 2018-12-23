`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 11:19:02
// Design Name: 
// Module Name: frenq_sim
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


module frenq_sim();
    reg clk,rst_n;
    wire hz1out,hz4out,hz64out,hz500out,hz1000out;
    wire[27:0]cnt1,cnt4,cnt64,cnt500,cnt1000;
    fq2 fd(clk,rst_n,hz1out,hz4out,hz64out,hz500out,hz1000out,cnt1,cnt4,cnt64,cnt500,cnt1000);
    
    always #1 clk = ~clk;
    
    initial begin
        clk = 0;
        rst_n = 0;
        #50 rst_n = 1;
    end
endmodule
