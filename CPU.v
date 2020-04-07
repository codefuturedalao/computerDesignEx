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
	PC myPC(
		.clk_i(clk_i),.rst_i(rst_i),.PC_i(PC_i),

		.PC_o(PC_o)
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
	wire[4:0] aluOp_o;
	Decoder myDecoder(
		.inst_i(inst_i),

		.reg1_o(reg1_o),.reg2_o(reg2_o),.reg3_o(reg3_o),.inst_o(inst_o),
		.jump_o(jump_o),.immOrReg_o(immOrReg_o),.branch_o(branch_o),.regWrite_o(regWrite_o),
		.resultOrMem_o(resultOrMem_o),.memRead_o(memRead_o),.memWrite_o(memWrite_o)
	);

	wire[`INST_BUS_LENGTH-1 : 0] data3_i;	
	wire[`INST_BUS_LENGTH-1 : 0] data1_o;	
	wire[`INST_BUS_LENGTH-1 : 0] data2_o;
	assign memData_o = data1_o;
	RG myRG(
		.clk_i(clk_i),.reg1_i(reg1_o),.reg2_i(reg2_o),.reg3_i(reg3_o),
		.data3_i(data3_i),.regWrite_i(regWrite_o),

		.data1_o(data1_o),.data2_o(data2_o)
	);

	wire[`REG_BUS_LENGTH-1 : 0] result_o;
	wire flag_o;
	assign memAddr_o = result_o;
	ALU myALU(
		.data1_i(data1_o),.data2_i(data2_o),.imm_i(inst_o[7:0]),.aluOp_i(inst_o[15:11]),
		
		.result_o(result_o),.flag_o(flag_o)
	);

	MUX1 myMUX1(
		.memData_i(memData_i),.aluResult_i(result_o),.resultOrMem_i(resultOrMem_o),

		.data3_o(data3_i)
	);

	wire[`INST_ADDR_LENGTH-1:0] adderPc;
	ADDER myADDER(
		.flag_i(flag_o),.branch_i(branch_o),.offset5_i(inst_o[4:0]),.PC_i(PC_o),

		.PC_o(adderPc)
	);

	wire[`INST_ADDR_LENGTH-1:0] jumpPc;
	MUX3 myMUX3(
		.immOrReg_i(immOrReg_o),.offset11_i(inst_o[10:0]),.reg1_i(data1_o),.PC_i(PC_o),

		.pcJump_o(jumpPc)
	);	

	MUX2 myMUX2(
		.jump_i(jump_o),.pcJump_i(jumpPc),.PC_i(adderPc),

		.PC_o(PC_i)
	);
endmodule