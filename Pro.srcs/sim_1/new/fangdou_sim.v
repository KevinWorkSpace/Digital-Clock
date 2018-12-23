`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 21:00:15
// Design Name: 
// Module Name: fangdou_sim
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


module fangdou_sim();
    reg clk;
    reg key_in;
    wire key_out;
    
    key_fangdou fd(clk,key_in,key_out);
    always #20 clk = ~clk;
    initial begin
        clk = 0;
        key_in = 0;
        repeat(1) begin
           #50 key_in = ~key_in;
        end
    end
endmodule
