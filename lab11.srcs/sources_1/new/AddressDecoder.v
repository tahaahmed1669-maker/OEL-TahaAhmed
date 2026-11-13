`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 10:35:17 AM
// Design Name: 
// Module Name: AddressDecoder
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
`timescale 1ns / 1ps

module AddressDecoder(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] address,
    input  wire        readEnable,
    input  wire        writeEnable,
    input  wire [31:0] writeData,
    input  wire [15:0] switches_in,
    output wire [31:0] readData,
    output wire [15:0] leds_out
);

    wire [31:0] memReadData;
    wire [31:0] switchReadData;

    // Two-bit selection using address[9:8]
    wire DataMemSelect = (address[9:8] == 2'b00);
    wire LEDSelect     = (address[9:8] == 2'b01);
    wire SwitchSelect  = (address[9:8] == 2'b10);

    wire DataMemWrite  = writeEnable & DataMemSelect;
    wire DataMemRead   = readEnable & DataMemSelect;
    wire LEDWrite      = writeEnable & LEDSelect;
    wire SwitchRead    = readEnable & SwitchSelect;

    DataMemory dm_inst (
        .clk(clk),
        .rst(rst),
        .MemWrite(DataMemWrite),
        .MemRead(DataMemRead),
        .address(address[8:0]),
        .write_data(writeData),
        .read_data(memReadData)
    );

    LEDModule led_inst (
        .clk(clk),
        .rst(rst),
        .MemWrite(LEDWrite),
        .address(address[8:0]),
        .write_data(writeData),
        .LEDs_out(leds_out)
    );

    SwitchesModule sw_inst (
        .MemRead(SwitchRead),
        .address(address[8:0]),
        .read_data(switchReadData),
        .switches(switches_in)
    );

    assign readData = (DataMemSelect) ? memReadData :
                      (SwitchSelect)  ? switchReadData :
                      32'h00000000;

endmodule