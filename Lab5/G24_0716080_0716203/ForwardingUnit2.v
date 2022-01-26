/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module ForwardingUnit2(
	input [4:0] Rs1,
	input [4:0] Rs2,
	input [4:0] memwb_RD,
	input memwb_WB,
	output reg forwarding_RS,
	output reg forwarding_RT
	);
	

/* Write your code HERE */
always @(*) begin
	forwarding_RS <= 0;
	forwarding_RT <= 0;
	if(memwb_WB&&memwb_WB!=0&&memwb_RD==Rs1)
		forwarding_RS <= 1;
	if(memwb_WB&&memwb_WB!=0&&memwb_RD==Rs2)
		forwarding_RT <= 1;
end
endmodule