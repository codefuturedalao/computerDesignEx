`include "defines.v"
module SYSTEM(
	input wire sysclk_i,
	input wire rst_i
);
	wire[`INST_BUS_LENGTH-1 : 0] inst_i;
	wire[`REG_BUS_LENGTH-1 : 0] memData_i;
	wire[`REG_BUS_LENGTH-1 : 0] memAddr_o;
	wire[`INST_BUS_LENGTH-1 : 0]memData_o;
	wire memRead_o;
	wire memWrite_o;
	wire[`INST_ADDR_LENGTH-1 : 0] PC_o;
	CPU myCPU(
		.clk_i(sysclk_i),.rst_i(rst_i),
		.inst_i(inst_i),.memData_i(memData_i),

		.memAddr_o(memAddr_o),.memData_o(memData_o),.memRead_o(memRead_o),.memWrite_o(memWrite_o),
		.PC_o(PC_o)
	);

	IMEM myIMEM(
		.PC_i(PC_o),.inst_o(inst_i)
	);

	DMEM myDMEM(
		.clk_i(sysclk_i),.memWrite_i(memWrite_o),.memRead_i(memRead_o),

		.data_i(memData_o),.addr_i(memAddr_o),

		.data_o(memData_i)
	);
endmodule