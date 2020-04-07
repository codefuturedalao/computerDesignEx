`include "defines.v"
module ADDER(
	input wire flag_i,
	input wire branch_i,
	input wire[4:0] offset5_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] PC_i,
	
	output wire[`INST_ADDR_LENGTH-1 : 0] PC_o
);
	wire bran = flag_i & branch_i;
	wire[15:0] offset16 = {{11{offset5_i[4]}},offset5_i};
	assign PC_o = bran ? (PC_i + offset16) : PC_i + 1;
endmodule
	
