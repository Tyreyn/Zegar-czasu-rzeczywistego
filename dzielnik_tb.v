module dzielnik_tb;
  reg clk_i,rst_i,button_test_i,button_hr_i,button_min_i;
  wire [7:0]led7_an_o,led7_seg_o;  

    dzielnik UUT(.clk_i(clk_i),
            .rst_i(rst_i),
            .button_test_i(button_test_i),
            .button_hr_i(button_hr_i),
            .button_min_i(button_min_i),
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
    always
        #5 clk_i = ~clk_i;
    initial begin
        #10000 button_test_i = 1;
        #50000 button_test_i = 0;
        #10000 button_hr_i = 1;
        #40000 button_hr_i =0;
    end
endmodule