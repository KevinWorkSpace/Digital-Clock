`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/24 19:44:00
// Design Name: 
// Module Name: top
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


module top(
    input rstsecond,resetall,setmin,sethour,clkdefoult,
    output[7:0] seg_out, scan_cnt,
    output clk_buzzer
    );
    wire  [7:0] minL;
    wire  [7:0] minH;
    wire  [7:0] hourL;
    wire  [7:0] hourH;
    wire  [7:0] secL;
    wire  [7:0] secH;
    wire out_sec;
    wire out_min;
    wire out_hour;
    wire out_rstall;
    wire hz1out,hz4out,hz64out,hz500out,hz1000out;
    
    key_fangdou k1(hz64out,setmin,out_min);
    key_fangdou k2(hz64out,sethour,out_hour);
    key_fangdou k3(hz64out,rstsecond,out_sec); 
    key_fangdou k4(hz64out,resetall,out_rstall);   
    
    frequencyDivider u1(clkdefoult,resetall,hz1out,hz4out,hz64out,hz500out,hz1000out);
    
    wire toSecond,toMinute,toHour,setZero;
    ControlUnit u2(out_sec,out_min,out_hour,hz64out,out_rstall,toSecond,toMinute,toHour,setZero);
    
    wire clksec_out;
    wire [3:0]temsecl,temsech;
    secondconter u3(hz1out,toSecond,resetall,clksec_out,temsecl,temsech);
   
    wire clkmin_in;
    MUXforMinute u4(hz4out,clksec_out,setmin,clkmin_in);
   
    wire clkmin_out;
    wire [3:0]temminl,temminh;
    minuteconter u5(clkmin_in,resetall,clkmin_out,temminl,temminh);
   
    wire clkhour_in;
    MUXforHour u6(hz4out,clkmin_out,sethour,clkhour_in);
    
    wire [3:0]temhourl,temhourh;
    hourconter u7(clkhour_in,resetall,temhourl,temhourh);
    
    Highdecoder HourH(temhourh,hourH);
    Lowdecoder HourL(temhourl,hourL);
    
    Highdecoder MinH(temminh,minH);
    Lowdecoder MinL(temminl,minL);
    
    Highdecoder SecH(temsech,secH);
    Lowdecoder SecL(temsecl,secL);
    
    
    seg s(.hour1(hourH), .hour2(hourL), .min1(minH), .min2(minL), .sec1(secH), .sec2(secL), .clk(hz500out), .rst_n(resetall),  .scan_cnt(scan_cnt), .seg_out(seg_out));
    
    
    clock u8(.sech(temsech),.secl(temsecl),.minh(temminh),.minl(temminl),.hz500clk(hz500out),.hz1Kclk(hz1000out),.clkout(clk_buzzer));
        
    endmodule