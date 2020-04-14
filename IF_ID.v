`include "defines.v"

module IF_ID(
	input wire clk_i,
	input wire rst_i,
	input wire[`INST_BUS_LENGTH-1 : 0] if_inst_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] if_PC_i,
	input wire[5:0]stall_i,
	input wire flush_i,

	output reg[`INST_BUS_LENGTH-1 : 0] id_inst_o,
	output reg[`INST_ADDR_LENGTH-1 : 0] id_PC_o
);

	always 
		@(posedge clk_i) begin
			if(rst_i == `RST_ENABLE) begin
				id_inst_o <= `ZERO16;
				id_PC_o <= `ZERO16;
			end
			else if(flush_i == 1'b1) begin
				id_inst_o <= `ZERO16;
				id_PC_o <= `ZERO16;
			end
			else if(stall_i[4] == 1'b1 && stall_i[3] == 1'b1) begin
				id_inst_o <= id_inst_o;
				id_PC_o <= id_PC_o;
			end	
			else if(stall_i[4] == 1'b1 && stall_i[3] == 1'b0) begin
				id_inst_o <= `ZERO16;
				id_PC_o <= `ZERO16;
			end
			else begin
				id_inst_o <= if_inst_i;
				id_PC_o <= if_PC_i;
			end
		end
	

endmodule
