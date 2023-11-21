module Condition_Check (
	conditions,
	stat_regs,
	check
);
	input [3:0] conditions;
	input [3:0] stat_regs;
	output reg check;

	wire Z, C, N, V;
	assign {Z, C, N, V} = stat_regs;

	parameter[3:0]  EQ = 4'd0,
			NE = 4'd1,
			CS_OR_HS = 4'd2, 
			CC_OR_LO = 4'd3, 
			MI = 4'd4,
			PL = 4'd5, 
			VS = 4'd6, 
			VC = 4'd7, 
			HI = 4'd8, 
			LS = 4'd9, 
			GE = 4'd10, 
			LT = 4'd11,
				GT = 4'd12, 
			LE = 4'd13, 
			AL = 4'd14;

	always @(*) begin
		case(conditions)
			EQ : check = Z;
			NE : check = ~Z;
			CS_OR_HS : check = C;
			CC_OR_LO : check = ~C;
			MI : check = N;
			PL : check = ~N;
			VS : check = V;
			VC : check = ~V;
			HI : check = (C & ~Z);
			LS : check = (~C & Z);
			GE : check = ((N & V) | (~N & ~V));
			LT : check = ((N & ~V) | (~N & V));
			GT : check = (~Z & ((N & V) | (~N & ~V)));
			LE : check = (Z & ((N & ~V) | (~N & V)));
			AL : check = 1'b1;
			default: check <= 0;
		endcase
	end

endmodule
