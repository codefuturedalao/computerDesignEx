`include "defines.v"
module Decoder(
	input wire[`INST_BUS_LENGTH-1 : 0] inst_i,

	output wire[`REG_LENGTH_IN_INST-1 : 0] reg1_o,
	output wire[`REG_LENGTH_IN_INST-1 : 0] reg2_o,
	output wire[`REG_LENGTH_IN_INST-1 : 0] reg3_o,

	output wire[`INST_BUS_LENGTH-1 : 0] inst_o,
	output reg jump_o,
	output reg immOrReg_o,
	output reg branch_o,
	output reg regWrite_o,
	output reg reg1Read_o,
	output reg reg2Read_o,
	output reg resultOrMem_o,
	output reg memRead_o,
	output reg memWrite_o
);
	assign inst_o = inst_i; 
	assign reg1_o = inst_i[10:8];
	assign reg2_o = inst_i[7:5];
	assign reg3_o = inst_i[10:8];
	wire[4:0] opCode = inst_i[15:11];
	always
		@(*) begin
			jump_o <= 1'b0;
			immOrReg_o <= 1'b0;
			branch_o <= 1'b0;
			regWrite_o <=  1'b0;
			reg1Read_o <= 1'b1;
			reg2Read_o <= 1'b1;
			resultOrMem_o <= 1'b1;
			memWrite_o <= 1'b0;
			memRead_o <= 1'b0;
			case(opCode) 
				`NOP_OPCODE : begin
					reg1Read_o <= 1'b0;
					reg2Read_o <= 1'b0;
				end
				`ADD_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`SUB_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`MUL_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`DIV_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`MOD_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`INC_OPCODE : begin
					reg2Read_o <= 1'b0;
					regWrite_o <= 1'b1;
				end
				`DEC_OPCODE : begin
					reg2Read_o <= 1'b0;
					regWrite_o <= 1'b1;
				end
				`AND_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`OR_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`XOR_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`NOT_OPCODE : begin
					reg2Read_o <= 1'b0;
					regWrite_o <= 1'b1;
				end
				`SLL_OPCODE : begin
					reg2Read_o <= 1'b0;
					regWrite_o <= 1'b1;
				end
				`SAL_OPCODE : begin
					reg2Read_o <= 1'b0;
					regWrite_o <= 1'b1;
				end
				`SLR_OPCODE : begin
					reg2Read_o <= 1'b0;
					regWrite_o <= 1'b1;
				end
				`SAR_OPCODE : begin
					reg2Read_o <= 1'b0;
					regWrite_o <= 1'b1;
				end
				`MOV_OPCODE : begin
					regWrite_o <= 1'b1;
				end
				`MOVI_OPCODE : begin
					reg1Read_o <= 1'b0;
					reg2Read_o <= 1'b0;
					regWrite_o <= 1'b1;
				end
				`LOD_OPCODE : begin
					reg1Read_o <= 1'b0;
					regWrite_o <= 1'b1;
					resultOrMem_o <= 1'b0;
					memRead_o <= 1'b1;
				end
				`LODI_OPCODE : begin
					reg1Read_o <= 1'b0;
					regWrite_o <= 1'b1;
					resultOrMem_o <= 1'b0;
					memRead_o <= 1'b1;
				end
				`STO_OPCODE : begin
					memWrite_o <= 1'b1;
				end
				`STOI_OPCODE : begin
					memWrite_o <= 1'b1;
				end
				`JEQ_OPCODE : begin
					branch_o <= 1'b1;
				end
				`JNE_OPCODE : begin
					branch_o <= 1'b1;
				end
				`JG_OPCODE : begin
					branch_o <= 1'b1;
				end
				`JGU_OPCODE : begin
					branch_o <= 1'b1;
				end
				`JL_OPCODE : begin
					branch_o <= 1'b1;
				end
				`JLU_OPCODE : begin
					branch_o <= 1'b1;
				end
				`JMPI_OPCODE: begin
					reg1Read_o <= 1'b0;
					reg2Read_o <= 1'b0;
					jump_o <= 1'b1;
					immOrReg_o <= 1'b1;
				end
				`JMP_OPCODE : begin
					reg2Read_o <= 1'b0;
					jump_o <= 1'b1;
					immOrReg_o <= 1'b0;
				end
			endcase
		end
endmodule
