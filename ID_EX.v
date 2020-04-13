`include "defines.v"

module ID_EX(
	input wire clk_i,
	input wire rst_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] id_PC_i,
	input wire[`INST_BUS_LENGTH-1 : 0] id_data1_i,
	input wire[`INST_BUS_LENGTH-1 : 0] id_data2_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] id_reg3_i,
	input wire[`INST_BUS_LENGTH-1 : 0] id_inst_i,
	input wire id_jump_i,
	input wire id_immOrReg_i,
	input wire id_branch_i,
	input wire id_resultOrMem_i,
	input wire id_memRead_i,
	input wire id_memWrite_i,
	input wire id_regWrite_i,

	output reg[`INST_ADDR_LENGTH-1 : 0] ex_PC_o,
	output reg[`INST_BUS_LENGTH-1 : 0] ex_data1_o,
	output reg[`INST_BUS_LENGTH-1 : 0] ex_data2_o,
	output reg[`REG_LENGTH_IN_INST-1 : 0] ex_reg3_o,
	output reg[`INST_BUS_LENGTH-1 : 0] ex_inst_o,
	output reg ex_jump_o,
	output reg ex_immOrReg_o,
	output reg ex_branch_o,
	output reg ex_resultOrMem_o,
	output reg ex_memRead_o,
	output reg ex_memWrite_o,
	output reg ex_regWrite_o
);

	always
		@(posedge clk_i) begin
			if(rst_i == `RST_ENABLE) begin
				ex_PC_o <= `ZERO16;
				ex_data1_o <= `ZERO16;
				ex_data2_o <= `ZERO16;
				ex_reg3_o <= 3'b000;
				ex_inst_o <= `ZERO16;
				ex_jump_o <= 1'b0;
				ex_immOrReg_o <= 1'b0;
				ex_branch_o <= 1'b0;
				ex_resultOrMem_o <= 1'b0;
				ex_memRead_o <= 1'b0;
				ex_memWrite_o <= 1'b0;
				ex_regWrite_o <= 1'b0;
			end
			else begin
				ex_PC_o <= id_PC_i;
				ex_data1_o <= id_data1_i;
				ex_data2_o <= id_data2_i;
				ex_reg3_o <= id_reg3_i;
				ex_inst_o <= id_inst_i;
				ex_jump_o <= id_jump_i;
				ex_immOrReg_o <= id_immOrReg_i;
				ex_branch_o <= id_branch_i;
				ex_resultOrMem_o <= id_resultOrMem_i;
				ex_memRead_o <= id_memRead_i;
				ex_memWrite_o <= id_memWrite_i;
				ex_regWrite_o <= id_regWrite_i;
			end
		end

endmodule

