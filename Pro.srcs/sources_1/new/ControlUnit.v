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