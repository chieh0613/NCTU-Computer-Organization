/***************************************************
Student Name: 劉文心 黃子潔
Student ID:  0716080 0716203
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output reg[31:0] Imm_Gen_o
	);

/* Write your code HERE */

wire [7-1:0] opcode;
assign opcode = instr_i[6:0];


always @(*) begin
	case(opcode)
		7'b0010011: //I type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31:20]};
		7'b0000011: //lw
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31:20]};
		7'b0100011: //S type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
		7'b1100011: //B type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8]};
		7'b1101111: //J type
			Imm_Gen_o <= {{12{instr_i[31]}}, instr_i[31], instr_i[19:12], instr_i[20], instr_i[30:21]};
	endcase
			
end

endmodule