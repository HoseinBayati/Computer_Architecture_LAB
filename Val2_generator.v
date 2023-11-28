module Val2_Generator(
	Rm,
	shift_operand,
	imm,
	Ld_St,
	in2
);

	input [31:0] Rm;
	input [11:0] shift_operand;
	input imm, Ld_St;
	output reg [31:0] in2;

	reg [31:0] temp = 0;
	integer i;

	always @(*) begin
		if(Ld_St == 1'b1)
				in2 = {{20{shift_operand[11]}}, shift_operand};
			else if(imm == 1'b1) begin
					temp = {24'b0, shift_operand[7:0]};
					for (i = 0; i < 2 * shift_operand[11:8]; i = i + 1) begin
						temp = {temp[0], temp[31:1]};
					end
					in2 = temp;
			end

			else begin
				case (shift_operand[6:5])
						2'b00: begin
								in2 = Rm << shift_operand[11:7];
						end
						2'b01: begin
								in2 = Rm >> shift_operand[11:7];
						end
						2'b10: begin
								in2 = Rm >>> shift_operand[11:7];
						end
						2'b11: begin
								in2 = Rm;
								for (i = 0; i < shift_operand[11:7]; i = i + 1) begin
									in2 = {in2[0], in2[31:1]};
								end
						end
					endcase
			end
	end

endmodule
