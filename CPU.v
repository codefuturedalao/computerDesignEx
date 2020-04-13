`include "defines.v"
module CPU(
	input wire clk_i,
	input wire rst_i,
	input wire[`INST_BUS_LENGTH-1 : 0] inst_i,
	input wire[`REG_BUS_LENGTH-1 : 0] memData_i,

	output wire[`REG_BUS_LENGTH-1 : 0] memAddr_o,
	output wire[`INST_BUS_LENGTH-1 : 0]memData_o,
	output wire memRead_o,
	output wire memWrite_o,

	output wire[`INST_ADDR_LENGTH-1 : 0] PC_o
);
	wire[`INST_ADDR_LENGTH-1 : 0] PC_i;
	wire pcNewFlag;
	PC myPC(
		.clk_i(clk_i),.rst_i(rst_i),.PC_i(PC_i),.pcNewFlag_i(pcNewFlag),

		.PC_o(PC_o)
	);

	wire[`INST_BUS_LENGTH-1 : 0] id_inst;
	wire[`INST_ADDR_LENGTH-1 : 0] id_PC;   
	IF_ID myIf_id(
		.clk_i(clk_i),.rst_i(rst_i),.if_inst_i(inst_i),.if_PC_i(PC_o),

		.id_inst_o(id_inst),.id_PC_o(id_PC)
	);
	wire[`REG_LENGTH_IN_INST-1 : 0] reg1_o;
	wire[`REG_LENGTH_IN_INST-1 : 0] reg2_o;
	wire[`REG_LENGTH_IN_INST-1 : 0] reg3_o;

	wire[`INST_BUS_LENGTH-1 : 0] inst_o;
	wire jump_o;
	wire immOrReg_o;
	wire branch_o;
	wire regWrite_o;
	wire resultOrMem_o;
	wire id_memRead;
	wire id_memWrite;
	wire[4:0] aluOp_o;
	Decoder myDecoder(
		.inst_i(id_inst),

		.reg1_o(reg1_o),.reg2_o(reg2_o),.reg3_o(reg3_o),.inst_o(inst_o),
		.jump_o(jump_o),.immOrReg_o(immOrReg_o),.branch_o(branch_o),.regWrite_o(regWrite_o),
		.resultOrMem_o(resultOrMem_o),.memRead_o(id_memRead),.memWrite_o(id_memWrite)
	);

	wire[`REG_LENGTH_IN_INST-1 : 0] wb_reg3;
	wire wb_regWrite;
	wire[`INST_BUS_LENGTH-1 : 0] data3_i;	
	wire[`INST_BUS_LENGTH-1 : 0] data1_o;	
	wire[`INST_BUS_LENGTH-1 : 0] data2_o;
	RG myRG(
		.clk_i(clk_i),.reg1_i(reg1_o),.reg2_i(reg2_o),.reg3_i(wb_reg3),
		.data3_i(data3_i),.regWrite_i(wb_regWrite),

		.data1_o(data1_o),.data2_o(data2_o)
	);
	wire[`INST_ADDR_LENGTH-1 : 0] ex_PC;
	wire[`INST_BUS_LENGTH-1 : 0] ex_data1;
	wire[`INST_BUS_LENGTH-1 : 0] ex_data2;
	wire[`REG_LENGTH_IN_INST-1 : 0] ex_reg3;
	wire[`INST_BUS_LENGTH-1 : 0] ex_inst;
	wire ex_jump;
	wire ex_immOrReg;
	wire ex_regWrite;
	wire ex_branch;
	wire ex_resultOrMem;
	wire ex_memRead;
	wire ex_memWrite;
	ID_EX myId_ex(
		.clk_i(clk_i),.rst_i(rst_i),.id_PC_i(id_PC),.id_data1_i(data1_o),
		.id_data2_i(data2_o),.id_reg3_i(reg3_o),.id_inst_i(inst_o),.id_jump_i(jump_o),
		.id_immOrReg_i(immOrReg_o),.id_branch_i(branch_o),.id_resultOrMem_i(resultOrMem_o),
		.id_memRead_i(memRead_o),.id_memWrite_i(memWrite_o),.id_regWrite_i(regWrite_o),

		.ex_PC_o(ex_PC),.ex_data1_o(ex_data1),.ex_data2_o(ex_data2),.ex_reg3_o(ex_reg3),
		.ex_inst_o(ex_inst),.ex_jump_o(ex_jump),.ex_branch_o(ex_branch),.ex_resultOrMem_o(ex_resultOrMem),
		.ex_immOrReg_o(ex_immOrReg),.ex_memRead_o(ex_memRead),.ex_memWrite_o(ex_memWrite),.ex_regWrite_o(ex_regWrite)
	);

	wire[`REG_BUS_LENGTH-1 : 0] result_o;
	wire flag_o;
	ALU myALU(
		.data1_i(ex_data1),.data2_i(ex_data2),.imm_i(ex_inst[7:0]),.aluOp_i(ex_inst[15:11]),
		
		.result_o(result_o),.flag_o(flag_o)
	);
	wire[`REG_BUS_LENGTH-1 : 0] mem_data1;
	wire[`REG_BUS_LENGTH-1 : 0] mem_aluResult;
	wire[`REG_LENGTH_IN_INST-1 : 0] mem_reg3;
	wire mem_resultOrMem;
	wire mem_memRead;
	wire mem_memWrite;
	wire mem_regWrite;
	assign memWrite_o = mem_memWrite;
	assign memRead_o = mem_memRead;
	assign memAddr_o = mem_aluResult;
	assign memData_o = mem_data1;
	EX_MEM myEx_mem(
		.clk_i(clk_i),.rst_i(rst_i),.ex_data1_i(ex_data1),.ex_aluResult_i(result_o),
		.ex_reg3_i(ex_reg3),.ex_resultOrMem_i(ex_resultOrMem),.ex_memRead_i(ex_memRead),.ex_memWrite_i(ex_memWrite),
		.ex_regWrite_i(ex_regWrite),
	
		.mem_data1_o(mem_data1),.mem_aluResult_o(mem_aluResult),.mem_reg3_o(mem_reg3),
		.mem_resultOrMem_o(mem_resultOrMem),.mem_memRead_o(mem_memRead),.mem_memWrite_o(mem_memWrite),
		.mem_regWrite_o(mem_regWrite)
	);
	wire[`REG_BUS_LENGTH-1 : 0] wb_memData;
	wire[`REG_BUS_LENGTH-1 : 0] wb_aluResult;
	wire wb_resultOrMem;
	ME_WB myMe_wb(
		.clk_i(clk_i),.rst_i(rst_i),.mem_memData_i(memData_i),.mem_aluResult_i(mem_aluResult),
		.mem_reg3_i(mem_reg3),.mem_resultOrMem_i(mem_resultOrMem),.mem_regWrite_i(mem_regWrite),

		.wb_memData_o(wb_memData),.wb_aluResult_o(wb_aluResult),.wb_reg3_o(wb_reg3),.wb_resultOrMem_o(wb_resultOrMem),
		.wb_regWrite_o(wb_regWrite)
	);

	MUX1 myMUX1(
		.memData_i(wb_memData),.aluResult_i(wb_aluResult),.resultOrMem_i(wb_resultOrMem),

		.data3_o(data3_i)
	);

//	wire[`INST_ADDR_LENGTH-1:0] adderPc;
//	ADDER myADDER(
//		.flag_i(flag_o),.branch_i(ex_branch),.offset5_i(ex_inst[4:0]),.PC_i(ex_PC),
//
//		.PC_o(adderPc)
//	);

	wire[`INST_ADDR_LENGTH-1:0] jumpPc;
	MUX3 myMUX3(
		.immOrReg_i(ex_immOrReg),.offset11_i(ex_inst[10:0]),.reg1_i(ex_data1),.PC_i(ex_PC),

		.pcJump_o(jumpPc)
	);	

	MUX2 myMUX2(
		.jump_i(ex_jump),.pcJump_i(jumpPc),
		.flag_i(flag_o),.branch_i(ex_branch),.offset5_i(ex_inst[4:0]),.PC_i(ex_PC),

		.PC_o(PC_i),.pcNewFlag_o(pcNewFlag)
	);
endmodule
