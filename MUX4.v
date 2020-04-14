`include "defines.v"

module MUX4(
	input wire[1:0] forwardA_i,
	input wire[1:0] forwardB_i,
	input wire[`REG_BUS_LENGTH-1 : 0] ex_mem_aluResult_i,
	input wire[`REG_BUS_LENGTH-1 : 0] mem_wb_regWData_i,
	input wire[`REG_BUS_LENGTH-1 : 0] regdata1_i,
	input wire[`REG_BUS_LENGTH-1 : 0] regdata2_i,

	
	output reg[`REG_BUS_LENGTH-1 : 0] data1_o,
	output reg[`REG_BUS_LENGTH-1 : 0] data2_o
);

	always
		@(*) begin
			case(forwardA_i) 
				2'b00 : begin
					data1_o <= regdata1_i;
				end
				2'b01 : begin
					data1_o <= ex_mem_aluResult_i;
				end
				2'b10 : begin
					data1_o <= mem_wb_regWData_i;
				end
			endcase
			case(forwardB_i) 
				2'b00 : begin
					data2_o <= regdata2_i;
				end
				2'b01 : begin
					data2_o <= ex_mem_aluResult_i;
				end
				2'b10 : begin
					data2_o <= mem_wb_regWData_i;
				end
			endcase
		end		
endmodule
