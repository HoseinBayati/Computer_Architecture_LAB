module Control_Unit (
	mode,
	opcode,
	s,
	EXE_Command,
	mem_read,
	mem_write,
	WB_Enable,
	B,
	Status_Update
);

	input [1:0] mode;
	input [3:0] opcode;
	input s;
	output [3:0] EXE_Command;
	output mem_read, mem_write;
	output WB_Enable;
	output B;
	output reg Status_Update;

	assign EXE_Command =  opcode == 4'b1101 ? 4'b0001 : 
						opcode == 4'b1111 ? 4'b1001 :
						opcode == 4'b0100 ? 4'b0010 :
						opcode == 4'b0101 ? 4'b0011 :
						opcode == 4'b0010 ? 4'b0100 :  
						opcode == 4'b0110 ? 4'b0101 :
						opcode == 4'b0000 ? 4'b0110 : 
						opcode == 4'b1100 ? 4'b0111 :
						opcode == 4'b0001 ? 4'b1000 :
						opcode == 4'b1010 ? 4'b0100 :
						opcode == 4'b1000 ? 4'b0110 :
			        	opcode == 4'b0100 ? 4'b0010 : 4'b1111;

	assign WB_Enable = !(opcode == 4'b1010) && !(opcode == 4'b1000) && !(mode == 2'b10) && !(mode == 2'b01 && s == 0);

	assign B = (mode == 2'b10) ? 1'b1 : 1'b0;

	assign mem_read = (mode == 2'b01 && s == 1) ? 1'b1 : 1'b0;

	assign mem_write = (mode == 2'b01 && s == 0) ? 1'b1 : 1'b0;


	always@(*)begin
			if(mode == 2'b00)
				Status_Update <= s;
			else
				Status_Update <= 0;
	end
	
endmodule