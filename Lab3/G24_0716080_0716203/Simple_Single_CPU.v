/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signles
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire ALUSrc;
wire Branch;
wire [2-1:0] ALUOp;
wire [32-1:0] adder1_o;
wire [32-1:0] adder2_o;
wire [32-1:0] imm;
wire [32-1:0] sl_imm;
wire [32-1:0] alu_src2;
wire [4-1:0] ALU_Ctrl_o;
wire zero;
wire PCSrc;
assign PCSrc = zero & Branch;
wire [4-1:0] temp;
assign temp = {instr[30], instr[14:12]};
		
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[19:15]) ,  
        .RTaddr_i(instr[24:20]) ,  
        .RDaddr_i(instr[11:7]) ,  
        .RDdata_i(ALUresult)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );
		
Decoder Decoder(
        .instr_i(instr), 
		.ALUSrc(ALUSrc),
	    .RegWrite(RegWrite),
	    .Branch(Branch),   
		.ALUOp(ALUOp)
	    );	

Adder Adder1(
        .src1_i(pc_o),     
	    .src2_i(32'd4),     
	    .sum_o(adder1_o)    
	    );

Imm_Gen ImmGen(
		.instr_i(instr),
		.Imm_Gen_o(imm)
		);


Shift_Left_1 SL1(
		.data_i(imm),
		.data_o(sl_imm)
		);

MUX_2to1 Mux_ALUSrc(
		.data0_i(RTdata_o),       
		.data1_i(imm),
		.select_i(ALUSrc),
		.data_o(alu_src2)
		);

ALU_Ctrl ALU_Ctrl(
		.instr(temp),
		.ALUOp(ALUOp),
		.ALU_Ctrl_o(ALU_Ctrl_o)
		);
		
Adder Adder2(
        .src1_i(pc_o),     
	    .src2_i(sl_imm),     
	    .sum_o(adder2_o)    
	    );
		
alu alu(
		.rst_n(rst_i),
		.src1(RSdata_o),
		.src2(alu_src2),
		.ALU_control(ALU_Ctrl_o),
		.zero(zero),
		.result(ALUresult)
		//.cout(),
		//.overflow()
		);
	
MUX_2to1 Mux_PCSrc(
		.data0_i(adder1_o),       
		.data1_i(adder2_o),
		.select_i(PCSrc),
		.data_o(pc_i)
		);
		
endmodule
		  


