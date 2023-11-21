module ID_Stage (
	clk,
	rst,
	Instruction,
	Result_WB,
	writeBackEn,
	Dest_wb,
	hazard,
	SR,
	PC_in,
	WB_EN,
	MEM_R_EN,
	MEM_W_EN,
	B_out,
	S_out,
	EXE_CMD,
	Val_Rn,
	Val_Rm,
	Instruction_out,
	imm,
	Shift_operand,
	Signed_imm_24,
	Dest,
	src1,
	src2,
	Two_src,
	PC
);
	input clk;
	input rst;
	input [31:0] Instruction;
	input [31:0] Result_WB;
	input writeBackEn;
	input [3:0] Dest_wb;
	input hazard;
	input [3:0] SR;
	input[31:0] PC_in;

	output reg WB_EN;
	output reg MEM_R_EN;
	output MEM_W_EN;
	output reg B_out, S_out;
	output reg [3:0] EXE_CMD;
	output [31:0] Val_Rn, Val_Rm;
	output [31:0] Instruction_out;
	output imm;
	output [11:0] Shift_operand;
	output [23:0] Signed_imm_24;
	output [3:0] Dest;
	output [3:0] src1, src2;
	output Two_src;
	output[31:0] PC;



	wire [3:0] EXE_CMD_temp;
	reg [3:0] src2_temp;
	wire mem_read, mem_write, wb_enable, B_temp, S_temp, check; 
	reg mem_write_temp;

	assign Dest = Instruction[15:12];
	assign src1 = Instruction[19:16];
	assign src2 = src2_temp;
	assign PC = PC_in;
	assign Instruction_out = Instruction;
	assign Shift_operand = Instruction[11:0];
	assign Signed_imm_24 = Instruction[23:0];
	assign MEM_W_EN = mem_write_temp;
	assign imm = Instruction[25];
	assign Two_src = mem_write || (~Instruction[25]);

	Register_File register_file(clk, rst, src1, src2_temp, Dest_wb, Result_WB, writeBackEn, Val_Rn, Val_Rm);

	Control_Unit control_unit(Instruction[27:26], Instruction[24:21], Instruction[20], EXE_CMD_temp, mem_read, mem_write, wb_enable, B_temp, S_temp);

	Condition_Check condition_check(Instruction[31:28], SR, check);

	always @(*) begin
			if(hazard || !check) begin
				{WB_EN, MEM_R_EN, mem_write_temp, EXE_CMD, B_out, S_out} <= 9'b0;
			end

			else begin
				{WB_EN, MEM_R_EN, mem_write_temp, EXE_CMD, B_out, S_out} <= {wb_enable, mem_read, mem_write, EXE_CMD_temp, B_temp, S_temp};
			end
	end

	always @(*) begin
			if(mem_write_temp) begin
				src2_temp <= Instruction[15:12];
			end

			else begin
				src2_temp <= Instruction[3:0];
			end
	end

endmodule

