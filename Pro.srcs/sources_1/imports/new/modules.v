`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/24 19:36:15
// Design Name: 
// Module Name: decoder
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

module key_fangdou(clk,key_in,key_out);
    parameter SAMPLE_TIME = 4;
    input clk;
    input key_in;
    output key_out;
    
    reg [2:0] count_low;
    reg [2:0] count_high;  
    reg key_out_reg;

    always @(posedge clk)
        if(key_in ==1'b0)
            count_low <= count_low + 1;
        else
            count_low <= 0;
    
    always @(posedge clk)
        if(key_in ==1'b1)
            count_high <= count_high + 1;
        else
            count_high <= 0;
    
    always @(posedge clk)
        if(count_high == SAMPLE_TIME)
            key_out_reg <= 1;
        else if(count_low == SAMPLE_TIME)
            key_out_reg <= 0;
    
    assign key_out = key_out_reg;
endmodule 
module Highdecoder(
input [3:0] high_in,
output reg [7:0] high_out 
);
always @(high_in)
    begin
     case(high_in)
        4'd0: high_out = 8'b01000000;
        4'd1: high_out = 8'b01111001;
        4'd2: high_out = 8'b00100100;
        4'd3: high_out = 8'b00110000;
        4'd4: high_out = 8'b00011001;
        4'd5: high_out = 8'b00010010;
        
      endcase
    end
endmodule

module Lowdecoder(
input [3:0] low_in,
output reg [7:0] low_out 
);
always @(low_in)
    begin
     case(low_in)
        4'd0: low_out = 8'b01000000;
        4'd1: low_out = 8'b01111001;
        4'd2: low_out = 8'b00100100;
        4'd3: low_out = 8'b00110000;
        4'd4: low_out = 8'b00011001;
        4'd5: low_out = 8'b00010010;
        4'd6: low_out = 8'b00000010;
        4'd7: low_out = 8'b01111000;
        4'd8: low_out = 8'b00000000;
        4'd9: low_out = 8'b00010000;
      endcase
    end
endmodule


module secondconter(
input clk_1hz, rst,rstall,
output reg clkout,
output reg [3:0] secL,
output reg [3:0] secH

    );
   
    always @(posedge clk_1hz,posedge rst,posedge rstall)
    begin 
    if(rst || rstall)   //秒计数器置零信号
        {secH,secL}<=8'd0;
        
    else if(secH==5&&secL==9) //计数到59s
        begin
        {secH,secL}<=8'd0;
        clkout <= 1;
        end
    else if(secH==0&&secL==0)
        begin
        clkout <= 0;
        secL<=secL+4'd1;
        end
    else if(secL==4'd9) //其他的9s
        begin 
         secL<=4'd0; 
         secH<=secH+4'd1;
        end 
    else    //一般情况
        secL<=secL+4'd1; 
    end 
    
endmodule


module hourconter(
input clk_minin, reset,
output reg [3:0] hourL,
output reg [3:0] hourH

    );
    always @(posedge clk_minin,posedge reset)
    begin 
    if(reset)   //分计数器置零信号
        {hourH,hourL}<=8'd0;
        
    else if(hourH==2&&hourL==3) //计数到23hour
        {hourH,hourL}<=8'd0;
    else if(hourL==4'd9) //9hour
        begin 
        hourL<=4'd0; 
        hourH<=hourH+4'd1;
        end
    else    //一般情况
        hourL <= hourL+4'd1; 
    end 
    
endmodule


module minuteconter(
input clk_secin, resetall,
output reg clkout,
output reg [3:0] minL,
output reg [3:0] minH

    );
    always @(posedge clk_secin,posedge resetall)
    begin 
    if(resetall)   //分计数器置零信号
        {minH,minL}<=8'd0;
        
    else if(minH==5&&minL==9) //计数到59min
        begin
        {minH,minL}<=8'd0;
        clkout <= 1;
        end
    else if(minH==0&&minL==0)
        begin
        clkout <= 0;
        minL <= minL+4'd1;
        end
    else if(minL==4'd9) //其他的9min
        begin 
         minL<=4'd0; 
         minH<=minH+4'd1;
        end 
    else    //一般情况
        minL <= minL+4'd1; 
    end 
   
endmodule


`timescale 1ns / 1ps

