`include "defines.v"

module EX_MEM(
	input wire clk_i,
	input wire rst_i,
	input wire[`REG_BUS_LENGTH-1 : 0] ex_data1_i,
	input wire[`REG_BUS_LENGTH-1 : 0] ex_aluResult_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] ex_reg3_i,
	input wire ex_resultOrMem_i,
	input wire ex_memRead_i,
	input wire ex_memWrite_i,
	input wire ex_regWrite_i,

	output reg[`REG_BUS_LENGTH-1 : 0] mem_data1_o,
	output reg[`REG_BUS_LENGTH-1 : 0] mem_aluResult_o,
	output reg[`REG_LENGTH_IN_INST-1 : 0] mem_reg3_o,
	output reg mem_resultOrMem_o,
	output reg mem_memRead_o,
	output reg mem_memWrite_o,
	output reg mem_regWrite_o
);

	always
		@(posedge clk_i) begin
			if(rst_i == `RST_ENABLE) begin
				mem_data1_o <= `ZERO16;
				mem_aluResult_o <= `ZERO16;
				mem_reg3_o <= 3'b000;
				mem_resultOrMem_o <= 1'b0;
				mem_memRead_o <= 1'b0;
				mem_memWrite_o <= 1'b0;
				mem_regWrite_o <= 1'b0;
			end 
			else begin
				mem_data1_o <= ex_data1_i;
				mem_aluResult_o <= ex_aluResult_i;
				mem_reg3_o <= ex_reg3_i;
				mem_resultOrMem_o <= ex_resultOrMem_i;
				mem_memRead_o <= ex_memRead_i;
				mem_memWrite_o <= ex_memWrite_i;
				mem_regWrite_o <= ex_regWrite_i; 
			end
		end
				
endmodule
	
