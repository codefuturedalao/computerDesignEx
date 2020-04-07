`include "defines.v"
module ALU(
	input wire[`REG_BUS_LENGTH-1 : 0] data1_i,
	input wire[`REG_BUS_LENGTH-1 : 0] data2_i,
	input wire[7:0] imm_i,
	input wire[4:0] aluOp_i,

	output reg[`REG_BUS_LENGTH-1 : 0] result_o,
	output reg flag_o
);
	wire[`REG_BUS_LENGTH-1 : 0]temp = {{11{imm_i[4]}},imm_i[4:0]};
	wire[`REG_BUS_LENGTH-1 : 0]temp1 = {{8{imm_i[7]}},imm_i[7:0]};
	wire signed[`REG_BUS_LENGTH-1 : 0] data1_sign = data1_i;
	wire signed[`REG_BUS_LENGTH-1 : 0] data2_sign = data2_i;
	always
		@(*) begin
			flag_o <= 1'b0;
			result_o <= 16'b0000_0000_0000_0000;
			case(aluOp_i)
				`NOP_OPCODE : 	begin
				end
				`ADD_OPCODE : begin
					result_o<= data1_i + data2_i;
				end
				`SUB_OPCODE : begin
					result_o <= data1_i - data2_i;
				end
				`MUL_OPCODE : begin
					result_o <= data1_i * data2_i;
				end
				`DIV_OPCODE : begin
					result_o <= data1_i / data2_i;
				end
				`MOD_OPCODE : begin
					result_o <= data1_i % data2_i;
				end
				`INC_OPCODE : begin
					result_o <= data1_i + 1;
				end
				`DEC_OPCODE : begin
					result_o <= data1_i - 1;
				end
				`AND_OPCODE : begin
					result_o <= data1_i & data2_i;
				end
				`OR_OPCODE : begin
					result_o <= data1_i | data2_i; 
				end
				`XOR_OPCODE : begin
					result_o <= data1_i ^ data2_i; 
				end
				`NOT_OPCODE : begin
					result_o <= ~data1_i; 
				end
				`SLL_OPCODE : begin
					result_o <= data1_i << imm_i[3:0]; 
				end
				`SAL_OPCODE : begin
					result_o <= data1_i <<< imm_i[3:0]; 
				end
				`SLR_OPCODE : begin
					result_o <= data1_i >> imm_i[3:0]; 
				end
				`SAR_OPCODE : begin
					result_o <= data1_sign >>> imm_i[3:0]; 
				end
				`MOV_OPCODE : begin
					result_o <= data2_i; 
				end
				`MOVI_OPCODE : begin
					result_o <= temp1; 
				end
				`LOD_OPCODE : begin
					result_o <= data2_i;  
				end
				`LODI_OPCODE : begin
					result_o <= data2_i + temp; 
				end
				`STO_OPCODE : begin
					result_o <= data2_i; 
				end
				`STOI_OPCODE : begin
					result_o <= data2_i + temp; 
				end
				`JEQ_OPCODE : begin
					if(data1_i - data2_i == 0)
						flag_o <= 1'b1;
					else 
						flag_o <= 1'b0;
				end
				`JNE_OPCODE : begin
					if(data1_i - data2_i != 0)
						flag_o <= 1'b1;
					else 
						flag_o <= 1'b0;
				end
				`JG_OPCODE : begin
					if(data1_sign > data2_sign )
						flag_o <= 1'b1;
					else 
						flag_o <= 1'b0;
				end
				`JGU_OPCODE : begin
					if(data1_i > data2_i )
						flag_o <= 1'b1;
					else 
						flag_o <= 1'b0;
				end
				`JL_OPCODE : begin
					if(data1_sign < data2_sign)
						flag_o <= 1'b1;
					else 
						flag_o <= 1'b0;
				end
				`JLU_OPCODE : begin
					if(data1_i < data2_i )
						flag_o <= 1'b1;
					else 
						flag_o <= 1'b0;
				end
				`JMPI_OPCODE: begin
				 	
				end
				`JMP_OPCODE : begin

				end
			endcase
		end	
endmodule
