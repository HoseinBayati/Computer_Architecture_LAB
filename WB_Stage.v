module WB_Stage (
	clk,
	rst,
	PC_in,
	Dest_in,
	ALU_result,
	MEM_result,
	MEM_R_en,
	WB_en_in,
	PC,
	Dest,
	WB_en,
	out
);
	input clk;
	input rst;
	input[31:0] PC_in;
	input [3:0] Dest_in;
	input [31:0] ALU_result;
	input [31:0] MEM_result;
	input MEM_R_en, WB_en_in;
	output [31:0] PC;
	output [3:0] Dest;
	output WB_en;
	output [31:0] out;

	assign PC = PC_in;
	assign Dest = Dest_in;
	assign WB_en = WB_en_in;

	assign out = MEM_R_en ? MEM_result : ALU_result;


endmodule
