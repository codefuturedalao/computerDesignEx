`include "defines.v"
module RG(
	input wire clk_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] reg1_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] reg2_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] reg3_i,
	input wire[`INST_BUS_LENGTH-1 : 0] data3_i,	
	input wire reg1Read_i,
	input wire reg2Read_i,
	input wire regWrite_i,

	output reg[`INST_BUS_LENGTH-1 : 0] data1_o,	
	output reg[`INST_BUS_LENGTH-1 : 0] data2_o	
);
	reg[`REG_BUS_LENGTH-1 : 0] RAM [`REG_NUMBER-1 : 0];
	always
		@(*) begin
			if((regWrite_i == 1'b1) && (reg3_i == reg1_i))
				data1_o <= data3_i;
			else if(reg1Read_i == 1'b1)
				data1_o <= RAM[reg1_i];
			else 
				data1_o <= `ZERO16;
			if((regWrite_i == 1'b1) && (reg3_i == reg2_i))
				data2_o <= data3_i;
			else if(reg2Read_i == 1'b1)
				data2_o <= RAM[reg2_i];
			else
				data2_o <= `ZERO16;
		end
	always
		@(posedge clk_i)  begin
			if(regWrite_i == 1'b1)
				RAM[reg3_i] <= data3_i;
		end
endmodule
