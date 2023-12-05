module Forwrding_Unit (
	Forwarding_Enable,
  	src1,
	src2,
  	MEM_WB_EN,
	WB_EN,
  	MEM_Dest,
	WB_Dest,
  	Sel_Src1,
	Sel_Src2
);

	input Forwarding_Enable;
  	input [3:0] src1, src2;
  	input MEM_WB_EN, WB_EN;
  	input [3:0] MEM_Dest, WB_Dest;
  	output reg [1:0] Sel_Src1, Sel_Src2;

	always @(*) begin
			Sel_Src1 = 2'b00;
			Sel_Src2 = 2'b00;
			if(Forwarding_Enable) begin
				if ((src1 == MEM_Dest) && (MEM_WB_EN == 1'b1))
						Sel_Src1 = 2'b01;
				else if ((src1 == WB_Dest) && (WB_EN == 1'b1))
						Sel_Src1 = 2'b10;
				if ((src2 == MEM_Dest) && (MEM_WB_EN == 1'b1))
						Sel_Src2 = 2'b01;
				else if ((src2 == WB_Dest) && (WB_EN == 1'b1))
						Sel_Src2 = 2'b10;
			end
	end

endmodule