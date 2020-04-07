`include "defines.v"
module MUX3(
	input wire immOrReg_i,
	input wire[10:0] offset11_i,
	input wire[15:0] reg1_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] PC_i,

	output wire[`INST_ADDR_LENGTH-1 : 0] pcJump_o
);
	wire[15:0] offset16 = {{5{offset11_i[10]}},offset11_i};
	assign pcJump_o = immOrReg_i ? (PC_i + offset16) : (PC_i + reg1_i);
endmodule
