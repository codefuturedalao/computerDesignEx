`include "defines.v"
module MUX2(
	input wire flag_i,
	input wire branch_i,
	input wire[4:0] offset5_i,
	input wire jump_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] pcJump_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] PC_i,

	output reg[`INST_ADDR_LENGTH-1 : 0] PC_o,
	output reg pcNewFlag_o
);
	wire[15:0] offset16 = {{11{offset5_i[4]}},offset5_i};
	always
		@(*) begin
			pcNewFlag_o <= 1'b0;
			if((flag_i & branch_i) == 1'b1) begin
				PC_o <= PC_i + offset16;
				pcNewFlag_o <= 1'b1;
			end
			else if(jump_i == 1'b1) begin
				PC_o <= pcJump_i;
				pcNewFlag_o <= 1'b1;
			end
			else begin
				PC_o <= `ZERO16;
				pcNewFlag_o <= 1'b0;
			end
		end


endmodule
