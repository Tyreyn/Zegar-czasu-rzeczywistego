module dzielnik_tb;
  reg clk_i,rst_i,button_test_i;
  wire div_clk;
  
    dzielnik UUT(.clk_i(clk_i),
            .rst_i(rst_i),
            .button_test_i(button_test_i),
            .div_clk(div_clk)
            );
  
  
  
    initial begin
        rst_i = 0;
        clk_i = 0;
        button_test_i = 0;
    end   
    initial begin 
        repeat(75)
        #10 clk_i = ~clk_i;
        rst_i = 1 ;

        repeat(20)
        #10 clk_i = ~clk_i;
        rst_i = 0;
        button_test_i = 1;

        repeat(100)
        #10 clk_i = ~clk_i;
        button_test_i = 0;
        
        repeat(100)
        #10 clk_i = ~clk_i;
    end
endmodule