`include "defines.v"
module DMEM(
	input wire clk_i,
	input wire memRead_i,
	input wire memWrite_i,
	input wire[15:0] data_i,
	input wire[15:0] addr_i,
	
	output wire [15:0] data_o
);
	reg[15:0] RAM[15:0];
	assign data_o = memRead_i ? RAM[addr_i] : 16'b0000_0000_0000_0000;

	always
		@(posedge clk_i) begin
			if(memWrite_i == 1'b1) begin
				RAM[addr_i] <= data_i;
			end
		end
endmodule
