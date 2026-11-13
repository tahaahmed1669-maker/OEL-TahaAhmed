`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 08:09:52 PM
// Design Name: 
// Module Name: toptb
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



module tb_TopLevelProcessor();

    reg clk;
    reg rst;
    reg [15:0] switches;
    wire [15:0] LEDs;

    topProcessor uut (
        .clk(clk),
        .rst(rst),
        .switches(switches),
        .LEDs(LEDs)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        switches = 16'd0; 

        #20;
        rst = 0;

        #100;
        
        $display("--> [SIM EVENT] User flips switches to 5");
        switches = 16'd5; 

        #1200;

        $display("--> [SIM EVENT] User presses Reset button");
        rst = 1; 
        switches = 16'd0; 
        #20;
        rst = 0; 

        #500;

        $display("--> [SIM EVENT] User flips switches to 3");
        switches = 16'd3;

          #500;
        $display("--> [SIM EVENT] Simulation Complete");
        $finish;
    end

    initial begin
        $display("Time | PC | Instr | imm | rs1 | rs2 | ALU_B | ALURes | LEDs | Switches | Rst");
        $monitor("%0t | %0d | %h | %0d | %0d | %0d | %0d | %0d | %0d | %0d | %b",
            $time,
            uut.PCout,
            uut.instruction,
            uut.imm,
            uut.readData1,
            uut.readData2,
            uut.ALU_B,
            uut.ALUResult,
            LEDs,
            switches,
            rst
        );
    end

endmodule
