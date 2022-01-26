/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080  0716203
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,
	input	[2-1:0]	ALUOp,
	output reg	[4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */

always @(instr, ALUOp) begin
	case(ALUOp)
		2'b01: begin //B type
			case(instr[3-1:0])
				3'b000: ALU_Ctrl_o <= 4'b0000; //beq
				3'b001: ALU_Ctrl_o <= 4'b0001; //bne
			endcase
		end
		2'b10: begin //R type
			case(instr)
				4'b0000: ALU_Ctrl_o <= 4'b0010; //add
				4'b1000: ALU_Ctrl_o <= 4'b0011; //sub
				4'b0111: ALU_Ctrl_o <= 4'b0100; //and
				4'b0110: ALU_Ctrl_o <= 4'b0101; //or
				4'b0100: ALU_Ctrl_o <= 4'b0110; //xor
				4'b0010: ALU_Ctrl_o <= 4'b0111; //slt
				4'b0001: ALU_Ctrl_o <= 4'b1000; //sll
				4'b1101: ALU_Ctrl_o <= 4'b1001; //sra
			endcase
		end
		2'b11: begin //I type
			case(instr[3-1:0])
				3'b000: ALU_Ctrl_o <= 4'b1010; //addi
				3'b010: ALU_Ctrl_o <= 4'b1011; //slti
				3'b001: ALU_Ctrl_o <= 4'b1100; //slli
				3'b101: ALU_Ctrl_o <= 4'b1101; //srli
				3'b111: ALU_Ctrl_o <= 4'b1110; //andi
				3'b110: ALU_Ctrl_o <= 4'b1111; //ori
			endcase
		end
	endcase
end

endmodule