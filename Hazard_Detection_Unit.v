module hazard_Detection_Unit(
	src1,
	src2,
	Exe_Dest,
	Exe_WB_EN,
	Mem_Dest,
	Mem_WB_EN,
	With_Two_Source,
	hazard_Detected
);
	input [3:0] src1;
	input [3:0] src2;
	input [3:0] Exe_Dest;
	input Exe_WB_EN;
	input [3:0] Mem_Dest;
	input Mem_WB_EN;
	input With_Two_Source;
	output hazard_Detected;

	assign hazard_Detected = (( Exe_WB_EN == 1'b1 & src1 == Exe_Dest ) | 
				( Mem_WB_EN == 1'b1 & src1 == Mem_Dest ) | 
							( Exe_WB_EN == 1'b1 & src2 == Exe_Dest & With_Two_Source == 1'b1) | 
							( Mem_WB_EN == 1'b1 & src2 == Mem_Dest & With_Two_Source == 1'b1)) ? 1'b1 : 1'b0;

endmodule
	
