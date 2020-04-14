`include "defines.v"

module DATA_HAZARD_CONTROL(
	input wire ex_mem_regWrite_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] ex_mem_reg3_i,
	input wire mem_wb_regWrite_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] mem_wb_reg3_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] id_ex_rs,
	input wire[`REG_LENGTH_IN_INST-1 : 0] id_ex_rt,

	output reg[1:0] forwardA_o,
	output reg[1:0] forwardB_o
);

	always
		@(*) begin
			//put the mem_wb regWrite first to keep the order
			//if i+2 and i+1    i+2 and i both have data hazard
			//we should consider the newest hazard --- i+1 which
			//is being stage ex_mem
			if((ex_mem_regWrite_i == 1'b1) && (ex_mem_reg3_i == id_ex_rs)) begin
				forwardA_o <= 2'b01;
			end
			else if((mem_wb_regWrite_i == 1'b1) && (mem_wb_reg3_i == id_ex_rs)) begin
				forwardA_o <= 2'b10;
			end
			else begin
				forwardA_o <= 2'b00;
			end	
			
			if((ex_mem_regWrite_i == 1'b1) && (ex_mem_reg3_i == id_ex_rt)) begin
				forwardB_o <= 2'b01;
			end
			else if((mem_wb_regWrite_i == 1'b1) && (mem_wb_reg3_i == id_ex_rt)) begin
				forwardB_o <= 2'b10;
			end
			else begin
				forwardB_o <= 2'b00;
			end	
		end

endmodule
