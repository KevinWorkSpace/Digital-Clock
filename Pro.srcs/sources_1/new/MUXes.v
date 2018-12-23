`timescale 1ns / 1ps

module MUXforMinute(
Clk,SecondCarry,Control,countPlus
    );
    input Clk,SecondCarry,Control;
    output countPlus;
    reg countPlus;
    
   always@(Control)
   case(Control)
   1'b1:assign countPlus=Clk;
   1'b0:assign countPlus=SecondCarry;
   endcase
   
endmodule


module MUXforHour(
Clk,MinuteCarry,Control,countPlus
    );
    input Clk,MinuteCarry,Control;
    output countPlus;
    reg countPlus;
    always@(Control,Clk,MinuteCarry)
    case(Control)
    1'b1: countPlus=Clk;
    1'b0: countPlus=MinuteCarry;
    endcase
        
endmodule
