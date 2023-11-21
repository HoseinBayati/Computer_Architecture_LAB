module Memory(
    input clk, rst, mem_write, mem_read, 
    input [31:0] address, 
    input [31:0] data,
    output reg [31:0] res);

reg [31:0] mem [0:63];
  
always@(*)begin
	if(mem_read)
		res <= mem[(address - 1024) >> 2];
	else
		res <= 0;
end
  
always@(posedge clk)begin
    	if(mem_write)begin
        	mem[(address - 1024) >> 2] <= data;
   	 end
end

endmodule



