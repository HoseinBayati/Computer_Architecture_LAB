module Status_Register (
	clk,
	rst,
	s,
	status_in,
	status_out
);
	input clk;
	input rst;
	input s;
   	input [3:0] status_in;
   	output reg [3:0] status_out;

	always @(negedge clk or posedge rst) begin
		if(rst) begin
				status_out <= 0;
		end  
		else if(s) begin
				status_out <= status_in;
		end
		else begin
				status_out <= status_out;
		end    
	end
endmodule
