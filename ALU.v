module ALU(
	in1,
	in2,
	EXE_Command,
	C,
	result,
	status
);

	input [31:0] in1, in2;
	input [3:0] EXE_Command;
	input C;
	output reg [31:0] result;
	output [3:0] status;

	reg V1, C1;
	wire N1, Z1;

	always @(*) begin
		V1 = 1'b0;
			C1 = 1'b0;
			case (EXE_Command)
				4'b0001: begin
					result = in2;
					end
					4'b1001: begin
						result = ~in2;
					end
					4'b0010: begin
							{C1, result} = in1 + in2;
						V1 = (in1[31] & in2[31] & !result[31]) || (!in1[31] & !in2[31] & result[31]);
					end
					4'b0011: begin
							{C1, result} = in1 + in2 + C;
						V1 = (in1[31] & in2[31] & !result[31]) || (!in1[31] & !in2[31] & result[31]);
					end
					4'b0100: begin
						{C1, result} = in1 - in2;
						V1 = (!in1[31] & in2[31] & result[31]) || (in1[31] & !in2[31] & !result[31]);

					end
					4'b0101: begin
						{C1, result} = in1 + ~in2 + C;
						V1 = (!in1[31] & in2[31] & result[31]) || (in1[31] & !in2[31] & !result[31]);
				end
					4'b0110: begin
						result = in1 & in2;
				end
				4'b0111: begin
							result = in1 | in2;
				end
					4'b1000: begin
						result = in1 ^ in2;
				end
				4'b0100: begin
							result = in1 - in2;
					end
					4'b0110: begin
							result = in1 & in2;
					end
					4'b0010: begin
							result = in1 + in2;
					end
					default:
						result = 32'b0;

			endcase
		end

	assign status = {Z1, C1, N1, V1};

	assign N1 = result[31];
	assign Z1 = ~(|result);

endmodule