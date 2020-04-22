module odliczanie(input button_hr_i,
                  input button_min_i,
                  input clk_i,
                  input div_clk,
                  output [1:0]hr1_o,
                  output [3:0]hr2_o,
                  output [3:0]min1_o,
                  output [3:0]min2_o
                 );
    reg[31:0] sec = 5'd0;
    reg[3:0] hr= 4'd0;
    reg[3:0] min= 4'd0;
    reg[31:0] licznik = 32'd0;
    
    
    function [3:0] mod_10;
    input [5:0] number;
    begin
    mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
    end
    endfunction

    always@(posedge clk_i, posedge button_hr_i, posedge button_min_i) begin
        if(button_hr_i == 1 )begin 
            licznik <= licznik + 32'd1;
            if(licznik >= 15) begin
                licznik <= 32'd0;
                hr <= hr + 4'd1;
            end
            if(hr >= 24)
                hr<= 4'd0;
        end
        if(button_min_i == 1 )begin 
            licznik <= licznik + 32'd1;
            if(licznik >= 15) begin
                licznik <= 32'd0;
                min <= min + 4'd1;
            end
            if(min >= 59) 
            min <= 4'd0;
        end
    end
    always@(posedge div_clk) begin 
        sec <= sec + 6'd1;
        if(sec >= 59) begin
            sec <= 32'd0;
            min <= min +4'd1;
        end
        if(min >= 59) begin
            min <= 4'd0;
            hr <= hr + 4'd1;
        end
        if(hr >= 24) begin
            hr <= 4'd0;
            min <= 4'd0;
            sec <= 32'd0;
        end
    end
    assign hr2_o = mod_10(hr);
    assign hr1_o = hr - hr2_o*10;
    assign min2_o = mod_10(min);
    assign min1_o = min - min2_o *10;
endmodule
