module odliczanie_tb;
  reg clk_i,button_hr_i,button_min_i,div_clk;
  reg[3:0] hr,min;
  wire [1:0] hr1_o;
  wire [3:0] hr2_o;
  wire [3:0] min1_o;
  wire [3:0] min2_o;
    odliczanie UUT (.button_hr_i(button_hr_i),
                    .button_min_i(button_min_i),
                    .clk_i(clk_i),
                    .div_clk(div_clk),
                    .hr1_o(hr1_o),
                    .hr2_o(hr2_o),
                    .min1_o(min1_o),
                    .min2_o(min2_o)
                    );
  
  
  
    initial begin
        div_clk = 0;
        button_hr_i = 0;
        button_min_i = 0;
        clk_i = 0;
        

        
    end   
    initial begin 
        repeat(75)
        #10 clk_i = ~clk_i;
        repeat(20)
        #10 clk_i = ~clk_i;
        button_hr_i = 1;
        repeat(100)
        #10 clk_i = ~clk_i;
        button_hr_i = 1;

        button_hr_i = 0;
        button_min_i = 1;
        repeat(100)
        #10 clk_i = ~clk_i;
        button_min_i = 0;
        clk_i=0;
        repeat(20000)
        #10 div_clk = ~div_clk;
    end
endmodule