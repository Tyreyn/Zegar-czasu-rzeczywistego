module odliczanie(input button_hr_i,
                  input button_min_i,
                  input div_clk,
                  input rst_i,
                  output [3:0]hr1_o,
                  output [1:0]hr2_o,
                  output [3:0]min1_o,
                  output [3:0]min2_o
                 );
    reg[6:0] sec = 5'd0;
    reg[5:0] hr= 4'd0;
    reg[6:0] min= 4'd0;
    reg[31:0] licznik = 32'd0;

    always @(posedge div_clk, negedge button_min_i, negedge button_hr_i, negedge rst_i) begin
        if(rst_i==1)begin
            sec <= 6'd0;
            hr <= 5'd0;
            min <= 6'd0;
        end
        else begin
        if(button_min_i == 1 )begin 
        
            licznik <= licznik + 32'd1;
            
            if(licznik >= 2) begin  // Dla płytki 2000 = 50ms drgań
            
                licznik <= 32'd0;
                min <= min + 6'd1;
                
            end
            if(min >= 59) 
            min <= 6'd0;
        end
            
        else if(button_hr_i == 1 )begin 
        
            licznik <= licznik + 32'd1;
            
            if(licznik >= 2) begin   //Dla płytki 2000 = 50ms drgań
                licznik <= 32'd0;
                hr <= hr + 5'd1;
            end
            
            if(hr >= 24)
                hr<= 5'd0;          
            
            
        end
        else begin
        sec <= sec + 6'd1;
        if(sec >= 59) begin
            sec <= 6'd0;
            min <= min +6'd1;
        end
        if(min >= 59) begin
            min <= 6'd0;
            hr <= hr + 5'd1;
        end
        if(hr >= 24) begin
            hr <= 6'd0;
            min <= 6'd0;
            sec <= 32'd0;
        end
        end
        end
    end
    
    assign hr2_o = hr % 10;
    assign hr1_o = hr / 10;
    assign min2_o = min % 10;
    assign min1_o = min / 10;
endmodule
