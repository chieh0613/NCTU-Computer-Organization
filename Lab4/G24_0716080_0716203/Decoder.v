/***************************************************
Student Name: 劉文心 黃子潔
Student ID:  0716080 0716203
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [31:0] 	instr_i,
	output          ALUSrc,
	output          MemtoReg,
	output          RegWrite,
	output          MemRead,
	output          MemWrite,
	output          Branch,
	output [1:0]	ALUOp,
	output [1:0]	Jump
	);

/* Write your code HERE */

wire	[7-1:0]		opcode;
assign opcode = instr_i[6:0];

/*
assign ALUSrc = (opcode == 7'b0010011)?1:0; //I-type = 1
assign RegWrite = (opcode == 7'b1100011)?0: //B-type = 0
				  (opcode == 7'b0110011)?1: //R-type = 1
				  (opcode == 7'b0010011)?1:0; //I-type = 1
assign Branch = (opcode == 7'b1100011)?1:0; //B-type = 1
assign ALUOp = (opcode == 7'b1100011)?2'b01:( //B-type
				opcode == 7'b0110011)?2'b10:( //R-type
				opcode == 7'b0010011)?2'b11:2'b00; //I-type S-type
 */

assign ALUOp = (opcode == 7'b0100011)?2'b00: //S-type
			   (opcode == 7'b1100011)?2'b01: //B-type
			   (opcode == 7'b0110011)?2'b10: //R-type
			   (opcode == 7'b0010011)?2'b11: //I-type
			   (opcode == 7'b0000011)?2'b01: //lw 因為funct3=010 和slti一樣 先放在Btype
			   2'bxx; //jal jalr
				
assign ALUSrc = (opcode == 7'b0100011)?1: //S-type
				(opcode == 7'b1100011)?0: //B-type
				(opcode == 7'b0110011)?0: //R-type
				(opcode == 7'b0010011)?1: //I-type
				(opcode == 7'b0000011)?1: //lw
				1'bx; //jal jalr
				
assign MemtoReg = (opcode == 7'b0100011)?1'bx: //S-type
				  (opcode == 7'b1100011)?1'bx: //B-type
				  (opcode == 7'b0110011)?0: //R-type
				  (opcode == 7'b0010011)?0: //I-type
				  (opcode == 7'b0000011)?1: //lw
				  1'bx; //jal jalr

assign RegWrite = (opcode == 7'b0100011)?0: //S-type
				  (opcode == 7'b1100011)?0: //B-type
				  (opcode == 7'b0110011)?1: //R-type
				  (opcode == 7'b0010011)?1: //I-type
				  (opcode == 7'b0000011)?1: //lw
				  (opcode == 7'b1101111)?1: //jal
				  (opcode == 7'b1100111)?1: //jalr
				  0; //default
				  
assign MemRead  = (opcode == 7'b0100011)?0: //S-type
				  (opcode == 7'b1100011)?0: //B-type
				  (opcode == 7'b0110011)?0: //R-type
				  (opcode == 7'b0010011)?0: //I-type
				  (opcode == 7'b0000011)?1: //lw
				  0; //jal jalr
				  
assign MemWrite = (opcode == 7'b0100011)?1: //S-type
				  (opcode == 7'b1100011)?0: //B-type
				  (opcode == 7'b0110011)?0: //R-type
				  (opcode == 7'b0010011)?0: //I-type
				  (opcode == 7'b0000011)?0: //lw
				  0; //jal jalr
				  
assign Branch   = (opcode == 7'b0100011)?0: //S-type
				  (opcode == 7'b1100011)?1: //B-type
				  (opcode == 7'b0110011)?0: //R-type
				  (opcode == 7'b0010011)?0: //I-type
				  (opcode == 7'b0000011)?0: //lw
				  0; //jal jalr
				  
assign Jump = (opcode == 7'b0100011)?2'b00: //S-type
			  (opcode == 7'b1100011)?2'b00: //B-type
			  (opcode == 7'b0110011)?2'b00: //R-type
			  (opcode == 7'b0010011)?2'b00: //I-type
			  (opcode == 7'b0000011)?2'b00: //lw
			  (opcode == 7'b1101111)?2'b01: //jal
			  (opcode == 7'b1100111)?2'b10: //jalr
			  2'b00; //default
 
endmodule





                    
                    