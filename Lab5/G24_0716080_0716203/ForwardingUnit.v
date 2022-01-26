/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps

module ForwardingUnit(
	input [4:0] Rs1,
	input [4:0] Rs2,
	input [4:0] exmem_RD,
	input [4:0] memwb_RD,
	input exmem_WB,
	input memwb_WB,
	output reg [1:0] forwarding_A,
	output reg [1:0] forwarding_B
	);
	

/* Write your code HERE */
always @(*) begin
	forwarding_A <= 2'b00;
	forwarding_B <= 2'b00;
	if(exmem_WB&&exmem_RD!=0&&exmem_RD==Rs1)
		forwarding_A <= 2'b10;
	if(exmem_WB&&exmem_RD!=0&&exmem_RD==Rs2)
		forwarding_B <= 2'b10;
	if(!(exmem_WB&&exmem_RD!=0&&exmem_RD==Rs1)&&memwb_WB&&memwb_RD!=0&&memwb_RD==Rs1)
		forwarding_A <= 2'b01;
	if(!(exmem_WB&&exmem_RD!=0&&exmem_RD==Rs2)&&memwb_WB&&memwb_RD!=0&&memwb_RD==Rs2)
		forwarding_B <= 2'b01;
end
endmodule