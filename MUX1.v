`include "defines.v"
module MUX1(
	input wire[`REG_BUS_LENGTH-1 : 0] memData_i,
	input wire[`REG_BUS_LENGTH-1 : 0] aluResult_i,
	input wire resultOrMem_i,

	output wire[`REG_BUS_LENGTH-1 : 0] data3_o 
);
	assign data3_o = resultOrMem_i ? aluResult_i : memData_i;
endmodule
