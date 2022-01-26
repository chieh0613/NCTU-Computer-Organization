/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module MUX_2to1(
	input  [32-1:0] data0_i,       
	input  [32-1:0] data1_i,
	input       	select_i,
	output reg [32-1:0] data_o
               );
			   
/* Write your code HERE */
always @(select_i,data0_i,data1_i) begin
	if(select_i)
		data_o <= data1_i;
	else
		data_o <= data0_i;
end		   

endmodule      
          