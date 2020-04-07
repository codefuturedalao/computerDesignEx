`include "defines.v"
`timescale 1ns/1ns
module PC_tb(

);

	reg clk;
	reg rst;
	reg[`INST_ADDR_LENGTH-1 : 0] PC_i;
	wire[`INST_ADDR_LENGTH-1 : 0] PC_o;
	initial
		begin
			clk <= 1'b0;
			rst <= `RST_ENABLE;
			PC_i <= 16'b0000_0000_0000_0000;
		end

	always 
		begin
			#5;
			clk <= ~clk;
		end

	initial 
		begin
			#55;
			rst <= ~rst;
			#160;
			rst <= ~rst;
		end

	initial 
		begin #55
			for(;PC_i < 16;) begin
				PC_i <= PC_i + 1'b1; 
				#10;
			end
		end
	
	PC PC0(.clk_i(clk),.rst_i(rst),.PC_i(PC_i),
		
		.PC_o(PC_o)
	);

endmodule
