`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 14:40:03
// Design Name: 
// Module Name: fq2
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


module fq2(
clk,rst_n,hz1out,hz4out,hz64out,hz500out,hz1000out,cnt1,cnt4,cnt64,cnt500,cnt1000
    );
    input clk,rst_n;
    output reg hz1out,hz4out,hz64out,hz500out,hz1000out;
    output reg [27:0]cnt1,cnt4,cnt64,cnt500,cnt1000;
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
   always@(posedge clk,negedge rst_n) begin
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
