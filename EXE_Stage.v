module EXE_Stage (
	clk,
	rst,
	EXE_CMD,
	WB_EN,
	MEM_R_EN,
	MEM_W_EN,
	PC_in,
	Val_Rn,
	Val_Rm,
	imm,
	Shift_operand,
	Signed_imm_24,
	C,
	Dest,		
	ALU_result,
	Br_addr,
	Val_Rm_out,
	status,
	Dest_out,
	WB_EN_out,
	MEM_W_EN_out,
	MEM_R_EN_out,
	PC
);

	input clk;
	input rst;
	input [3:0] EXE_CMD;
	input WB_EN, MEM_R_EN, MEM_W_EN;
	input [31:0] PC_in;
	input [31:0] Val_Rn, Val_Rm;
	input imm;
	input [11:0] Shift_operand;
	input [23:0] Signed_imm_24;
	input C;
	input [3:0] Dest;
	
	output [31:0] ALU_result, Br_addr, Val_Rm_out;
	output [3:0] status;
	output [3:0] Dest_out;
	output WB_EN_out, MEM_W_EN_out, MEM_R_EN_out;
	output[31:0] PC;


	wire memory_enable;
	wire [31:0] second_val;

	assign PC = PC_in;
	assign Dest_out = Dest;
	assign WB_EN_out = WB_EN;
	assign MEM_W_EN_out = MEM_W_EN;
	assign MEM_R_EN_out = MEM_R_EN;
	assign Val_Rm_out = Val_Rm;

	assign memory_enable = MEM_R_EN || MEM_W_EN;


	Val2_Generator val2gen(
		.Rm(Val_Rm),
		.shift_operand(Shift_operand),
		.imm(imm),
		.Ld_St(memory_enable),
		.in2(second_val)
	);

	ALU alu(
		.in1(Val_Rn),
		.in2(second_val),
		.EXE_Command(EXE_CMD),
		.C(C),
		.result(ALU_result),
		.status(status)
	);

	Adder32bit adder(
		.in1(PC_in),
		.in2({{{8{Signed_imm_24[23]}}, Signed_imm_24}<<2}),
		.outp(Br_addr)
	);

endmodule