/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output reg [31:0] Imm_Gen_o
	);

/* Write your code HERE */
wire [7-1:0] opcode;
assign opcode = instr_i[6:0];

always @(*) begin
	case(opcode)
		7'b0010011: //I type
			Imm_Gen_o <= {{20{instr_i[31]}}, instr_i[31:20]};
	endcase	
end

endmodule