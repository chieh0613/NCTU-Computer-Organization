/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero         // 1 bit when the output is 0, zero must be set (output)
	//output reg              cout,          // 1 bit carry out           (output)
	//output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

always @(src1, src2, rst_n, ALU_control, result) begin
	if(rst_n)
		zero <= (result==0)?1:0;
end

always @(src1, src2, rst_n, ALU_control) begin
	if(rst_n) begin
		case(ALU_control)
			4'b0000:
				result <= src1 - src2; //beq
			4'b0001:
				result <= (src1 == src2); //bne
			4'b0010:
				result <= src1 + src2; //add
			4'b0011:
				result <= src1 - src2; //sub
			4'b0100:
				result <= src1 & src2; //and
			4'b0101:
				result <= src1 | src2; //or
			4'b0110:
				result <= src1 ^ src2; //xor
			4'b0111:
				result <= (src1 < src2); //slt
			4'b1000:
				result <= src1 << src2; //sll
			4'b1001:
				result <= src1 >>> src2; //sra
			4'b1010:
				result <= src1 + src2; //addi
			4'b1011:
				result <= (src1 < src2); //slti
			4'b1100:
				result <= src1 << src2; //slli
			4'b1101:
				result <= src1 >> src2; //srli
			4'b1110:
				result <= src1 & src2; //andi
			4'b1111:
				result <= src1 | src2; //ori
		endcase
	end
end

endmodule