module frequencyDivider(
clk,rst_n,hz1out,hz4out,hz64out,hz500out,hz1000out
    );
    input clk,rst_n;
    output reg hz1out,hz4out,hz64out,hz500out,hz1000out;
    reg [27:0]cnt1,cnt4,cnt64,cnt500,cnt1000;
    parameter hz1=100000000,hz4=25000000,hz64=1562500,hz500=200000,hz1000=100000;
   //1 
    always@(posedge clk,posedge rst_n)
    begin
    if(rst_n)begin
    cnt1<=0;
    hz1out<=0;
    end
    else if(cnt1==(hz1>>1)-1)
    begin
    cnt1<=0;
    hz1out<=~hz1out;
    end
    else
    cnt1<=cnt1+1;
    end
  //4  
     always@(posedge clk,posedge rst_n)
       begin
       if(rst_n)begin
       cnt4<=0;
       hz4out<=0;
       end
       else if(cnt4==(hz4>>1)-1)
       begin
       cnt4<=0;
       hz4out<=~hz4out;
       end
       else
       cnt4<=cnt4+1;
       end
       
       //64
        always@(posedge clk,posedge rst_n)
          begin
          if(rst_n)begin
          cnt64<=0;
          hz64out<=0;
          end
          else if(cnt64==(hz64>>1)-1)
          begin
          cnt64<=0;
          hz64out<=~hz64out;
          end
          else
          cnt64<=cnt64+1;
          end
//500     
           always@(posedge clk,posedge rst_n)
             begin
             if(rst_n)begin
             cnt500<=0;
             hz500out<=0;
             end
             else if(cnt500==(hz500>>1)-1)
             begin
             cnt500<=0;
             hz500out<=~hz500out;
             end
             else
             cnt500<=cnt500+1;
             end
//1000 
    always@(posedge clk,posedge rst_n)
    begin
    if(rst_n)begin
    cnt1000<=0;
    hz1000out<=0;
    end
    else if(cnt1000==(hz1000>>1)-1)
    begin
    cnt1000<=0;
    hz1000out<=~hz1000out;
    end
    else
    cnt1000<=cnt1000+1;
    end
             
    
endmodule



`timescale 1ns / 1ps

module ControlUnit(
setSecond,setMinute,setHour,Clk,reset,toSecond,toMinute,toHour,setZero
    );
    
    input setSecond,setMinute,setHour,Clk,reset;
    output toSecond,toMinute,toHour,setZero;
    reg toSecond,toMinute,toHour,setZero;
    
    always@(posedge Clk,posedge reset)
    if(reset==1)
    begin
    toSecond<=0;
    toMinute<=0;
    toHour<=0;
    setZero<=reset;
    end
    else
    begin
    toSecond<=setSecond;
    toMinute<=setMinute;
    toHour<=setHour;
    setZero<=reset;
    end
endmodule




module clock(sech,secl,minh,minl,hz500clk,hz1Kclk,clkout);

input [3:0] sech;
input [3:0] secl;
input [3:0] minh;
input [3:0] minl;
input hz500clk,hz1Kclk;
output clkout;
reg clkout;
always@*
begin
    if(minh==4'b0101 && minl==4'b1001)
        begin
            if(sech==4'b0101)
            begin
            if(secl==4'b0000 | secl==4'b0010|secl==4'b0100|secl==4'b1000|secl==4'b0110)
            begin
                clkout <= hz500clk;
                #500 clkout<=0;
            end
            end
         end
     else if (minh==4'b0000 && minl ==4'b0000 && sech==4'b0000 && secl==4'b0000)
            clkout<=hz1Kclk;
     else
        clkout<= 1'b0;
end
endmodule

`timescale 1ns / 1ps

module MUXforMinute(
Clk,SecondCarry,Control,countPlus
    );
    input Clk,SecondCarry,Control;
    output countPlus;
    wire countPlus;

   assign countPlus=(Control)?Clk:SecondCarry;
 
   
endmodule


module MUXforHour(
Clk,MinuteCarry,Control,countPlus
    );
    input Clk,MinuteCarry,Control;
    output countPlus;
    wire countPlus;

        
        assign countPlus=(Control)?Clk:MinuteCarry;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/16 15:50:31
// Design Name: 
// Module Name: seg
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

module seg(
    input[7:0] hour1,
    input[7:0] hour2,
    input[7:0] min1,
    input[7:0] min2,
    input[7:0] sec1,
    input[7:0] sec2,
    input clk, rst_n,
    output reg [7:0] scan_cnt,   //8个数码管的使能信号
    output reg [7:0] seg_out     //8个数码管显示的数字
    );
    always @(posedge clk, posedge rst_n) begin
        if(rst_n)
            scan_cnt = 8'b1111_1110;
        else begin
            case(scan_cnt)
                8'b1111_1110: scan_cnt = 8'b1111_1101;
                8'b1111_1101: scan_cnt = 8'b1111_1011;
                8'b1111_1011: scan_cnt = 8'b1111_0111;
                8'b1111_0111: scan_cnt = 8'b1110_1111;
                8'b1110_1111: scan_cnt = 8'b1101_1111;
                8'b1101_1111: scan_cnt = 8'b1111_1110;
            endcase
        end
    end
    
    always @(scan_cnt)
    begin
        case(scan_cnt)
            8'b1111_1110: seg_out = sec2;
            8'b1111_1101: seg_out = sec1;
            8'b1111_1011: seg_out = min2;
            8'b1111_0111: seg_out = min1;
            8'b1110_1111: seg_out = hour2;
            8'b1101_1111: seg_out = hour1;
       endcase
    end
endmodule
