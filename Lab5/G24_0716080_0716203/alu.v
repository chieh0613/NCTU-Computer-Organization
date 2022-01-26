/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/
`timescale 1ns/1ps

module alu(
	input	       rst_n,         // Reset                     (input)
	input	[31:0] src1,          // 32 bits source 1          (input)
	input	[31:0] src2,          // 32 bits source 2          (input)
	input 	[ 3:0] ALU_control,   // 4 bits ALU control input  (input)
	output  reg[31:0] result        // 32 bits result            (output)
	);

/* Write your code HERE */

always @(*) begin
	if(rst_n) begin
		case(ALU_control)
			4'b0000:
				result <= src1 - src2; //sub
			4'b0010:
				result <= src1 + src2; //add, addi
			4'b0011:
				result <= src1 & src2; //and, andi
			4'b0100:
				result <= src1 | src2; //or, ori
			4'b0101:
				result <= src1 ^ src2; //xor, xori
			4'b0110:
				result <= (src1 < src2); //slt, slti
			4'b0111:
				result <= src1 << src2; //sll, slli
			4'b1000:
				result <= src1 >>> src2; //sra
			4'b1001:
				result <= src1 >> src2; //srli
		endcase
	end
end

endmodule
