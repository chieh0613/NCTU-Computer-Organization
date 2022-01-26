/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module MUX_3to1(
	input  [31:0] data0_i,
	input  [31:0] data1_i,
	input  [31:0] data2_i,
	input  [ 1:0] select_i,
	output reg[31:0] data_o
    );

/* Write your code HERE */

always @(select_i,data0_i,data1_i) begin
	if(select_i == 2'b00)
		data_o <= data0_i;
	else if(select_i == 2'b01)
		data_o <= data1_i;
	else
		data_o <= data2_i;
end

endmodule
