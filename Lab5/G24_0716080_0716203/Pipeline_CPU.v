/***************************************************
Student Name: 劉文心 黃子潔
Student ID: 0716080 0716203
***************************************************/

`timescale 1ns/1ps
module Pipeline_CPU(
	input clk_i,
	input rst_i
	);

wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;

wire [31:0] RS_read;
wire [31:0] RT_read;
wire [31:0] ifid_RSdata_o;
wire [31:0] ifid_RTdata_o;
wire [31:0] ifid_instr;
wire ifid_ALUSrc;
wire ifid_MemtoReg;
wire ifid_RegWrite;
wire ifid_MemRead;
wire ifid_MemWrite;
wire [1:0] ifid_ALUOp;
wire [31:0] ifid_imm_o;
wire [3:0] ifid_ALU_ctrl;
assign ifid_ALU_ctrl = {ifid_instr[30], ifid_instr[14:12]};

wire idex_ALUSrc;
wire idex_MemtoReg;
wire idex_RegWrite;
wire idex_MemRead;
wire idex_MemWrite;
wire [1:0] idex_ALUOp;
wire [31:0] idex_RS_data;
wire [31:0] idex_RT_data;
wire [31:0] idex_imm;
wire [3:0] idex_ALU_ctrl;
wire [4:0] idex_RD;
wire [31:0] ALUSrc2;
wire [3:0] ALU_Ctrl_o;
wire [31:0] idex_ALU_result;
wire [4:0] idex_RS;
wire [4:0] idex_RT;
wire [1:0] forwarding_A;
wire [1:0] forwarding_B;
wire forwarding_RS;
wire forwarding_RT;
wire [31:0] SRC1;
wire [31:0] SRC2;

wire exmem_MemtoReg;
wire exmem_RegWrite;
wire exmem_MemRead;
wire exmem_MemWrite;
wire [31:0] exmem_ALU_result;
wire [31:0] exmem_RT_data;
wire [4:0] exmem_RD;
wire [31:0] exmem_data;

wire [31:0] memwb_data;
wire memwb_MemtoReg;
wire memwb_RegWrite;
wire [31:0] memwb_ALU_result;
wire [4:0] memwb_RD;

wire [31:0] Write_data;

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
		
Adder Adder1(
        .src1_i(pc_o),     
	    .src2_i(32'd4),     
	    .sum_o(pc_i)    
	    );
		
////////////////////////////////
		
IF_ID ifid(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.instr_i(instr),
		.instr_o(ifid_instr)
		);

////////////////////////////////
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(ifid_instr[19:15]) ,  
        .RTaddr_i(ifid_instr[24:20]) ,  
        .RDaddr_i(memwb_RD) ,  
        .RDdata_i(Write_data)  , 
        .RegWrite_i(memwb_RegWrite),
        .RSdata_o(RS_read) ,  
        .RTdata_o(RT_read)   
        );	
		
ForwardingUnit2 forwardingunit2(
		.Rs1(ifid_instr[19:15]),
		.Rs2(ifid_instr[24:20]),
		.memwb_RD(memwb_RD),
		.memwb_WB(memwb_RegWrite),
		.forwarding_RS(forwarding_RS),
		.forwarding_RT(forwarding_RT)
		);

Decoder Decoder(
        .instr_i(ifid_instr), 
		.ALUSrc(ifid_ALUSrc),
		.MemtoReg(ifid_MemtoReg),
	    .RegWrite(ifid_RegWrite),
		.MemRead(ifid_MemRead),
		.MemWrite(ifid_MemWrite),
		.ALUOp(ifid_ALUOp)
	    );
		
MUX_2to1 MUX_RSSrc(
		.data0_i(RS_read),       
		.data1_i(Write_data),
		.select_i(forwarding_RS),
		.data_o(ifid_RSdata_o)
		);
		
MUX_2to1 MUX_RTSrc(
		.data0_i(RT_read),       
		.data1_i(Write_data),
		.select_i(forwarding_RT),
		.data_o(ifid_RTdata_o)
		);
		
		
Imm_Gen ImmGen(
		.instr_i(ifid_instr),
		.Imm_Gen_o(ifid_imm_o)
		);	

////////////////////////////////

ID_EX idex(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.ALUSrc_i(ifid_ALUSrc),
		.MemtoReg_i(ifid_MemtoReg),
		.RegWrite_i(ifid_RegWrite),
		.MemRead_i(ifid_MemRead),
		.MemWrite_i(ifid_MemWrite),
		.ALUOp_i(ifid_ALUOp),
		.RS_data_i(ifid_RSdata_o),
		.RT_data_i(ifid_RTdata_o),
		.imm_i(ifid_imm_o),
		.ALU_ctrl_i(ifid_ALU_ctrl),
		.RS_i(ifid_instr[19:15]),
		.RT_i(ifid_instr[24:20]),
		.RD_i(ifid_instr[11:7]),
		
		.ALUSrc_o(idex_ALUSrc),
		.MemtoReg_o(idex_MemtoReg),
		.RegWrite_o(idex_RegWrite),
		.MemRead_o(idex_MemRead),
		.MemWrite_o(idex_MemWrite),
		.ALUOp_o(idex_ALUOp),
		.RS_data_o(idex_RS_data),
		.RT_data_o(idex_RT_data),
		.imm_o(idex_imm),
		.ALU_ctrl_o(idex_ALU_ctrl),
		.RS_o(idex_RS),
		.RT_o(idex_RT),
		.RD_o(idex_RD)
		);

////////////////////////////////
			
MUX_3to1 Mux_ALUSrc1(
		.data0_i(idex_RS_data),
		.data1_i(Write_data),
		.data2_i(exmem_ALU_result),
		.select_i(forwarding_A),
		.data_o(SRC1)
		);
		
MUX_3to1 Mux_ALUSrc2(
		.data0_i(idex_RT_data),
		.data1_i(Write_data),
		.data2_i(exmem_ALU_result),
		.select_i(forwarding_B),
		.data_o(ALUSrc2)
		);

MUX_2to1 Mux_ALUSrc(
		.data0_i(ALUSrc2),       
		.data1_i(idex_imm),
		.select_i(idex_ALUSrc),
		.data_o(SRC2)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr(idex_ALU_ctrl),
		.ALUOp(idex_ALUOp),
		.ALU_Ctrl_o(ALU_Ctrl_o)
		);
			
alu alu(
		.rst_n(rst_i),
		.src1(SRC1),
		.src2(SRC2),
		.ALU_control(ALU_Ctrl_o),
		.result(idex_ALU_result)
		);
		
ForwardingUnit forwardingunit(
		.Rs1(idex_RS),
		.Rs2(idex_RT),
		.exmem_RD(exmem_RD),
		.memwb_RD(memwb_RD),
		.exmem_WB(exmem_RegWrite),
		.memwb_WB(memwb_RegWrite),
		.forwarding_A(forwarding_A),
		.forwarding_B(forwarding_B)
		);

////////////////////////////////

EX_MEM exmem(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.MemtoReg_i(idex_MemtoReg),
		.RegWrite_i(idex_RegWrite),
		.MemRead_i(idex_MemRead),
		.MemWrite_i(idex_MemWrite),
		.ALU_result_i(idex_ALU_result),
		.RT_data_i(ALUSrc2),
		.RD_i(idex_RD),
		.MemtoReg_o(exmem_MemtoReg),
		.RegWrite_o(exmem_RegWrite),
		.MemRead_o(exmem_MemRead),
		.MemWrite_o(exmem_MemWrite),
		.ALU_result_o(exmem_ALU_result),
		.RT_data_o(exmem_RT_data),
		.RD_o(exmem_RD)
		);

////////////////////////////////

Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(exmem_ALU_result),
		.data_i(exmem_RT_data),
		.MemRead_i(exmem_MemRead),
		.MemWrite_i(exmem_MemWrite),
		.data_o(exmem_data)
		);
	
////////////////////////////////

MEM_WB memwb(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.MemtoReg_i(exmem_MemtoReg),
		.RegWrite_i(exmem_RegWrite),
		.mem_i(exmem_data),
		.ALU_result_i(exmem_ALU_result),
		.RD_i(exmem_RD),
		.MemtoReg_o(memwb_MemtoReg),
		.RegWrite_o(memwb_RegWrite),
		.mem_o(memwb_data),
		.ALU_result_o(memwb_ALU_result),
		.RD_o(memwb_RD)
		);

////////////////////////////////
		
MUX_2to1 Mux_MemtoReg(
		.data0_i(memwb_ALU_result),       
		.data1_i(memwb_data),
		.select_i(memwb_MemtoReg),
		.data_o(Write_data)
		);
		
endmodule
		  


