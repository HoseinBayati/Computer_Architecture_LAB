module ID_Stage_Reg (
  clk,
  rst,
  flush,
  freeze,
  WB_EN_IN,
  MEM_R_EN_IN,
  MEM_W_EN_IN,
  B_IN,
  S_IN,
  EXE_CMD_IN,
  PC_in,
  Val_Rn_IN,
  Val_Rm_IN,
  imm_IN,
  Shift_operand_IN,
  Signed_imm_24_IN,
  Dest_IN,
  Instruction,
  src_1_in,
  src_2_in,
  carry_in,
  WB_EN,
  MEM_R_EN,
  MEM_W_EN,
  B,
  S,
  EXE_CMD,
  PC,
  Val_Rn,
  Val_Rm,
  imm,
  Shift_operand,
  Signed_imm_24,
  Dest,
  Instruction_out,
  src_1,
  src_2,
  carry_out
);

	input clk;
	input rst;
	input flush;
	input freeze;
	input WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN;
	input B_IN, S_IN;
	input [3:0] EXE_CMD_IN;
	input [31:0] PC_in;
	input [31:0] Val_Rn_IN, Val_Rm_IN;
	input imm_IN;
	input [11:0] Shift_operand_IN;
	input [23:0] Signed_imm_24_IN;
	input [3:0] Dest_IN;
	input [31:0] Instruction;
	input [3:0] src_1_in, src_2_in;
	input carry_in;

	output reg WB_EN, MEM_R_EN, MEM_W_EN, B, S;
	output reg [3:0] EXE_CMD;
	output reg [31:0] PC;
	output reg [31:0] Val_Rn, Val_Rm;
	output reg imm;
	output reg [11:0] Shift_operand;
	output reg [23:0] Signed_imm_24;
	output reg [3:0] Dest;
	output reg [31:0] Instruction_out;
	output reg [3:0] src_1, src_2;
	output reg carry_out;

  always @(posedge clk, posedge rst) begin
	if (rst) begin
		PC <= 0;
		Instruction_out <= 0;
		Dest <= 0;
		Val_Rn <= 0;
		Val_Rm <=0;
		Signed_imm_24 <= 0;
		Shift_operand <= 0;
		EXE_CMD <= 0;
		MEM_R_EN <= 0;
		MEM_W_EN <= 0;
		WB_EN <= 0;
		imm <= 0;
		B <= 0;
		S <= 0;
		src_1 <= 0;
		src_2 <= 0;
		carry_out <= 0;
	end else if (flush) begin
		PC <= 0;
		Instruction_out <= 0;
		Dest <= 0;
		Val_Rn <= 0;
		Val_Rm <=0;
		Signed_imm_24 <= 0;
		Shift_operand <= 0;
		EXE_CMD <= 0;
		MEM_R_EN <= 0;
		MEM_W_EN <= 0;
		WB_EN <= 0;
		imm <= 0;
		B <= 0;
		S <= 0;
		src_1 <= 0;
		src_2 <= 0;
		carry_out <= 0;
	end else if(freeze) begin
		PC <= PC;
		Instruction_out <= Instruction_out;
		Dest <= Dest;
		Val_Rn <= Val_Rn;
		Val_Rm <= Val_Rm;
		Signed_imm_24 <= Signed_imm_24;
		Shift_operand <= Shift_operand;
		EXE_CMD <= EXE_CMD;
		MEM_R_EN <= MEM_R_EN;
		MEM_W_EN <= MEM_W_EN;
		WB_EN <= WB_EN;
		imm <= imm;
		B <= B;
		S <= S;
		src_1 <= src_1;
		src_2 <= src_2;
		carry_out <= carry_out;
	end else begin
		PC <= PC_in;
		Instruction_out <= Instruction;
		Dest <= Dest_IN;
		Val_Rn <= Val_Rn_IN;
		Val_Rm <=Val_Rm_IN;
		Signed_imm_24 <= Signed_imm_24_IN;
		Shift_operand <= Shift_operand_IN;
		EXE_CMD <= EXE_CMD_IN;
		MEM_R_EN <= MEM_R_EN_IN;
		MEM_W_EN <= MEM_W_EN_IN;
		WB_EN <= WB_EN_IN;
		imm <= imm_IN;
		B <= B_IN;
		S <= S_IN;
		src_1 <= src_1_in;
		src_2 <= src_2_in;
		carry_out <= carry_in;
	end
		
  end

endmodule