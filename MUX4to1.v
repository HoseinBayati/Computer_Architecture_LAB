module MUX4to1(
  	select,
  	input1,
	input2,
	input3,
	input4,
  	outp
);

	input [1:0] select;
  	input [31:0] input1, input2, input3, input4;
  	output reg [31:0] outp;

	always@(select or input1 or input2 or input3 or input4) begin
			outp = 0;
			case(select)
				2'b00: outp = input1;
				2'b01: outp = input2;
				2'b10: outp = input3;
				2'b11: outp = input4;
				default: outp = 0;
			endcase
	end

endmodule
