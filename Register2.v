module Register2(
	clk,
	rst,
	inp,
	outp
);

	input clk;
	input rst;
	input [1:0] inp;
	output reg [1:0] outp;

	always @(posedge clk, posedge rst) begin
		if (rst)
			outp <= 0;
			else 
			outp <= inp;
	end

endmodule
