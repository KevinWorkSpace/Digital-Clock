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


module seg2(
    input hour1,
    input hour2,
    input min1,
    input min2,
    input sec1,
    input sec2,
    input clk, rst_n,
    output reg [7:0] scan_cnt,   //8个数码管的使能信号
    output reg [7:0] seg_out     //8个数码管显示的数字
    );
    always @(posedge clk, negedge rst_n) begin
        if(rst_n)
            scan_cnt <= 8'b1111_1110;
        else begin 
            case(scan_cnt)
                8'b1111_1110: scan_cnt <= 8'b1111_1101;
                8'b1111_1101: scan_cnt <= 8'b1111_1011;
                8'b1111_1011: scan_cnt <= 8'b1111_0111;
                8'b1111_0111: scan_cnt <= 8'b1110_1111;
                8'b1110_1111: scan_cnt <= 8'b1101_1111;
                8'b1101_1111: scan_cnt <= 8'b1111_1110;
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
