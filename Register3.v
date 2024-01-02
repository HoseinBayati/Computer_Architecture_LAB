module Register3(
	clk,
	rst,
	inp,
	outp
);

	input clk;
	input rst;
	input [2:0] inp;
	output reg [2:0] outp;

	always @(posedge clk, posedge rst) begin
		if (rst) 
			outp <= 0;
			else 
			outp <= inp;
	end

endmodule
