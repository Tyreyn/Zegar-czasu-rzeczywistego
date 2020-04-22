module dzielnik_tb;
  reg clk_i,rst_i,button_test_i,button_hr_i,button_min_i;
  wire [7:0]led7_an_o,led7_seg_o;
  wire div_clk;
  
    dzielnik UUT(.clk_i(clk_i),
            .rst_i(rst_i),
            .button_test_i(button_test_i),
            .button_hr_i(button_hr_i),
            .button_min_i(button_min_i),
            .div_clk(div_clk),
            .led7_seg_o(led7_seg_o),
            .led7_an_o(led7_an_o)
            );
  
  
  
    initial begin
        rst_i = 0;
        clk_i = 0;
        button_test_i = 0;
        button_hr_i = 0;
        button_min_i = 0;
    end   
    initial begin 
        repeat(75)
        #10 clk_i = ~clk_i;  
        button_min_i=1;      
        repeat(200)
        #10 clk_i = ~clk_i;
        button_min_i=0;
        
        button_hr_i = 1;
        repeat(100)
        #10 clk_i = ~clk_i;
        button_hr_i = 0;
        button_test_i = 1;
        repeat(10000)
        #10 clk_i = ~clk_i;
    end
endmodule