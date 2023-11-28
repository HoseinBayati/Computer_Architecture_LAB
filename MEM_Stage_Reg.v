module MEM_Stage_Reg (
	clk,
	rst,
	WB_en_in,
	Mem_R_en_in,
	PC_in,
	ALU_result_in,
	Mem_read_value_in,
	Dest_in,
	PC,
	WB_en,
	Mem_R_en,
	ALU_result,
	Mem_read_value,
	Dest
);
	input clk, rst, WB_en_in, Mem_R_en_in;
	input [31:0] PC_in;
  	input [31:0] ALU_result_in, Mem_read_value_in;
  	input [3:0] Dest_in;
  	output reg [31:0] PC;
  	output reg WB_en, Mem_R_en;
  	output reg [31:0] ALU_result, Mem_read_value;
  	output reg [3:0] Dest;

always @(posedge clk, posedge rst) begin
        if (rst) 
        begin
            PC <= 32'b0;
            WB_en <= 1'b0;
            Mem_R_en <= 1'b0;
            ALU_result <= 32'b0;
            Dest <= 4'b0;
            Mem_read_value <= 32'b0;
        end

        else begin
            PC <= PC_in;
            WB_en <= WB_en_in;
            Mem_R_en <= Mem_R_en_in;
            ALU_result <= ALU_result_in;
            Dest <= Dest_in;
            Mem_read_value <= Mem_read_value_in;
    	end
end

endmodule

