`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 10:29:26
// Design Name: 
// Module Name: segPPT
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


module segPPT(hour1, hour2, min1, min2, sec1, sec2, rst, clk, DIG, Y_r);
    input[7:0] hour1, hour2, min1, min2, sec1, sec2; 
    input rst;
    input clk;
    output[7:0] DIG;
    output reg[7:0] Y_r;
    
    reg clkout;
    reg[31:0] cnt;
    reg[2:0] scan_cnt;
    
    parameter period = 200000;
    reg[7:0] DIG_r;
 
    assign DIG = ~DIG_r;
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            cnt <= 0;
            clkout <= 0;
        end
        else begin
            if(cnt == (period >> 1) - 1) begin
                clkout <= ~clkout;
                cnt <= 0;
            end
            else 
                cnt <= cnt + 1;
        end
    end
    
    always @(scan_cnt) begin
        case(scan_cnt)
            3'b000 : DIG_r = 8'b0000_0001;
            3'b001 : DIG_r = 8'b0000_0010;
            3'b010 : DIG_r = 8'b0000_0100;
            3'b011 : DIG_r = 8'b0000_1000;
            3'b100 : DIG_r = 8'b0001_0000;
            3'b101 : DIG_r = 8'b0010_0000;
            default : DIG_r = 8'b0000_0000;
        endcase
    end
    
    always @(posedge clkout, negedge rst) begin
        if(!rst)
            scan_cnt <= 0;
        else begin
            scan_cnt <= scan_cnt + 1;
            if(scan_cnt == 3'd5) scan_cnt <= 0;
        end
    end
    
    always @(scan_cnt) begin
        case(scan_cnt)
            0: Y_r = hour1;
            1: Y_r = hour2;
            2: Y_r = min1;
            3: Y_r = min2;
            4: Y_r = sec1;
            5: Y_r = sec2;
            default: Y_r = 8'b0000_0000;
        endcase
    end
    
endmodule
