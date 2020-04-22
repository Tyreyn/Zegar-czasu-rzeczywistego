module dzielnik (input clk_i,				//100MHZ
              input rst_i,
              input button_test_i,
              output div_clk
              
             );
    reg[32:0] licznik = 32'd0;
    parameter N_norm = 32'd8;
    parameter N_fast = 32'd2;
    integer DIV = N_norm;

    always @(posedge clk_i, posedge button_test_i) begin
        if(button_test_i == 1) begin
            DIV = N_fast;
        end
        else begin
            DIV = N_norm;
        end
    end

    always @(posedge clk_i, negedge rst_i) begin
        if(rst_i == 1 ) begin
        licznik <= 32'd0;
    end
    else begin   
        licznik <= licznik + 32'd1;
        if(licznik>=(DIV-1))
  		    licznik <= 32'd0;
        end
    end
  
    assign div_clk = (licznik<(DIV/2))?1'b0:1'b1;  

endmodule