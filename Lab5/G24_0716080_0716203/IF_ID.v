/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module IF_ID(
	input clk_i,
	input rst_i,
	input [31:0] instr_i,
	output reg [31:0] instr_o
	);
    
/* Write your code HERE */

always @(posedge clk_i) begin
    if(~rst_i)
	    instr_o <= 0;
	else
	    begin
		instr_o <= instr_i;
		end
end

endmodule