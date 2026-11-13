`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 10:45:12 AM
// Design Name: 
// Module Name: SwitchesModule
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


module SwitchesModule (
    input clk,
    input rst,
    input MemWrite,  // ignored
    input MemRead,
    input [8:0] address,  // ignored
    input [31:0] write_data, // ignored
    output reg [31:0] read_data,  
    input  wire [15:0] switches
);
    always @(*) begin
        read_data = 32'd0;
        if (MemRead) begin
            read_data = {16'd0, switches}; // Zero-extend 16-bit switches to 32-bit word
        end
    end
endmodule
