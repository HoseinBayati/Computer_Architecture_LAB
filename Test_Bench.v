module Test_Bench();

reg clk = 0;
reg rst = 1;

initial begin
    #10 rst = ~rst;
    #10 rst = ~rst;
    #10 rst = ~rst;
end 

initial repeat(3000)begin
    #20 clk = ~clk;
end

TOP_ARM arm(clk,rst);

endmodule
