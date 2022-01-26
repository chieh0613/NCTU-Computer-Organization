/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input		[3:0]	instr,
	input		[1:0]	ALUOp,
	output reg[3:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
always @(*) begin
	case(ALUOp)
		2'b10: begin //R type
			case(instr)
				4'b0000: ALU_Ctrl_o <= 4'b0010; //add
				4'b1000: ALU_Ctrl_o <= 4'b0000; //sub
				4'b0111: ALU_Ctrl_o <= 4'b0011; //and
				4'b0110: ALU_Ctrl_o <= 4'b0100; //or
				4'b0100: ALU_Ctrl_o <= 4'b0101; //xor
				4'b0010: ALU_Ctrl_o <= 4'b0110; //slt
				4'b0001: ALU_Ctrl_o <= 4'b0111; //sll
				4'b1101: ALU_Ctrl_o <= 4'b1000; //sra
			endcase
		end
		2'b11: begin //I type
			case(instr[3-1:0])
				3'b000: ALU_Ctrl_o <= 4'b0010; //addi
				3'b010: ALU_Ctrl_o <= 4'b0110; //slti
				3'b001: ALU_Ctrl_o <= 4'b0111; //slli
				3'b101: ALU_Ctrl_o <= 4'b1001; //srli
				3'b111: ALU_Ctrl_o <= 4'b0011; //andi
				3'b110: ALU_Ctrl_o <= 4'b0100; //ori
				3'b100: ALU_Ctrl_o <= 4'b0101; //xori
			endcase
		end
	endcase
end
 
endmodule