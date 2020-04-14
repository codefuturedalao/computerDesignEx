`include "defines.v"

module ME_WB(
	input wire clk_i,
	input wire rst_i,
	input wire mem_resultOrMem_i,
	input wire[`REG_BUS_LENGTH-1 : 0] mem_memData_i,
	input wire[`REG_BUS_LENGTH-1 : 0] mem_aluResult_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] mem_reg3_i,
	input wire mem_regWrite_i,
	input wire[5:0]stall_i,

	output reg[`REG_BUS_LENGTH-1 : 0] wb_memData_o,
	output reg[`REG_BUS_LENGTH-1 : 0] wb_aluResult_o,
	output reg[`REG_LENGTH_IN_INST-1 : 0] wb_reg3_o,
	output reg wb_resultOrMem_o,
	output reg wb_regWrite_o
);
	always
		@(posedge clk_i) begin
			if(rst_i == `RST_ENABLE) begin
				wb_memData_o <= `ZERO16;
				wb_aluResult_o <= `ZERO16;
				wb_reg3_o <= 3'b000;
				wb_resultOrMem_o <= 1'b0;
				wb_regWrite_o <= 1'b0;
			end
			else if(stall_i[1] == 1'b1 && stall_i[0] == 1'b1) begin
			end
			else if(stall_i[1] == 1'b1 && stall_i[0] == 1'b0) begin
				wb_memData_o <= `ZERO16;
				wb_aluResult_o <= `ZERO16;
				wb_reg3_o <= 3'b000;
				wb_resultOrMem_o <= 1'b0;
				wb_regWrite_o <= 1'b0;
			end
			else begin
				wb_memData_o <= mem_memData_i;
				wb_aluResult_o <= mem_aluResult_i;
				wb_reg3_o <= mem_reg3_i;
				wb_resultOrMem_o <= mem_resultOrMem_i;
				wb_regWrite_o <= mem_regWrite_i;
			end
		end

endmodule
