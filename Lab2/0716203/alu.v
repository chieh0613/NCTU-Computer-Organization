/***************************************************
Student Name:黃子潔
Student ID: 0716203
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

reg t1, t2;
wire [32-1:0]carry;
wire [32-1:0]res;

ALU_1bit alu_0(.src1(src1[0]), .src2(src2[0]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(ALU_control[2]), .operation(ALU_control[1:0]), .result(res[0]), .cout(carry[0]));
ALU_1bit alu_1(.src1(src1[1]), .src2(src2[1]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[0]), .operation(ALU_control[1:0]), .result(res[1]), .cout(carry[1]));
ALU_1bit alu_2(.src1(src1[2]), .src2(src2[2]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[1]), .operation(ALU_control[1:0]), .result(res[2]), .cout(carry[2]));
ALU_1bit alu_3(.src1(src1[3]), .src2(src2[3]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[2]), .operation(ALU_control[1:0]), .result(res[3]), .cout(carry[3]));
ALU_1bit alu_4(.src1(src1[4]), .src2(src2[4]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[3]), .operation(ALU_control[1:0]), .result(res[4]), .cout(carry[4]));
ALU_1bit alu_5(.src1(src1[5]), .src2(src2[5]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[4]), .operation(ALU_control[1:0]), .result(res[5]), .cout(carry[5]));
ALU_1bit alu_6(.src1(src1[6]), .src2(src2[6]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[5]), .operation(ALU_control[1:0]), .result(res[6]), .cout(carry[6]));
ALU_1bit alu_7(.src1(src1[7]), .src2(src2[7]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[6]), .operation(ALU_control[1:0]), .result(res[7]), .cout(carry[7]));
ALU_1bit alu_8(.src1(src1[8]), .src2(src2[8]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[7]), .operation(ALU_control[1:0]), .result(res[8]), .cout(carry[8]));
ALU_1bit alu_9(.src1(src1[9]), .src2(src2[9]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[8]), .operation(ALU_control[1:0]), .result(res[9]), .cout(carry[9]));
ALU_1bit alu_10(.src1(src1[10]), .src2(src2[10]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[9]), .operation(ALU_control[1:0]), .result(res[10]), .cout(carry[10]));
ALU_1bit alu_11(.src1(src1[11]), .src2(src2[11]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[10]), .operation(ALU_control[1:0]), .result(res[11]), .cout(carry[11]));
ALU_1bit alu_12(.src1(src1[12]), .src2(src2[12]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[11]), .operation(ALU_control[1:0]), .result(res[12]), .cout(carry[12]));
ALU_1bit alu_13(.src1(src1[13]), .src2(src2[13]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[12]), .operation(ALU_control[1:0]), .result(res[13]), .cout(carry[13]));
ALU_1bit alu_14(.src1(src1[14]), .src2(src2[14]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[13]), .operation(ALU_control[1:0]), .result(res[14]), .cout(carry[14]));
ALU_1bit alu_15(.src1(src1[15]), .src2(src2[15]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[14]), .operation(ALU_control[1:0]), .result(res[15]), .cout(carry[15]));
ALU_1bit alu_16(.src1(src1[16]), .src2(src2[16]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[15]), .operation(ALU_control[1:0]), .result(res[16]), .cout(carry[16]));
ALU_1bit alu_17(.src1(src1[17]), .src2(src2[17]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[16]), .operation(ALU_control[1:0]), .result(res[17]), .cout(carry[17]));
ALU_1bit alu_18(.src1(src1[18]), .src2(src2[18]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[17]), .operation(ALU_control[1:0]), .result(res[18]), .cout(carry[18]));
ALU_1bit alu_19(.src1(src1[19]), .src2(src2[19]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[18]), .operation(ALU_control[1:0]), .result(res[19]), .cout(carry[19]));
ALU_1bit alu_20(.src1(src1[20]), .src2(src2[20]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[19]), .operation(ALU_control[1:0]), .result(res[20]), .cout(carry[20]));
ALU_1bit alu_21(.src1(src1[21]), .src2(src2[21]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[20]), .operation(ALU_control[1:0]), .result(res[21]), .cout(carry[21]));
ALU_1bit alu_22(.src1(src1[22]), .src2(src2[22]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[21]), .operation(ALU_control[1:0]), .result(res[22]), .cout(carry[22]));
ALU_1bit alu_23(.src1(src1[23]), .src2(src2[23]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[22]), .operation(ALU_control[1:0]), .result(res[23]), .cout(carry[23]));
ALU_1bit alu_24(.src1(src1[24]), .src2(src2[24]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[23]), .operation(ALU_control[1:0]), .result(res[24]), .cout(carry[24]));
ALU_1bit alu_25(.src1(src1[25]), .src2(src2[25]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[24]), .operation(ALU_control[1:0]), .result(res[25]), .cout(carry[25]));
ALU_1bit alu_26(.src1(src1[26]), .src2(src2[26]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[25]), .operation(ALU_control[1:0]), .result(res[26]), .cout(carry[26]));
ALU_1bit alu_27(.src1(src1[27]), .src2(src2[27]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[26]), .operation(ALU_control[1:0]), .result(res[27]), .cout(carry[27]));
ALU_1bit alu_28(.src1(src1[28]), .src2(src2[28]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[27]), .operation(ALU_control[1:0]), .result(res[28]), .cout(carry[28]));
ALU_1bit alu_29(.src1(src1[29]), .src2(src2[29]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[28]), .operation(ALU_control[1:0]), .result(res[29]), .cout(carry[29]));
ALU_1bit alu_30(.src1(src1[30]), .src2(src2[30]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[29]), .operation(ALU_control[1:0]), .result(res[30]), .cout(carry[30]));
ALU_1bit alu_31(.src1(src1[31]), .src2(src2[31]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .Cin(carry[30]), .operation(ALU_control[1:0]), .result(res[31]), .cout(carry[31]));


always @( carry, result ) begin
	if(rst_n == 1) begin
		cout <= carry[31];
		zero <= (result == 0)? 1:0;
	end
end

always @( carry ) begin
    if( rst_n ) begin
		if(carry[30]^carry[31]==1) overflow <= 1;
		else overflow <= 0;
	end
	else begin
	    overflow <= 0;
	end
end

always @( ALU_control, res ) begin
    if( rst_n ) begin
	   if(ALU_control == 4'b0111 && res[31]==1) begin
		    result[0] <= 1;
		    result[31:1] <= 0;
		end
		else if (ALU_control == 4'b0111 && res[31]==0) result[31:0] <= 0;
	    else result[31:0] <= res[31:0];
	end
	else begin
	   result <= 0;
    end
end


endmodule
