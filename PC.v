`include "defines.v"
module PC(
	input wire clk_i,
	input wire rst_i,
	input wire[`INST_ADDR_LENGTH-1 : 0] PC_i,
	input wire pcNewFlag_i,
	output reg[`INST_ADDR_LENGTH-1 : 0] PC_o
);
	always @(posedge clk_i)
		begin
			if(rst_i == `RST_ENABLE)
				PC_o <= 16'b0000_0000_0000_0000;
			else if(pcNewFlag_i == 1'b1) 
				PC_o <= PC_i;
			else 
				PC_o <= PC_o + 1'b1;

		end
endmodule
