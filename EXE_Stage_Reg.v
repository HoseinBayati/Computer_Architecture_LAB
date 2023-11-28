module EXE_Stage_Reg (
	clk,
	rst,
	freeze,
	flush,
	WB_en_in,
	MEM_R_EN_in,
	MEM_W_EN_in,
	PC_in,
	ALU_result_in,
	ST_val_in,
	Dest_in,	
	PC,
	WB_en,
	MEM_R_EN,
	MEM_W_EN,
	ALU_result,
	ST_val,
	Dest
);

	input clk;
	input rst;
	input freeze, flush;
	input WB_en_in, MEM_R_EN_in, MEM_W_EN_in;
	input [31:0] PC_in;
	input [31:0] ALU_result_in, ST_val_in;
	input [3:0] Dest_in;
	output reg [31:0] PC;
	output reg WB_en, MEM_R_EN, MEM_W_EN;
	output reg [31:0] ALU_result, ST_val;
	output reg [3:0] Dest;

	always @(posedge clk, posedge rst) begin
			if (rst) 
			begin
				PC <= 0;
			WB_en <= 0;
			MEM_R_EN <= 0;
			MEM_W_EN <= 0;
			ALU_result <= 0;
			ST_val <= 0;
			Dest <= 0;
			end

			else begin
				PC <= PC_in;
				WB_en <= WB_en_in;
				MEM_R_EN <= MEM_R_EN_in;
				MEM_W_EN <= MEM_W_EN_in;
			ALU_result <= ALU_result_in;
				ST_val <= ST_val_in;
				Dest <= Dest_in;
			end 
	end

endmodule