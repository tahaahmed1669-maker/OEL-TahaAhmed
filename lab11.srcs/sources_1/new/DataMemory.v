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
    input  wire        clk,
    input  wire        MemWrite,
    input  wire        MemRead,
    input  wire [8:0]  address,   
    input  wire [31:0] write_data,
    output reg  [31:0] read_data,
    output wire [15:0] LEDs_out,
    input  wire [15:0] switches
);

    reg [31:0] memory [0:511];
    
    assign LEDs_out = memory[8][15:0];

// Initialize memory array to 0 to prevent 'X' values
    integer i;
    initial begin
        for (i = 0; i <= 511; i = i + 1) begin
            memory[i] = 32'd0;
        end
    end
    //  Write
    always @(posedge clk) begin
        if (MemWrite)
            memory[address] <= write_data;
    end

    //  Read
    always @(*) begin
        if (MemRead) begin
            if (address == 9'd4) 
                read_data = {16'd0, switches}; 
            else
                read_data = memory[address];
        end else begin
            read_data = 32'd0;
        end
    end

endmodule
