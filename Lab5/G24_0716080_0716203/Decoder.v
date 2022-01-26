/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [31:0] 	instr_i,
	output          ALUSrc,
	output          MemtoReg,
	output          RegWrite,
	output          MemRead,
	output          MemWrite,
	output [1:0]	ALUOp
	);

/* Write your code HERE */
wire [6:0] opcode;
assign opcode = instr_i[6:0];

assign ALUOp = (opcode == 7'b0110011)?2'b10: //R-type
			   (opcode == 7'b0010011)?2'b11: //I-type
			   2'bxx;
				
assign ALUSrc = (opcode == 7'b0110011)?0: //R-type
				(opcode == 7'b0010011)?1: //I-type
				1'bx;
				
assign MemtoReg = (opcode == 7'b0110011)?0: //R-type
				  (opcode == 7'b0010011)?0: //I-type
				  1'bx;

assign RegWrite = (opcode == 7'b0110011)?1: //R-type
				  (opcode == 7'b0010011)?1: //I-type
				  0; //default
				  
assign MemRead  = 0;
assign MemWrite = 0;

endmodule





                    
                    