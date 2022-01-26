/***************************************************
Student Name: 黃子潔 
Student ID: 0716203
***************************************************/
module full_adder(input tmp1,tmp2,cin, output sum,cout);
	wire w1,w2,w3;
	xor g1(w1,tmp1,tmp2);
	xor g2(sum,w1,cin);
	and g3(w2,w1,cin);
	and g4(w3,tmp1,tmp2);
	or  g5(cout,w2,w3);
endmodule