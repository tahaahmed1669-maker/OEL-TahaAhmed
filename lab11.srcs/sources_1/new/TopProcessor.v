`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2026 10:24:45 AM
// Design Name: 
// Module Name: topProcessor
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


module topProcessor(
    input wire clk,
    input wire rst,
    input  wire [15:0] switches,
    output wire [15:0] LEDs
);
wire [31:0] PCout, next, PC4;
wire [31:0] instruction;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;
wire [3:0] ALUctrl;
wire PCSrc;
wire [31:0] imm;
wire [31:0] readData1, readData2, writeData;
wire [31:0] ALU_B, ALUResult;
wire zero;
wire [31:0] mem_readData;
wire [31:0] target; // branch


assign PCSrc = Branch & zero;

ALU alu_inst (
    .A(readData1),
    .B(ALU_B),
    .ALU_control(ALUctrl),
    .ALU_result(ALUResult),
    .Zero(zero)
);

Register reg_file_inst (
    .clk(clk),
    .rst(rst),
    .WriteEnable(RegWrite),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .WriteData(writeData),
    .ReadData1(readData1),
    .ReadData2(readData2)
);

AddressDecoder address_decoder_inst (
    .clk(clk),
    .rst(rst),
    .address(ALUResult),
    .readEnable(MemRead),
    .writeEnable(MemWrite),
    .writeData(readData2),
    .switches_in(switches),
    .readData(mem_readData),
    .leds_out(LEDs)
);

MainControl main_ctrl_inst (
    .opcode(instruction[6:0]),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch),
    .ALUOp(ALUOp)
);

ALUControl alu_ctrl_inst (
    .ALUOp(ALUOp),
    .funct3(instruction[14:12]),
    .funct7(instruction[30]),
    .op5(instruction[5]),
    .ALUControl(ALUctrl)
);

instructionMemory inst_mem (
    .instAddress(PCout),
    .instruction(instruction)
);

MUX alu_mux_inst (
    .in1(readData2),
    .in2(imm),
    .select(ALUSrc),
    .out(ALU_B)
);

PC pc_inst (
    .clk(clk),
    .rst(rst),
    .next(next),
    .PCout(PCout)
);

PCAdder pc_adder_inst (
    .PCout(PCout),
    .PC4(PC4)
);

BranchAdd branch_add_inst (
    .PCout(PCout),
    .imm(imm),
    .target(target)
);

MUX branch_mux_inst (
    .in1(PC4),
    .in2(target),
    .select(PCSrc),
    .out(next)
);

MUX memtoreg_mux_inst (
    .in1(ALUResult),
    .in2(mem_readData),
    .select(MemtoReg),
    .out(writeData)
);

immGen imm_gen_inst (
    .instruction(instruction),
    .imm(imm)
);



endmodule


