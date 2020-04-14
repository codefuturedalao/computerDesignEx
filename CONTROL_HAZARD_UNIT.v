`include "defines.v"

module CONTROL_HAZARD_UNIT(
	input wire flag_i,
	input wire branch_i,
	input wire jump_i,

	output wire flush_o   // flush if/id and id/ex
);
	assign flush_o = (flag_i & branch_i) | jump_i;
endmodule

