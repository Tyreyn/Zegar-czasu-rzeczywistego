module dzielnik (input clk_i,				//100MHZ
                 input rst_i,
                 input button_test_i,
                 input button_hr_i,
                 input button_min_i,
                 output[7:0] led7_seg_o,
                 output[7:0] led7_an_o
                );
    wire[3:0] min1,min2,hr1;
    wire[1:0]hr2;
    reg[31:0] div_clk = 32'd0;
    reg[31:0] div_clkFAST = 32'd0;
    reg[31:0] licznik = 32'd0;
    parameter N_norm = 32'd1000; // Dla symulacji 1000 dla płytki 100000000
    parameter N_fast = 32'd10;
    reg DIV = 0;
    reg [1:0] odswiezanie = 2'b00;
    reg kropka =1'b0;
    reg clkTEMP;
    wire clk_o;
    always @(posedge clk_i, negedge button_test_i) begin
        if(button_test_i == 1) begin
            DIV = 1;
        end
        else begin
            DIV = 0;
        end
    end

    always @(posedge clk_i, negedge rst_i) begin
        if(rst_i == 1) begin
            div_clk <=32'd0;
        end
        else begin
            div_clk <= div_clk + 32'd1;
            if(div_clk % 25 == 0) begin  // DLA PŁYTKI ZMIENIĆ NA 25000 = odswiezanie 3ms 
                if(div_clk != 0)
                odswiezanie <= odswiezanie +2'b1;    
            end

            if(div_clk>=N_norm) begin
                div_clk <= 32'd0;
                kropka =~kropka;
            end

        end
    end

    always @(posedge clk_i, negedge rst_i) begin
        if(rst_i == 1) begin
            div_clkFAST <=32'd0;
        end
        else begin
            div_clkFAST <= div_clkFAST + 32'd1;
            if(div_clkFAST>=N_fast)
                div_clkFAST <= 32'd0;
        end
    end
    always @(posedge clk_i,negedge rst_i)begin
        if(rst_i == 1 )begin
        end
        else begin
            if(DIV==1)begin
                clkTEMP <= (div_clkFAST<(N_fast/2))?1'b0:1'b1; 
            end
            else begin
                clkTEMP <= (div_clk<(N_norm/2))?1'b0:1'b1; 
            end
        end   
    end

    assign clk_o = clkTEMP; 
     
    odliczanie od_1(button_hr_i,button_min_i,clk_o,rst_i,hr1,hr2,min1,min2);
    wyswietl wy_1(hr1, hr2, min1, min2,odswiezanie,kropka,led7_seg_o,led7_an_o);
    

endmodule