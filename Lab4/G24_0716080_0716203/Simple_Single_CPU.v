/***************************************************
Student Name: 劉文心 黃子潔
Student ID:  0716080 0716203
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);


wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;

wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire RegWrite;
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
wire MemRead,MemWrite;
wire [31:0] DM_o;
wire PCSrc;
assign PCSrc = zero & Branch;
wire [4-1:0] temp;
assign temp = {instr[30], instr[14:12]};
wire MemtoReg;
wire [2-1:0] Jump;
wire [32-1:0] pc0;
wire [32-1:0] final_result;
wire [32-1:0] WD;
wire [31:0] ALUresult;

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
        .RDdata_i(WD)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );		

Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(ALUresult),
		.data_i(RTdata_o),
		.MemRead_i(MemRead),
		.MemWrite_i(MemWrite),
		.data_o(DM_o)
		);
		
Decoder Decoder(
        .instr_i(instr), 
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
	    .RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp),
		.Jump(Jump)
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
		.data_o(pc0)
		);
		
MUX_3to1 Mux_PC(
		.data0_i(pc0),       
		.data1_i(sl_imm),
		.data2_i(RSdata_o),
		.select_i(Jump),
		.data_o(pc_i)
		);
		
MUX_2to1 Mux_MemtoReg(
		.data0_i(ALUresult),       
		.data1_i(DM_o),
		.select_i(MemtoReg),
		.data_o(final_result)
		);
		
MUX_3to1 Mux_WD(
		.data0_i(final_result),       
		.data1_i(adder1_o),
		.data2_i(32'd0),
		.select_i(Jump),
		.data_o(WD)
		);
endmodule
		  


