/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module ID_EX(
    input clk_i,
	input rst_i,
	input ALUSrc_i,
	input MemtoReg_i,
	input RegWrite_i,
	input MemRead_i,
	input MemWrite_i,
	input [1:0]	ALUOp_i,
	input [31:0] RS_data_i,
	input [31:0] RT_data_i,
	input [31:0] imm_i,
	input [3:0] ALU_ctrl_i,
	input [4:0] RS_i,
	input [4:0] RT_i,
	input [4:0] RD_i,
	output reg ALUSrc_o,
	output reg MemtoReg_o,
	output reg RegWrite_o,
	output reg MemRead_o,
	output reg MemWrite_o,
	output reg [1:0] ALUOp_o,
	output reg [31:0] RS_data_o,
	output reg [31:0] RT_data_o,
	output reg [31:0] imm_o,
	output reg [3:0] ALU_ctrl_o,
	output reg [4:0] RS_o,
	output reg [4:0] RT_o,
	output reg [4:0] RD_o
	);
    
/* Write your code HERE */

always @(posedge clk_i) begin
    if(~rst_i)
		begin
	    ALUSrc_o <= 0;
		MemtoReg_o <= 0;
		RegWrite_o <= 0;
		MemRead_o <= 0;
		MemWrite_o <= 0;
		ALUOp_o <= 0;
		RS_data_o <= 0;
		RT_data_o <= 0;
		imm_o <= 0;
		ALU_ctrl_o <= 0;
		RS_o <= 0;
		RT_o <= 0;
		RD_o <= 0;
		end
	else
	    begin
		ALUSrc_o <= ALUSrc_i;
		MemtoReg_o <= MemtoReg_i;
		RegWrite_o <= RegWrite_i;
		MemRead_o <= MemRead_i;
		MemWrite_o <= MemWrite_i;
		ALUOp_o <= ALUOp_i;
		RS_data_o <= RS_data_i;
		RT_data_o <= RT_data_i;
		imm_o <= imm_i;
		ALU_ctrl_o <= ALU_ctrl_i;
		RS_o <= RS_i;
		RT_o <= RT_i;
		RD_o <= RD_i;
		end
end

endmodule