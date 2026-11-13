`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 10:44:43 AM
// Design Name: 
// Module Name: LEDModule
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


module LEDModule (
    input clk,
    input rst,
    input MemWrite,
    input MemRead, // ignored
    input [8:0] address,  // ignored
    input [31:0] write_data,
    output [31:0] read_data,  // ignored
    output reg  [15:0] LEDs_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            LEDs_out <= 16'b0;
        end else if (MemWrite) begin
            LEDs_out <= write_data[15:0]; // Capture lower 16 bits
        end
    end
endmodule
