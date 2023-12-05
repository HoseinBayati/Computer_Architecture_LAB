module Hazard_Detection_Unit(
	src1,
	src2,
	Exe_Dest,
	Exe_WB_EN,
	Mem_Dest,
	Mem_WB_EN,
	With_Two_Source,
	Forwarding_Enable,
	EXE_mem_read,
	hazard_Detected
);

	input [3:0] src1;
	input [3:0] src2;
	input [3:0] Exe_Dest;
	input Exe_WB_EN;
	input [3:0] Mem_Dest;
	input Mem_WB_EN;
	input With_Two_Source;
	input Forwarding_Enable;
	input EXE_mem_read;
	output hazard_Detected;

	wire hazard_Detected_without_forwarding, hazard_Detected_with_forwarding;

	assign hazard_Detected_without_forwarding = (( Exe_WB_EN == 1'b1 & src1 == Exe_Dest ) | 
				( Mem_WB_EN == 1'b1 & src1 == Mem_Dest ) | 
							( Exe_WB_EN == 1'b1 & src2 == Exe_Dest & With_Two_Source == 1'b1) | 
							( Mem_WB_EN == 1'b1 & src2 == Mem_Dest & With_Two_Source == 1'b1)) ? 1'b1 : 1'b0;


	assign hazard_Detected_with_forwarding = ((src1 == Exe_Dest & Exe_WB_EN == 1'b1) | 
										(src2 == Exe_Dest & Exe_WB_EN == 1'b1 & With_Two_Source == 1'b1)) ? 1'b1 : 1'b0; 

	assign hazard_Detected = Forwarding_Enable ? (hazard_Detected_with_forwarding & EXE_mem_read) :  
											hazard_Detected_without_forwarding;

endmodule