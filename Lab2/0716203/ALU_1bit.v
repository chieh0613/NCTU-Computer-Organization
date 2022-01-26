/***************************************************
Student Name: 黃子潔
Student ID: 0716203
***************************************************/
`timescale 1ns/1ps



module ALU_1bit(
 input    src1,       //1 bit source 1  (input)
 input    src2,       //1 bit source 2  (input)
 input    Ainvert,    //1 bit A_invert  (input)
 input    Binvert,    //1 bit B_invert  (input)
 input    Cin,        //1 bit carry in  (input)
 input    [2-1:0] operation,  //2 bit operation (input)
 output reg          result,     //1 bit result    (output)
 output reg          cout        //1 bit carry out (output)
 );

/* Write your code HERE */

wire w1,w2,w3,w4,tmp1,tmp2;
xor g0(tmp1,src1,Ainvert);
xor g1(tmp2,src2,Binvert);
assign w3 = tmp1 & tmp2;
assign w4 = tmp1 |  tmp2;
full_adder full_adder(.tmp1(tmp1),.tmp2(tmp2),.cin(Cin),.sum(w1),.cout(w2));


always @( * ) begin
 
    case(operation)
	2'b00: begin
			result <=  w3;
			cout <= 0;
		   end
	2'b01: begin
			result <= w4;
			cout <= 0;
		   end
	2'b10: begin
			result<= w1;
			cout <= w2;
		   end
	2'b11: begin
			result <= w1;
			cout <= w2;
		   end
	endcase
end

endmodule

