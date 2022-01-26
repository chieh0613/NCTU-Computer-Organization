/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module EX_MEM(
    input clk_i,
	input rst_i,
	input MemtoReg_i,
	input RegWrite_i,
	input MemRead_i,
	input MemWrite_i,
	input [31:0] ALU_result_i,
	input [31:0] RT_data_i,
	input [4:0] RD_i,
	output reg MemtoReg_o,
	output reg RegWrite_o,
	output reg MemRead_o,
	output reg MemWrite_o,
	output reg [31:0] ALU_result_o,
	output reg [31:0] RT_data_o,
	output reg [4:0] RD_o
	);
    
/* Write your code HERE */

always @(posedge clk_i) begin
    if(~rst_i)
		begin
	    MemtoReg_o <= 0;
		RegWrite_o <= 0;
		MemRead_o <= 0;
		MemWrite_o <= 0;
		ALU_result_o <= 0;
		RT_data_o <= 0;
		RD_o <= 0;
		end
	else
		begin
		MemtoReg_o <= MemtoReg_i;
		RegWrite_o <= RegWrite_i;
		MemRead_o <= MemRead_i;
		MemWrite_o <= MemWrite_i;
		ALU_result_o <= ALU_result_i;
		RT_data_o <= RT_data_i;
		RD_o <= RD_i;
		end
end

endmodule