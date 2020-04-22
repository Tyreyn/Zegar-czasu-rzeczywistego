module dzielnik (input clk_i,				//100MHZ
                 input rst_i,
                 input button_test_i,
                 input button_hr_i,
                 input button_min_i,
                 output div_clk,
                 output[7:0] led7_seg_o,
                 output[7:0] led7_an_o
                );
    wire[3:0] min1,min2,hr1;
    wire[1:0]hr2;
    wire[7:0] an_o,seg_o;
    assign hr2_o =2'b00;
    assign hr1_o =4'b0000;
    assign min1_o =4'b0000;
    assign min2_o =4'b0000;
    reg[31:0] licznik = 32'd0;
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
    odliczanie od_1(button_hr_i,button_min_i,clk_i,div_clk,hr1,hr2,min1,min2);
    wyswietl wy_1(div_clk, hr1, hr2, min1, min2,licznik[1:0],seg_o,an_o);
    assign seg_o[7]=div_clk;
    assign led7_an_o = an_o;
    assign led7_seg_o = seg_o;

endmodule