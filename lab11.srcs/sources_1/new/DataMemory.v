`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2026 11:03:55 AM
// Design Name: 
// Module Name: DataMemory
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

module DataMemory(
    input clk,
    input rst,
    input MemWrite,
    input MemRead,
    input [8:0] address,
    input [31:0] write_data,
    output [31:0] read_data
    );

    reg [31:0] mem [0:511];

// Initialize memory array to 0 to prevent 'X' values
    integer i;
    initial begin
        for (i = 0; i <= 511; i = i + 1) begin
            mem[i] = 32'd0;
        end
    end
    //  Write
    always @(posedge clk or posedge rst) begin
        // rst
        if (rst) begin
            for (i = 0; i < 512; i = i + 1)
                mem[i] <= 32'b0;
        end
        if (MemWrite)
            mem[address] <= write_data;
    end

    assign read_data = (MemRead) ? mem[address] : 32'b0;

endmodule