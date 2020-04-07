`include "defines.v"
module RG(
	input wire clk_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] reg1_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] reg2_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] reg3_i,
	input wire[`INST_BUS_LENGTH-1 : 0] data3_i,	
	input wire regWrite_i,

	output wire[`INST_BUS_LENGTH-1 : 0] data1_o,	
	output wire[`INST_BUS_LENGTH-1 : 0] data2_o	
);
	reg[`REG_BUS_LENGTH-1 : 0] RAM [`REG_NUMBER-1 : 0];
	assign data1_o = RAM[reg1_i];
	assign data2_o = RAM[reg2_i];
	always
		@(posedge clk_i)  begin
			if(regWrite_i == 1)
				RAM[reg3_i] <= data3_i;
		end
endmodule
