`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 21:13:48
// Design Name: 
// Module Name: top_sim
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


module top_sim();
    reg rstsecond,resetall,setmin,sethour,clkdefoult;
    wire[7:0] seg_out, scan_cnt;
    wire clk_buzzer;
    reg hz1out,hz4out,hz64out,hz500out,hz1000out;
    wire[7:0] minL,minH,hourL, hourH, secL, secH;
    wire [3:0]temsecl,temsech;
    wire out_sec;
    wire out_min;
    wire out_hour;
    wire out_rstall;
    wire toSecond;
//    wire hz1out,hz4out,hz64out,hz500out,hz1000out;
//    wire out_sec,out_min,out_hour,out_rstall;
//    allfile2 t(rstsecond, resetall, setmin, sethour, clkdefoult, seg_out, scan_cnt, clk_buzzer,hz1out,hz4out,hz64out,hz500out,hz1000out);
    allfile2 t(rstsecond, resetall, setmin, sethour, clkdefoult, hz1out,hz4out,hz64out,hz500out,hz1000out, seg_out, scan_cnt, clk_buzzer, minL,
    minH,
    hourL,
    hourH,
    secL,
    secH, temsecl,temsech, out_sec,
    out_min, out_hour, out_rstall,
    toSecond
    );
   
    always #6400 hz1out = ~hz1out;
    always #1600 hz4out = ~hz4out;
    always #100 hz64out = ~hz64out;
    always #13 hz500out = ~hz500out;
    always #6 hz1000out = ~hz1000out;
    always #1 clkdefoult = ~clkdefoult;
    
    always #10 clkdefoult = ~clkdefoult;
    initial begin
        hz1out = 0;
        hz4out = 0;
        hz64out = 0;
        hz500out = 0;
        hz1000out = 0;
        clkdefoult = 0;
        resetall = 0;
        #50 resetall = 1;
        #50 resetall = 0;
    end
endmodule
