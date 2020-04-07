`include "defines.v"
module MUX2(
	input wire jump_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] pcJump_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] PC_i,

	output wire[`INST_ADDR_LENGTH-1 : 0] PC_o
);
	assign PC_o = jump_i ? pcJump_i : PC_i;
endmodule
