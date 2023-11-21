module WB_Stage (
	clk,
	rst,
	PC_in,
	PC,
);
	input clk;
	input rst;
	input[31:0] PC_in;
	output[31:0] PC;

	assign PC = PC_in;
endmodule