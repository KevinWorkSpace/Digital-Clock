`timescale 1ns / 1ps

module Highdecoder(
input rst,
input [3:0] high_in,
output reg [7:0] high_out 
);
always @(high_in,negedge rst)
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
input rst,
input [3:0] lownum_in,
output reg [7:0] low_out 
);
always @(lownum_in,negedge rst)
    begin
     case(lownum_in)
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
   
    wire rsttrue;
    assign rsttrue = rst & rstall;
    always @(posedge clk_1hz,negedge rst,negedge rstall)
    begin 
    if(!rsttrue)   //秒计数器置零信号
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



module frequencyDivider(
clk,rst_n,hz1out,hz4out,hz64out,hz500out,hz1000out
    );
    input clk,rst_n;
    output reg hz1out,hz4out,hz64out,hz500out,hz1000out;
    reg [27:0]cnt1,cnt4,cnt64,cnt500,cnt1000;
    parameter hz1=100000000,hz4=25000000,hz64=1562500,hz500=200000,hz1000=100000;
   //1 
    always@(posedge clk,negedge rst_n)
    begin
    if(~rst_n)begin
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
     always@(posedge clk,negedge rst_n)
       begin
       if(~rst_n)begin
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
        always@(posedge clk,negedge rst_n)
          begin
          if(~rst_n)begin
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
           always@(posedge clk,negedge rst_n)
             begin
             if(~rst_n)begin
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
    always@(posedge clk,negedge rst_n)
    begin
    if(~rst_n)begin
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


module controlcircuit(
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
    setZero<=1;
    end
    else
    begin
    toSecond<=setSecond;
    toMinute<=setMinute;
    toHour<=setHour;
    setZero<=0;
    end
 
endmodule


module minuteconter(
input clk_secin, reset,
output reg clkout,
output reg [3:0] minL,
output reg [3:0] minH

    );
    always @(posedge clk_secin,negedge reset)
    begin 
    if(!reset)   //分计数器置零信号
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



module hourconter(
input clk_minin, reset,
output reg [3:0] hourL,
output reg [3:0] hourH

    );
    always @(posedge clk_minin,negedge reset)
    begin 
    if(!reset)   //分计数器置零信号
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
 

module clock(sech,secl,minh,minl,hz500clk,hz1Kclk,clkout);

input [3:0] sech;
input [3:0] secl;
input [3:0] minh;
input [3:0] minl;
input hz500clk,hz1Kclk;
output clkout;
reg clkout;
always@(minh,minl,sech,secl,hz500clk,hz1Kclk)
    if (minh==4'd5 && minl==4'd9 && sech==4'd5)
        case(secl)
            4'd0,8'd52,4'd4,4'd6,4'd8 : clkout <= hz500clk;
            default : clkout <= 1'b0;
        endcase
    else if({minh,minl}==8'd00 && {sech,secl}==8'd00)
        clkout <= hz1Kclk;
    else 
        clkout <=1'b0;
endmodule

