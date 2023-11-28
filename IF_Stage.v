module IF_Stage (
	clk,
	rst,
	freeze,
	Branch_taken,
	BranchAddr,
	PC,
	Instruction
);

	input clk, rst, freeze, Branch_taken;
	input[31:0] BranchAddr;
	output[31:0] PC, Instruction;

	reg [31:0] PC_Reg;
	reg [31:0] Instruction_Memory [0:46];
	
	initial begin
		PC_Reg = 32'b0;	 
		Instruction_Memory[0] = 32'b1110_00_1_1101_0_0000_0000_000000010100; //MOV R0 ,#20 //R0 = 20
		Instruction_Memory[1] = 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV R1 ,#4096 //R1 = 4096
		Instruction_Memory[2] = 32'b1110_00_1_1101_0_0000_0010_000100000011; //MOV R2 ,#0xC0000000 //R2 = -1073741824
		Instruction_Memory[3] = 32'b1110_00_0_0100_1_0010_0011_000000000010; //ADDS R3 ,R2,R2 //R3 = -2147483648
		Instruction_Memory[4] = 32'b1110_00_0_0101_0_0000_0100_000000000000; //ADC R4 ,R0,R0 //R4 = 41
		Instruction_Memory[5] = 32'b1110_00_0_0010_0_0100_0101_000100000100; //SUB R5 ,R4,R4,LSL #2 //R5 = -123
		Instruction_Memory[6] = 32'b1110_00_0_0110_0_0000_0110_000010100000; //SBC R6 ,R0,R0,LSR #1 //R6 = 10
		Instruction_Memory[7] = 32'b1110_00_0_1100_0_0101_0111_000101000010; //ORR R7 ,R5,R2,ASR #2 //R7 = -123
		Instruction_Memory[8] = 32'b1110_00_0_0000_0_0111_1000_000000000011; //AND R8 ,R7,R3 //R8 = -2147483648
		Instruction_Memory[9] = 32'b1110_00_0_1111_0_0000_1001_000000000110; //MVN R9 ,R6 //R9 = -11
		Instruction_Memory[10] = 32'b1110_00_0_0001_0_0100_1010_000000000101; //EOR R10,R4,R5 //R10 = -84
		Instruction_Memory[11] = 32'b1110_00_0_1010_1_1000_0000_000000000110; //CMP R8 ,R6
		Instruction_Memory[12] = 32'b0001_00_0_0100_0_0001_0001_000000000001; //ADDNE R1 ,R1,R1 //R1 = 8192
		Instruction_Memory[13] = 32'b1110_00_0_1000_1_1001_0000_000000001000; //TST R9 ,R8
		Instruction_Memory[14] = 32'b0000_00_0_0100_0_0010_0010_000000000010; //ADDEQ R2 ,R2,R2 //R2 = -1073741824
		Instruction_Memory[15] = 32'b1110_00_1_1101_0_0000_0000_101100000001; //MOV R0 ,#1024 //R0 = 1024
		Instruction_Memory[16] = 32'b1110_01_0_0100_0_0000_0001_000000000000; //STR R1 ,[R0],#0 //MEM[1024] = 8192
		Instruction_Memory[17] = 32'b1110_01_0_0100_1_0000_1011_000000000000; //LDR R11,[R0],#0 //R11 = 8192
	end

	always@(posedge clk, posedge rst) begin
			if(rst)
				PC_Reg <= 32'b0;
		else if(!freeze) begin
			if(Branch_taken)
				PC_Reg <= BranchAddr;
				else
					PC_Reg <= PC_Reg + 4;
		end
	end

	
	assign Instruction = Instruction_Memory[PC_Reg >> 2];
	assign PC = PC_Reg + 4;

endmodule