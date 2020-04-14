`include "defines.v"
module IMEM(
	input wire[`INST_ADDR_LENGTH-1 : 0] PC_i,
	output wire[`INST_BUS_LENGTH-1 : 0] inst_o
);
	wire[`INST_BUS_LENGTH-1:0] ROM[37:0];
	assign inst_o = ROM[PC_i];

	assign ROM[0] = 16'b10001_000_000_00000;  //mov $r0,0
	assign ROM[1] = 16'b10001_001_000_00001;  //mov $r1,1
	assign ROM[2] = 16'b10001_010_000_00010;  //mov $r2,2
	assign ROM[3] = 16'b10001_011_000_00011;  //mov $r3,3
	assign ROM[4] = 16'b10001_100_000_00100;  //mov $r4,4

	assign ROM[5] = 16'b00001_001_010_00000;  //add 1,2 	$r1:3	
	assign ROM[6] = 16'b00010_001_010_00000;  //sub 1,2	$r1:1
	assign ROM[7] = 16'b00011_011_010_00000;  //mul 3,2	$r3:6	
	assign ROM[8] = 16'b00100_100_010_00000;  //div 4,2     $r4:2
	assign ROM[9] = 16'b00101_100_011_00000;  //mod 4,3	$r4:2
	assign ROM[10] = 16'b01010_001_010_00000; //xor 1，2 	$r1:3
	assign ROM[11] = 16'b01011_001_000_00000; //not 1       $r1:fffc
	assign ROM[12] = 16'b01100_001_000_00010; //sll 1,2     $r1:fff0
	assign ROM[13] = 16'b01101_001_000_00010; //sal 1,2	$r1:ffc0
	assign ROM[14] = 16'b01110_011_000_00010; //slr 3,2	$r3:1
	assign ROM[15] = 16'b01111_001_000_00010; //sar 1,2	$r1:fff0
	assign ROM[16] = 16'b10000_001_010_00000; //mov 1,2	$r1:2
	assign ROM[17] = 16'b10001_011_000_00011; //movi 3,i3	$r3:3
	assign ROM[18] = 16'b10100_011_001_00000; //sto r3,r1   Mem[r1] = 3
	assign ROM[19] = 16'b10101_001_000_00001; //stoi r1,r0,1 Mem[1] = 2 
	assign ROM[20] = 16'b10010_010_001_00000; //lod r2,r1	$r2:mem[r1] = 3
	assign ROM[21] = 16'b10011_010_000_00001; //lodi r2,1	$r2:mem[1] = 2
	
	assign ROM[22] = 16'b10110_001_010_00010; //jeq r1,r2,2 PC = 24;
	assign ROM[23] = 16'b10001_100_000_00101;  //mov $r4,5
	assign ROM[24] = 16'b10111_010_011_00010; //jne r2,r3,2 PC = 26;
	assign ROM[25] = 16'b00000_000_000_00000; //nop
	assign ROM[26] = 16'b10001_001_111_11111; //movi r1,-1	
	assign ROM[27] = 16'b11000_001_010_00010; //jg -1,2 PC = 27
	assign ROM[28] = 16'b11001_011_010_00010; //jgu 2^16-1,2 PC = 30
	assign ROM[29] = 16'b00000_000_000_00000; //nop
	assign ROM[30] = 16'b11010_010_001_00010; //jl 2,-1 PC = 31
	assign ROM[31] = 16'b11011_010_001_00010; //jlu 2,2^16-1 Pc = 33
	assign ROM[32] = 16'b00000_000_000_00000; //nop
	assign ROM[33] = 16'b11100_000_000_00010; //jmpi 2; PC = 35
	assign ROM[34] = 16'b00110_010_000_00000; //nop
	assign ROM[35] = 16'b11101_001_000_00000; //jmp $r1 PC = 34
	assign ROM[36] = 16'b00110_010_000_00000; //nop
	assign ROM[37] = 16'b00110_010_000_00000; //nop

endmodule    
                            
                            
                            
                           
                            
                            
                            
                            
                            
