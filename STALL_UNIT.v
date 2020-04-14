`include "defines.v"

module STALL_UNIT(
	input wire ex_memRead_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] ex_reg3_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] id_reg1_i,
	input wire[`REG_LENGTH_IN_INST-1 : 0] id_reg2_i,
	input wire id_reg1Read_i,
	input wire id_reg2Read_i,

	output reg[5:0] stall_o
);
	always
		@(*) begin
			stall_o <= 6'b000_000;
			if(ex_memRead_i == 1'b1) begin//that means lod/lodi in stage ex
				if((id_reg1Read_i == 1'b1) && (ex_reg3_i == id_reg1_i)) begin
					stall_o <= 6'b111_000;
				end
				if((id_reg2Read_i == 1'b1) && (ex_reg3_i == id_reg2_i)) begin
					stall_o <= 6'b111_000;
				end
			end
		end
					



endmodule
