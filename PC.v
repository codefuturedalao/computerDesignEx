`include "defines.v"
module PC(
	input wire clk_i,
	input wire rst_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] PC_i,
	output reg[`INST_ADDR_LENGTH-1 : 0] PC_o
);
	always @(posedge clk_i)
		begin
			if(rst_i == `RST_ENABLE)
				PC_o <= 16'b0000_0000_0000_0000;
			else
				PC_o <= PC_i;
		end
endmodule
