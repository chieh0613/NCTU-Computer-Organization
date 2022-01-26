/***************************************************
Student Name: 劉文心 黃子潔
Student ID:  0716080 0716203
***************************************************/

`timescale 1ns/1ps

module Shift_Left_1(
    input  [31:0] data_i,
    output [31:0] data_o
    );

/* Write your code HERE */

assign data_o = data_i << 1;

endmodule